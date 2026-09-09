# Changelog

Project-level changelog across all three `wood-vintage` repos (backend/frontend/documentation),
per MASTER-PROMPT §44. Record date, feature, files/DB/API changed, migration requirements, testing
status, deployment notes for every major change. Day-to-day detail belongs in `daily-log/`; this
file is the higher-level, release-facing summary.

## 2026-09-09

- Initiated the `wood-vintage` project: `backend`, `frontend`, `documentation` set up as fresh git
  repos, `backend`/`frontend` seeded from a file copy of `unique-dressup` (no inherited history or
  remotes). `documentation` repo scaffolded with daily-log, task tracker, skills log, decision
  records, and `docs/claude` + `docs/agents` structure.
  - Files changed: new repos, no application logic changed yet.
  - DB changes: none.
  - API changes: none.
  - Migration requirements: none yet — `.env` setup still pending in `backend`/`frontend` (see
    `tasks/TASKS.md`).
  - Testing status: N/A (no code changes).
  - Deployment notes: no remotes configured yet for any of the three repos.
- Ran `npm install` in `wood-vintage/backend` (510 packages) and `wood-vintage/frontend`
  (487 packages).
  - Files changed: `package-lock.json` and `node_modules/` (gitignored) in both repos.
  - DB changes: none.
  - API changes: none.
  - Migration requirements: none.
  - Testing status: install completed clean in both; `npm audit` found frontend has 2 critical +
    7 high vulnerabilities (`next`, `swiper` among them) and backend has 17 (2 low, 8 moderate,
    7 high, none critical) — logged in `docs/claude/technical-debt.md`, not yet fixed (available
    fixes for the critical ones are breaking changes).
  - Deployment notes: neither app has a working `.env`/`.env.local` yet, so neither runs end-to-end.
- Stood up a working local dev environment: `backend/.env` and `frontend/.env.local` recreated,
  new local MySQL DB `wood_vintage` created and schema pushed, frontend's hardcoded `API_URL` fixed
  to read `NEXT_PUBLIC_API_URL`, dev port conflicts with other projects on this machine resolved
  (frontend now on :3030). Full stack verified booting and talking to each other end-to-end.
  - Files changed: `backend/.env` (new, gitignored), `frontend/.env.local` (new, gitignored),
    `frontend/package.json` (`dev` script → port 3030), `frontend/constants/index.ts` (`API_URL`
    fix), `frontend/lib/axios.ts` (removed stray `console.log`). See `wood-vintage/frontend` commit
    `97e502d`.
  - DB changes: new local MySQL database `wood_vintage` created; full Prisma schema pushed to it
    (`npm run prisma:push`); first-boot seed ran (settings, categories, collections, homepage
    sections, banners, testimonials, coupons, SEO meta, CMS pages, one SUPER_ADMIN).
  - API changes: none (bugfix to how the frontend reads its own config, not an API contract change).
  - Migration requirements: none for this change; real third-party secrets (Razorpay, Google OAuth,
    Brevo/SMTP) still need to be supplied before those features work.
  - Testing status: backend boot verified (`GET /health` → 200, seed completed); frontend boot
    verified (`GET /` → 200, correct title reflecting `NEXT_PUBLIC_SITE_NAME`); frontend
    `tsc --noEmit` clean. No automated test suite exists in either repo (inherited from
    `unique-dressup` — `backend/CLAUDE.md` §23).
  - Deployment notes: local dev only. Dev servers were stopped after verification, not left
    running. See `docs/decisions/0002-local-dev-environment-setup.md` for the full rationale.
- Completed Phase 0 (Discovery): `docs/architecture/phase-0-discovery-report.md`, all 25 sections
  per MASTER-PROMPT §50. Sections 1–17 are current-state facts (synthesized from the inherited
  `CLAUDE.md`, spot-verified not fully re-audited); 18–25 are new recommendations — Country/
  CountryContext model, country-scoped CMS extension, a revised Phase 1 sequencing (migration
  history + server-authoritative pricing before country work), and an explicitly undecided
  international URL strategy flagged for its own future decision record.
  - Files changed: `docs/architecture/phase-0-discovery-report.md` (new), `tasks/TASKS.md`,
    `docs/claude/current-roadmap.md`.
  - DB changes: none.
  - API changes: none.
  - Migration requirements: none for this entry; the report itself recommends migration-history
    adoption as the first Phase 1 task.
  - Testing status: N/A (documentation only).
  - Deployment notes: N/A. One open product question raised, not resolved — see `tasks/TASKS.md`
    Phase 0.
