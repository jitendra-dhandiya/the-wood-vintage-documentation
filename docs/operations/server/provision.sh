#!/usr/bin/env bash
# Wood Vintage — base server provisioning (Ubuntu 24.04, run once as root; idempotent).
# Contains NO secrets. DB password is generated on the host and kept in /root/.wv-secrets.
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

echo "== 1. packages"
apt-get update -y
apt-get upgrade -y
apt-get install -y ufw fail2ban nginx mysql-server curl git build-essential unzip htop \
  logrotate chrony certbot python3-certbot-nginx rsync jq ca-certificates gnupg

echo "== 2. node 20 + pm2"
if ! command -v node >/dev/null || ! node -v | grep -q '^v20'; then
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
  apt-get install -y nodejs
fi
command -v pm2 >/dev/null || npm i -g pm2

echo "== 3. swap (2G) + sysctl"
if ! swapon --show | grep -q /swapfile; then
  fallocate -l 2G /swapfile && chmod 600 /swapfile && mkswap /swapfile && swapon /swapfile
  grep -q '^/swapfile' /etc/fstab || echo '/swapfile none swap sw 0 0' >> /etc/fstab
fi
cat > /etc/sysctl.d/99-wv.conf <<'EOF'
vm.swappiness=10
net.core.somaxconn=4096
net.ipv4.tcp_syncookies=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.all.send_redirects=0
fs.file-max=200000
EOF
sysctl --system >/dev/null

echo "== 4. ssh hardening (00- prefix wins over cloud-init's 50- file)"
cat > /etc/ssh/sshd_config.d/00-hardening.conf <<'EOF'
PasswordAuthentication no
KbdInteractiveAuthentication no
PermitRootLogin prohibit-password
MaxAuthTries 3
LoginGraceTime 30
X11Forwarding no
AllowTcpForwarding no
ClientAliveInterval 300
ClientAliveCountMax 2
EOF
sshd -t && systemctl reload ssh

echo "== 5. firewall + fail2ban"
ufw default deny incoming; ufw default allow outgoing
ufw allow OpenSSH; ufw allow 80/tcp; ufw allow 443/tcp
ufw --force enable
cat > /etc/fail2ban/jail.d/wv.local <<'EOF'
[sshd]
enabled = true
maxretry = 4
findtime = 10m
bantime = 1h
EOF
systemctl enable --now fail2ban; systemctl restart fail2ban

echo "== 6. unattended security upgrades (no auto reboot)"
cat > /etc/apt/apt.conf.d/52wv-unattended <<'EOF'
Unattended-Upgrade::Automatic-Reboot "false";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
EOF

echo "== 7. mysql 8 (localhost only) + app db/user"
cat > /etc/mysql/mysql.conf.d/99-wv.cnf <<'EOF'
[mysqld]
bind-address = 127.0.0.1
mysqlx = OFF
character-set-server = utf8mb4
collation-server = utf8mb4_0900_ai_ci
innodb_buffer_pool_size = 1G
innodb_log_file_size = 256M
innodb_flush_log_at_trx_commit = 1
max_connections = 120
slow_query_log = 1
slow_query_log_file = /var/log/mysql/slow.log
long_query_time = 1
skip_name_resolve = 1
EOF
systemctl enable --now mysql; systemctl restart mysql
install -d -m 700 /root/.wv-secrets
if [ ! -f /root/.wv-secrets/db_password ]; then
  openssl rand -base64 30 | tr -d '=+/\n' | cut -c1-32 > /root/.wv-secrets/db_password
  chmod 600 /root/.wv-secrets/db_password
fi
DBPW=$(cat /root/.wv-secrets/db_password)
mysql <<SQL
CREATE DATABASE IF NOT EXISTS wood_vintage CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
CREATE USER IF NOT EXISTS 'wv_app'@'localhost' IDENTIFIED BY '${DBPW}';
ALTER USER 'wv_app'@'localhost' IDENTIFIED BY '${DBPW}';
GRANT ALL PRIVILEGES ON wood_vintage.* TO 'wv_app'@'localhost';
FLUSH PRIVILEGES;
SQL

echo "== 8. app directories"
install -d -o deploy -g deploy /var/www/wood-vintage
install -d -o deploy -g deploy /var/lib/wood-vintage/uploads /var/lib/wood-vintage/image-cache
install -d -o deploy -g deploy /var/log/wood-vintage
install -d -m 700 /var/backups/wood-vintage

echo "== 9. backups (mysqldump daily 02:30, keep 14 days; uploads weekly)"
cat > /usr/local/bin/wv-backup.sh <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
D=/var/backups/wood-vintage; TS=$(date +%F_%H%M)
CNF=$(mktemp); trap 'rm -f "$CNF"' EXIT
printf "[client]\nuser=wv_app\npassword=%s\n" "$(cat /root/.wv-secrets/db_password)" > "$CNF"
mysqldump --defaults-extra-file="$CNF" --single-transaction --routines --triggers wood_vintage | gzip > "$D/db_$TS.sql.gz"
if [ "$(date +%u)" = "7" ]; then tar -czf "$D/uploads_$TS.tar.gz" -C /var/lib/wood-vintage uploads; fi
find "$D" -type f -mtime +14 -delete
EOF
chmod 700 /usr/local/bin/wv-backup.sh
echo '30 2 * * * root /usr/local/bin/wv-backup.sh >> /var/log/wood-vintage/backup.log 2>&1' > /etc/cron.d/wv-backup

echo "== 10. nginx base (default deny + hardening)"
cat > /etc/nginx/conf.d/00-wv-base.conf <<'EOF'
server_tokens off;
limit_req_zone $binary_remote_addr zone=wv_api:10m rate=20r/s;
limit_req_zone $binary_remote_addr zone=wv_auth:10m rate=5r/m;
limit_req_zone $binary_remote_addr zone=wv_lead:10m rate=10r/m;
limit_conn_zone $binary_remote_addr zone=wv_conn:10m;
gzip_comp_level 5; gzip_min_length 1024; gzip_proxied any; gzip_vary on;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml image/svg+xml;
proxy_cache_path /var/cache/nginx/wv_img levels=1:2 keys_zone=wv_img:20m max_size=2g inactive=30d use_temp_path=off;
EOF
install -d -o www-data -g www-data /var/cache/nginx/wv_img
rm -f /etc/nginx/sites-enabled/default
cat > /etc/nginx/sites-available/00-default-deny <<'EOF'
server { listen 80 default_server; listen [::]:80 default_server; server_name _; return 444; }
EOF
ln -sf /etc/nginx/sites-available/00-default-deny /etc/nginx/sites-enabled/00-default-deny
nginx -t && systemctl enable --now nginx && systemctl reload nginx

echo "== 11. pm2 on boot for deploy user + logrotate"
sudo -u deploy -H pm2 startup systemd -u deploy --hp /home/deploy | tail -1 | bash || true
sudo -u deploy -H pm2 install pm2-logrotate >/dev/null 2>&1 || true
sudo -u deploy -H pm2 set pm2-logrotate:max_size 20M >/dev/null 2>&1 || true
sudo -u deploy -H pm2 set pm2-logrotate:retain 14 >/dev/null 2>&1 || true

echo "== done"; node -v; nginx -v 2>&1; mysql --version; ufw status | head -8
