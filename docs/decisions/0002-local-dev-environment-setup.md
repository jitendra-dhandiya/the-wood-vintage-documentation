# 0002. Local dev environment: DB, ports, admin credentials, API_URL fix

Date: 2026-09-09

## Decision

- Backend dev DB: new local MySQL database `wood_vintage` (not `unique_dressup`, not the
  `.env.example` default `fashion_ecommerce`), same local MySQL server/credentials
  (`root:123456@localhost:3306`) already used by `unique-dressup/backend` — separate schema, same
  server, no data ever shared between the two.
- Backend `JWT_SECRET`/`JWT_REFRESH_SECRET`: freshly generated (`openssl rand -hex 32`), not
  copied from anywhere.
- Backend `ADMIN_EMAIL`/`ADMIN_PASSWORD`: set explicitly in `.env` (`admin@woodvintage.local` +
  a generated password) rather than left unset. Real value lives only in the gitignored `.env`,
  never in this documentation repo.
- Frontend dev server port: **3030**, not the Next.js default 3000. `frontend/package.json`
  `"dev"` script now runs `next dev -p 3030`.
- Backend `FRONTEND_URL`/`ADMIN_URL` (CORS allow-list) and frontend `NEXT_PUBLIC_SITE_URL`
  updated to `http://localhost:3030` to match.
- Fixed `frontend/constants/index.ts` `API_URL` to actually read `NEXT_PUBLIC_API_URL` instead of
  a hardcoded production URL (see `docs/claude/technical-debt.md` for detail).

## Why

- **DB naming:** `wood_vintage` matches the project's actual name and avoids any ambiguity with
  the `unique_dressup` database `unique-dressup/backend` already uses on the same MySQL server.
- **Fresh JWT secrets:** per `docs/decisions/0001-...` — no secret was copied from
  `unique-dressup`, so these had to be generated new regardless.
- **Explicit admin credentials:** the backend seeds a `SUPER_ADMIN` on first boot only if none
  exists, generating a random password shown once in the server log if `ADMIN_PASSWORD` isn't set.
  That's fine for a throwaway boot, but not for an environment meant to be used repeatedly — losing
  that log line would mean recreating the DB just to get back in. Setting it explicitly in `.env`
  makes it recoverable.
- **Port 3030:** this development machine already runs ~10 other, unrelated projects (the `sfg`/
  suwalka services) with dev servers bound across ports 3000–3010. `next dev` (default port 3000)
  failed with `EADDRINUSE` even after Next's own auto-increment logic. Rather than touch any
  pre-existing process, `wood-vintage/frontend` was moved to an explicitly unused port.
- **`API_URL` fix:** discovered while verifying the `.env.local` actually worked end-to-end — the
  hardcoded value would have silently defeated it. This was already flagged as a known issue in
  the inherited `backend/CLAUDE.md` §25 #5, so fixing it was applying already-agreed guidance, not
  a new architectural call.

## Alternatives considered

- **Reuse `unique_dressup` as the DB name / same DB instance.** Rejected — would blur the "never
  touch unique-dressup" boundary and risk cross-project data contamination.
- **Leave `ADMIN_PASSWORD` unset (random, log-only).** Rejected for a persistent dev environment —
  acceptable for CI/ephemeral boots, not for a database meant to be reused across sessions.
- **Kill whatever's on port 3000 and use the default.** Rejected — those are other active projects
  on a shared dev machine, not ours to touch.
- **Leave `API_URL` hardcoded and just document the workaround.** Rejected — the whole point of
  recreating `.env.local` was to make local dev configurable; leaving a known-broken hardcode in
  place would have made the `.env.local` work silently pointless. The fix was small, already
  documented as correct in `backend/CLAUDE.md`, and verified working.

## Chosen approach

See `backend/.env` and `frontend/.env.local` for the concrete values (not reproduced here —
they're gitignored secrets/config, not documentation content). `frontend/package.json`,
`constants/index.ts`, and `lib/axios.ts` changes are in `wood-vintage/frontend` commit `97e502d`.

## Consequences

- Local dev URLs are `http://localhost:5000` (backend) and `http://localhost:3030` (frontend) —
  not the Next.js-default 3000. Anyone (or any future Claude session) picking this project back up
  needs to know that, hence this record plus the inline comments in both `.env` files and
  `package.json`.
- `ADMIN_PASSWORD` is a real, reusable credential now living in `backend/.env` (gitignored, not in
  this repo). Rotate it before any shared/staging deployment — it was generated for solo local dev
  only.
- The `unique-dressup` MySQL server now hosts two databases (`unique_dressup`, `wood_vintage`).
  Worth knowing if that server is ever backed up/restored/migrated.
- `frontend`'s `API_URL` and the stray `console.log` fix diverge `wood-vintage/frontend` from a
  pure copy of `unique-dressup/frontend` — intentional and tracked, not silent drift.
