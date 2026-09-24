#!/usr/bin/env bash
# Wood Vintage — zero-downtime deploy. Run as `deploy` on the server:  ~/deploy.sh [backend|frontend|all]
# Pulls main, installs, builds, migrates, then PM2 rolling-reloads (cluster mode => no dropped requests).
# Aborts (and leaves the running version untouched) if any build/migration step fails.
set -euo pipefail
WHAT="${1:-all}"
ROOT=/var/www/wood-vintage
DOMAIN=thewoodvintage.com
log(){ printf '\n\033[1;33m== %s\033[0m\n' "$*"; }

deploy_backend() {
  cd "$ROOT/backend"
  log "backend: pull"; git fetch -q origin && git reset -q --hard origin/main
  log "backend: install"; npm ci --no-audit --no-fund
  # This VPS's virtual CPU has no SSSE3/SSE4, which sharp's prebuilt libvips needs. Rebuild sharp against
  # the system libvips (apt: libvips-dev). Drop this block once the host exposes a modern CPU model.
  if ! node -e 'require("sharp")' 2>/dev/null; then
    log "backend: rebuilding sharp against system libvips"
    SHARP_FORCE_GLOBAL_LIBVIPS=1 npm install sharp@0.33.2 --build-from-source --no-save --no-audit --no-fund
  fi
  npx prisma generate >/dev/null
  log "backend: build"; npm run build
  log "backend: migrate"; npx prisma migrate deploy
  log "backend: reload"
  pm2 describe wv-api >/dev/null 2>&1 && pm2 reload wv-api --update-env || pm2 start "$ROOT/ecosystem.config.js" --only wv-api
}

deploy_frontend() {
  cd "$ROOT/frontend"
  log "frontend: pull"; git fetch -q origin && git reset -q --hard origin/main
  log "frontend: install"; npm ci --no-audit --no-fund
  log "frontend: build"
  NEXT_PUBLIC_API_URL="https://$DOMAIN/api/v1" NEXT_PUBLIC_SITE_URL="https://$DOMAIN" \
  NEXT_PUBLIC_SITE_NAME="The Wood Vintage" NEXT_PUBLIC_DEFAULT_CURRENCY=INR NEXT_PUBLIC_DEFAULT_CURRENCY_SYMBOL="₹" \
  INTERNAL_API_URL="http://127.0.0.1:5000/api/v1" NEXT_TELEMETRY_DISABLED=1 npm run build
  log "frontend: reload"
  pm2 describe wv-web >/dev/null 2>&1 && pm2 reload wv-web --update-env || pm2 start "$ROOT/ecosystem.config.js" --only wv-web
}

case "$WHAT" in
  backend)  deploy_backend ;;
  frontend) deploy_frontend ;;
  all)      deploy_backend; deploy_frontend ;;
  *) echo "usage: $0 [backend|frontend|all]"; exit 1 ;;
esac
pm2 save >/dev/null
log "health"; sleep 3
curl -fsS -m 10 "http://127.0.0.1:5000/api/v1/countries" >/dev/null && echo "api ok"
curl -fsS -m 20 -o /dev/null "http://127.0.0.1:3000/" && echo "web ok" || echo "web not up (ok if frontend not deployed yet)"
