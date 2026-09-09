# Wood Vintage — Global Handicraft Platform — Documentation

This is the **third repo** of the `wood-vintage` project, alongside:

| Repo | Path | Remote | Purpose |
|---|---|---|---|
| Backend | `../backend` | *(none yet — fresh repo, see below)* | API, DB, business logic |
| Frontend | `../frontend` | *(none yet — fresh repo, see below)* | Next.js storefront + admin |
| **Documentation** | `.` (this repo) | *(none yet — fresh repo, see below)* | Project memory, strategy, decisions, day-by-day work log |

`backend` and `frontend` here are **fresh git repos seeded with a copy of the existing Unique
Dressup code** (`/home/jitendra/work/dev/office/unique-dressup/{backend,frontend}`) — copied on
2026-09-09, with `node_modules/`, build output, logs, uploads, and `.env` secrets left behind (not
copied) and a clean git history (no inherited commits or remotes). The original `unique-dressup`
repos are the **read-only reference source** — per project rule, **they are never modified**;
`git log`/`git blame` there remains available for history if needed, but all new work happens here
in `wood-vintage`.

This repo does **not** duplicate the engineering reference already in `../backend/CLAUDE.md`
(copied over, so it covers both backend and frontend architecture in depth as of the copy date).
Instead this repo is the **project-management and knowledge layer**: the business/product/marketing/SEO
strategy behind the [Master Prompt](./MASTER-PROMPT.md) transformation (fashion e-commerce → global
handicraft platform), the day-by-day work log, the running task tracker, the skills/knowledge log,
and the architectural decision record.

## Why this repo exists

`MASTER-PROMPT.md` (section 38 onward) calls for a dedicated Claude memory/documentation system
separate from code, so that:

- Strategic and architectural decisions survive across sessions instead of living only in chat history.
- Every day's work is traceable — what was done, why, and what's next.
- Skills, tools, and reusable knowledge picked up along the way don't get lost.
- Marketing / SEO / UX / product reasoning is written down, not just implemented in code.

## Folder map

```
documentation/
├── MASTER-PROMPT.md        # source-of-truth transformation brief (copied from the original prompt doc)
├── CLAUDE.md                # master project memory — read this first
├── daily-log/                # one file per day: what was done, decisions, blockers, next steps
├── tasks/
│   └── TASKS.md              # single running task tracker (phases from MASTER-PROMPT.md §47 + backlog)
├── skills/
│   └── SKILLS.md             # log of skills/tools/"superpowers" picked up, dated
└── docs/
    ├── architecture/         # system + data architecture notes
    ├── business/             # business rules, model, positioning
    ├── marketing/             # campaigns, channel strategy, country marketing plans
    ├── seo/                   # SEO strategy, URL architecture decisions, schema plans
    ├── ux/                    # UX principles, journey maps, research
    ├── countries/             # per-country notes (pricing, shipping, tax, competitors, preferences)
    ├── products/              # product/category/attribute taxonomy decisions
    ├── analytics/             # event schema, KPI definitions, dashboard specs
    ├── engineering/           # cross-cutting engineering notes not in backend/CLAUDE.md
    ├── operations/            # ops runbooks, vendor/logistics notes
    ├── decisions/             # architectural/product decision records (ADR-style)
    ├── competitor-research/   # competitor teardown notes
    ├── claude/                # Claude-specific memory docs (MASTER-PROMPT §39)
    └── agents/                # virtual team role definitions (MASTER-PROMPT §41)
```

## Working rules

1. **Every work session gets a daily-log entry.** Copy `daily-log/TEMPLATE.md`, date it, fill it in.
2. **Every task lives in `tasks/TASKS.md`.** Check items off in place; don't let tasks exist only in chat.
3. **Every non-trivial architectural or product decision gets a record in `docs/decisions/`**, using the
   Decision / Why / Alternatives / Chosen approach / Consequences / Date format from MASTER-PROMPT §40.
4. **Every skill, tool, or reusable trick learned gets logged in `skills/SKILLS.md`.**
5. This repo doesn't hold application code — that stays in `backend` and `frontend`.

## Status

All three repos (`backend`, `frontend`, `documentation`) initialized fresh on 2026-09-09 under
`wood-vintage`, each with its own clean git history on `main`. None are pushed to a remote yet —
`gh` is not authenticated in this environment. Add remotes and push manually once repo names/host
are decided, e.g.:

```bash
git remote add origin git@github-jatin:<account>/wood-vintage-backend.git
git push -u origin main
```
