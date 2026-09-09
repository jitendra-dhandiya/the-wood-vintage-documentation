# Technical Debt Register

Populate this during Phase 0 discovery and as debt is found later. Format per entry:

```
## Title
Where: file/module
Impact: what it costs us (perf, security, maintainability, SEO...)
Fix: proposed remediation (or "defer until X")
Found: YYYY-MM-DD
```

The inherited `../backend/CLAUDE.md` §25 ("Known Issues") and §26 ("Future Improvements") are also
a starting point until Phase 0 discovery (MASTER-PROMPT §2, §47, §50) is run properly against the
copied codebase.

## Frontend: 2 critical + 7 high npm vulnerabilities (post `npm install`)
Where: `frontend/package.json` / `package-lock.json`
Impact: `next` (critical) — includes unauthenticated RCE on Windows-hosted servers and RCE via
AVIF image optimization, SSRF in Server Actions/rewrites, DoS in Server Actions and SVG image
optimization, cache confusion. `swiper` (critical) — prototype pollution. Plus high-severity issues
in `axios`, `brace-expansion`, `form-data`, `js-yaml`, `nanoid`, `postcss`, `sharp` (transitive via
`next`).
Fix: `npm audit fix` resolves the non-breaking ones. The critical `next` and `swiper` fixes require
`npm audit fix --force` — `next` would bump to 15.5.25 (outside `package.json`'s stated range) and
`swiper` to 14.2.0 (breaking change per npm). **Deliberately not auto-applied** — a major-version
bump to Next.js and a breaking Swiper upgrade need testing before landing, not a blind force-fix.
Fix: track in `tasks/TASKS.md` backlog; do before Phase 5 (Performance)/production readiness at the
latest, sooner given the RCE severity.
Found: 2026-09-09

## Backend: 17 npm vulnerabilities (2 low, 8 moderate, 7 high) (post `npm install`)
Where: `backend/package.json` / `package-lock.json`
Impact: not yet triaged in detail beyond confirming none reported as critical; includes a moderate
`uuid` buffer-bounds issue (transitive via `exceljs`, `gaxios`) needing `uuid@14` (breaking) via
`npm audit fix --force`.
Fix: run `npm audit` for the full list and triage each; apply non-breaking fixes via
`npm audit fix`, evaluate breaking ones individually.
Found: 2026-09-09

## FIXED — Frontend `API_URL` hardcoded to production, ignoring `NEXT_PUBLIC_API_URL`
Where: `frontend/constants/index.ts`
Impact: `../backend/CLAUDE.md` §25 #5 already documented this — `API_URL` was a hardcoded literal
(`https://api.theuniquedressup.com/api/v1`) rather than reading the env var. It would have silently
defeated the `.env.local` set up for local dev — the frontend would have kept calling the old
production fashion-store API regardless of what `NEXT_PUBLIC_API_URL` said.
Fix: changed to `process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000/api/v1'`. Verified: full
stack booted locally (backend :5000 + MySQL `wood_vintage` + frontend :3030) and the homepage SSR
fetch reached the local backend successfully.
Found: 2026-09-09. Fixed: 2026-09-09 (`wood-vintage/frontend` commit `97e502d`).

## FIXED — Frontend logged `API_URL` (incl. backend IP) to the browser console in production
Where: `frontend/lib/axios.ts:4`
Impact: `../backend/CLAUDE.md` §20/§25 #5 already documented this stray `console.log`.
Fix: removed. Fixed: 2026-09-09 (`wood-vintage/frontend` commit `97e502d`).
