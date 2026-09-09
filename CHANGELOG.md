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
