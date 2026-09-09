# CLAUDE.md — Wood Vintage Documentation Repo

> This repo is **project memory**, not application code. If you are Claude Code working here,
> read this file first, then skim `README.md` and `MASTER-PROMPT.md`.

## What this project is

`wood-vintage` is a **fresh project workspace** seeded from Unique Dressup, an existing production
B2C **fashion** e-commerce app, and is being transformed into a global **handcrafted wooden
furniture / handicrafts / home décor** e-commerce platform, targeting India, UAE, USA, Australia,
UK, Germany, France, Netherlands and other European markets, per `MASTER-PROMPT.md`.

`../backend` and `../frontend` were copied from
`/home/jitendra/work/dev/office/unique-dressup/{backend,frontend}` on 2026-09-09 as fresh git repos
(no inherited history/remotes; `node_modules/`, build output, logs, uploads, `.env` secrets not
copied). **The original `unique-dressup` repos are the read-only reference source and must never be
modified** — all transformation work happens here in `wood-vintage`.

Core rule from the master prompt: **do not rebuild from scratch** — inspect, reuse, and extend the
copied architecture. Country must become a first-class, configurable concept (currency, pricing,
tax, shipping, content, SEO all vary by country). See `MASTER-PROMPT.md` §1–7 and §17–19 for the
non-negotiables.

## Where things live

- `../backend` — API, Prisma/DB, business logic. Full engineering reference (as of the copy date): `../backend/CLAUDE.md`.
- `../frontend` — Next.js storefront + admin. Same `CLAUDE.md` covers it.
- `.` (this repo) — strategy, decisions, day-by-day log, task tracker, skills log. See `README.md` for the folder map.
- `/home/jitendra/work/dev/office/unique-dressup/{backend,frontend}` — original fashion-app source. **Read-only reference, never edit.**

## Local dev environment

- Backend: `http://localhost:5000` (`cd backend && npm run dev`). MySQL DB `wood_vintage` (local
  server, same credentials as `unique-dressup`'s `unique_dressup` DB — separate schema). `.env`
  has real generated JWT secrets and an explicit `ADMIN_EMAIL`/`ADMIN_PASSWORD`; third-party keys
  (Razorpay, Google OAuth, Brevo/SMTP) are placeholders.
- Frontend: `http://localhost:3030` — **not** the Next.js default 3000; this dev machine runs
  several other unrelated projects across ports 3000–3010. `package.json` `"dev"` script is
  `next dev -p 3030`. `.env.local` / backend `FRONTEND_URL`/`ADMIN_URL` are kept in sync with this.
- Full rationale: `docs/decisions/0002-local-dev-environment-setup.md`.
- Neither `.env` file is copied from `unique-dressup` or committed here — they're local secrets.

## Standing instructions for future sessions

1. **Read before writing.** Before starting new work, check `tasks/TASKS.md` for open items and
   `docs/decisions/` for prior calls that constrain the approach. Don't re-litigate decisions
   already recorded there without new information.
2. **Log the day.** At the end of (or during) a work session, add/update the entry in `daily-log/`
   for that date — what was done, why, what's next, any blockers.
3. **Track every task.** New work items get added to `tasks/TASKS.md`, not left implicit in chat.
   Mark items done as they're completed.
4. **Record decisions, not just outcomes.** Any architectural, product, SEO, or pricing decision
   that isn't obvious from the code gets a record in `docs/decisions/` using: Decision / Why /
   Alternatives / Chosen approach / Consequences / Date (MASTER-PROMPT §40).
5. **Log new skills/knowledge.** Reusable tools, patterns, or capabilities discovered while working
   go into `skills/SKILLS.md`, dated, with enough context to reuse later.
6. **Follow the phase discipline.** Work proceeds in the phases defined in `MASTER-PROMPT.md` §47
   (Discovery → Foundation → Handicraft Domain → Internationalization → Experience → Performance →
   SEO → Analytics → Scale). Don't skip Phase 0 discovery for a given module before changing it.
7. **Challenge bad requirements** rather than blindly executing them (MASTER-PROMPT §49) — explain
   the problem, the consequence, and propose an alternative before implementing something
   technically dangerous, SEO-damaging, or architecturally unsound.
8. **Work autonomously.** The user has asked (2026-09-09) to plan and execute without pausing for
   confirmation at each step — use judgment per the priorities in MASTER-PROMPT §3 and the rules
   above, rather than asking permission for routine work. Still stop and flag before anything
   genuinely irreversible or destructive (force-pushes, dropping data, deleting repos, spending
   real money on paid services) — autonomy is about not over-asking for ordinary engineering work,
   not a license to skip judgment on high-blast-radius actions.

## Quick links

- [MASTER-PROMPT.md](./MASTER-PROMPT.md) — full transformation brief
- [tasks/TASKS.md](./tasks/TASKS.md) — running task tracker
- [skills/SKILLS.md](./skills/SKILLS.md) — skills/knowledge log
- [docs/claude/current-roadmap.md](./docs/claude/current-roadmap.md) — phase roadmap
- [docs/claude/known-decisions.md](./docs/claude/known-decisions.md) — decision index
- [docs/claude/technical-debt.md](./docs/claude/technical-debt.md) — technical debt register
