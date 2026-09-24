# 0038. Production server: single hardened VPS, key-only SSH, PM2 + Nginx + local MySQL

Date: 2026-09-24

## Decision
Provision `45.195.129.38` (Ubuntu 24.04, 2 vCPU/3.7 GB) as a single-node production host: Nginx → Next.js
+ Express (PM2 cluster, systemd) → MySQL 8 on localhost. One domain, subdirectory-per-country (0004), one
deployment for all markets. Details and layout: `docs/operations/server-runbook.md`; script:
`docs/operations/server/provision.sh`.

## Hardening applied
Key-only SSH (password auth off, root key-only), `deploy` sudo user, ufw 22/80/443, fail2ban, unattended
security upgrades (no auto-reboot), 2 GB swap, sysctl tuning, MySQL bound to 127.0.0.1 with a dedicated
`wv_app` user and generated password, nightly compressed dumps (14-day retention), Nginx default-deny server,
`server_tokens off`, rate-limit zones for API/auth/leads, PM2 log rotation.

## Consequences / open
- Single node = single point of failure; 3.7 GB RAM is tight for MySQL(1 GB pool)+API+Next+image encoding —
  keep `SHARP_CONCURRENCY`/`IMAGE_BACKGROUND_CONCURRENCY` low, watch swap; resize before real traffic.
- Off-host backups, monitoring/alerting, a CDN, and a staging environment are not set up yet.
- TLS + Nginx vhost + app deploy wait on: the domain name/DNS, and the server's GitHub key being added.
- Repo PM2 configs still carry legacy names (`luxestore-api`, cwd `/var/www/ud-webiste/ud-c`); replace during
  first deploy.
