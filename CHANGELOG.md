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
  - Migration requirements: none yet — `npm install` and `.env` setup still pending in
    `backend`/`frontend` (see `tasks/TASKS.md`).
  - Testing status: N/A (no code changes).
  - Deployment notes: no remotes configured yet for any of the three repos.
