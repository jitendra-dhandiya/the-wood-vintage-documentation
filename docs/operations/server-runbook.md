# Production server runbook (Wood Vintage)

Host: single Ubuntu 24.04 VPS `45.195.129.38` (2 vCPU / 3.7 GB RAM / 48 GB disk). Provisioned 2026-09-24
with `docs/operations/server/provision.sh` (idempotent, no secrets in it). Decision: `0038`.

## Access
- SSH key-only. Password auth OFF, root login key-only (`/etc/ssh/sshd_config.d/00-hardening.conf`).
  Day-to-day user: `deploy` (sudo, NOPASSWD). Authorised keys live in `~/.ssh/authorized_keys` of `root`/`deploy`.
- Add a teammate/laptop: append their public key to `/home/deploy/.ssh/authorized_keys`.
- Firewall (ufw): 22, 80, 443 only. fail2ban `sshd` jail (4 tries → 1 h ban). MySQL listens on 127.0.0.1 only.
- The root password was shared in chat during setup — treat it as burned; it is unused now (password auth off).

## Layout
| Path | Purpose |
|---|---|
| `/var/www/wood-vintage/{backend,frontend}` | git clones (deploy user) |
| `/var/lib/wood-vintage/uploads`, `/var/lib/wood-vintage/image-cache` | persistent user uploads + image derivative cache (survive deploys) |
| `/var/log/wood-vintage/` | app + backup logs (pm2-logrotate 20 MB × 14) |
| `/var/backups/wood-vintage/` | nightly `mysqldump` 02:30 (14 days), uploads tarball Sundays |
| `/root/.wv-secrets/db_password` | MySQL `wv_app` password (root-only, mode 600) |

## Stack
Nginx (TLS, HTTP/2, rate limits, `/img` proxy cache) → Next.js (:3000, PM2 cluster) and Express API (:5000,
PM2 cluster) → MySQL 8 (localhost). Node 20, PM2 under systemd (`pm2-deploy`).

## Multi-country notes
- One domain, subdirectory per country (`/in`, `/us` — decision 0004). Single deployment serves every market.
- Geo lock (decision 0036) needs the real client IP: nginx must OVERWRITE `X-Forwarded-For` with `$remote_addr`
  and the API must only listen on 127.0.0.1; then set `GEO_TRUST_PROXY=true`. If a CDN (Cloudflare) is put in
  front later, switch to its `CF-Connecting-IP` / `cf-ipcountry` and restrict nginx to CDN ranges.
- Enabled markets are data (Admin → Countries); no redeploy to add a country.

## Operations
- Backups: `/usr/local/bin/wv-backup.sh` (cron). Restore: `gunzip -c db_<ts>.sql.gz | mysql wood_vintage`.
  Copy backups off-host (not yet configured — see technical debt).
- Logs: `pm2 logs`, `/var/log/nginx/`, `/var/log/mysql/slow.log`. Status: `pm2 status`, `systemctl status nginx mysql`.

## Deployed state (2026-09-24)
- Live at https://thewoodvintage.com (India market only; `noindex` header until go-live — remove the
  `X-Robots-Tag` line in `/etc/nginx/sites-available/thewoodvintage.com` and reload nginx).
- Deploy: `ssh deploy@45.195.129.38 '~/deploy.sh [backend|frontend|all]'` (script: `docs/operations/server/deploy.sh`).
  A frontend build takes ~10 min on this CPU; PM2 cluster reload keeps the old build serving meanwhile.
- Gotchas learned: (1) the VPS CPU model lacks SSSE3/SSE4 so sharp's prebuilt libvips crashes — deploy.sh rebuilds
  sharp 0.33.2 against system libvips; ask the provider for a `host` CPU model. (2) nginx overwrites X-Forwarded-For, so
  the Next middleware calls the API over `INTERNAL_API_URL=http://127.0.0.1:5000/api/v1` (build-time + PM2 env) to keep
  the visitor IP for the geo lock. (3) Next behind nginx builds request URLs as https://localhost:3000; the region page
  therefore uses a redirect (not a rewrite) and nginx has a `proxy_redirect` safety net.
- Catalogue: boilerplate (categories, collections, homepage, banners, blogs, artisans, taxonomies, settings) matches local;
  only 2 products (hand-carved-krishna-panel, channapatna-stacking-rings), available in IN only.