- Phase 1 (Foundation), first two prerequisite tasks: real Prisma migration history, and
  server-authoritative order pricing (was trusting client-supplied `data.items[].price` — a real,
  confirmed-exploitable critical bug, not a hypothetical one).
  - Files changed: `backend/prisma/migrations/20260909115445_init/` (new), `backend/CLAUDE.md`
    (migration-strategy section + Known Issues #1/#2/#12 corrected), `backend/src/modules/orders/
    services/order.service.ts` (`effectivePrice()`). See `wood-vintage/backend` commit `2e2f827`
    and `docs/decisions/0003-phase-1-foundation-prerequisites.md`.
  - DB changes: `wood_vintage` reset (mysqldump backup taken first; DB held only throwaway seed
    data) and rebuilt from the new migration baseline. No production DB touched.
  - API changes: none to the request/response contract — `POST /orders` still accepts
    `items[].price` for backwards compatibility, it's simply no longer used for any calculation.
  - Migration requirements: schema changes from here forward go through `prisma migrate dev`, not
    `prisma db push` (still technically works, but would desync history if used).
  - Testing status: `npm run build` clean. Migration verified via `prisma migrate status` (in
    sync) and a full backend boot/reseed. Pricing fix verified with an actual exploit attempt
    (spoofed `price: 1` on a real ₹399 product, correctly charged ₹399 after the fix) — not code
    review alone. Test user/order/script cleaned up afterward.
  - Deployment notes: local dev only; not deployed anywhere. `unique-dressup` unaffected — this
    fix was not backported there.
- Frontend: all 9 npm vulnerabilities fixed (2 critical, 7 high), `npm audit` now clean. `next`
  patched (`15.5.19` → `^15.5.25`, no code changes), `swiper` patched (`^11.1.14` → `^14.2.0`,
  npm called it breaking but the real usages needed no changes), `postcss` pinned via an
  `overrides` entry.
  - Files changed: `frontend/package.json`, `frontend/package-lock.json`. See
    `wood-vintage/frontend` commit `d1ec1a0` and `docs/decisions/0007-frontend-npm-vulnerabilities-fixed.md`.
  - DB changes: none.
  - API changes: none.
  - Migration requirements: none.
  - Testing status: `tsc --noEmit` + `npm run build` clean; full-stack boot + `curl` confirmed
    correct SSR markup for both carousels. Independently re-verified after the fact (not just
    trusted): `npm audit` re-run shows 0 vulnerabilities. **Disclosed gap**: real-browser
    hydration/interactivity of the carousels not verified (tooling couldn't reach this sandbox's
    localhost) — tracked as a follow-up.
  - Deployment notes: local dev only.
- Six architecture decisions recorded for Phase 1 Foundation, done in parallel with the two
  background agents above (no code changes, documentation-repo only): Country/Currency
  architecture spec (not yet applied to the backend schema), international URL strategy
  (subdirectory-per-country), launch-market reference data for all 8 markets, Media/CDN
  architecture (reuse existing pipeline), and SEO foundation scope. See `docs/decisions/0004`
  through `0006` plus the country spec in `docs/architecture/`.
  - Files changed: `docs/architecture/country-architecture-spec.md`,
    `docs/decisions/0004-international-url-strategy.md`,
    `docs/decisions/0005-media-cdn-architecture.md`, `docs/decisions/0006-seo-foundation-scope.md`,
    `docs/countries/launch-markets-reference.md`, plus `tasks/TASKS.md` and
    `docs/claude/known-decisions.md` updates.
  - DB/API changes: none — specs and decisions only, no implementation yet.
  - Testing status: N/A (documentation only).
  - Deployment notes: N/A. Three open product/business questions consolidated at the top of
    `tasks/TASKS.md`, explicitly not blocking current engineering work.
