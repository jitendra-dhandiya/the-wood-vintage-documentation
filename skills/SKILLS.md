# Skills & Knowledge Log

Running, dated log of skills, tools, patterns, and "superpowers" picked up while working on this
project — things worth remembering so they don't have to be re-discovered later. Not a place for
generic documentation (that goes in `docs/`) — this is specifically *"I learned/used X and here's
how/why it helped."*

Format per entry:

```
## YYYY-MM-DD — Short title

What: what the skill/tool/technique is.
Where used: which repo/module/task it applied to.
Why it mattered: the problem it solved or the time/quality it saved.
Reusable as: how to apply it again next time (command, pattern, link).
```

---

## 2026-09-09 — Repo memory system (this repo)

What: Split project knowledge into a dedicated `documentation` repo (daily log, task tracker,
skills log, decision records, per-domain docs) rather than letting it live only in chat or in one
giant `CLAUDE.md`.

Where used: Project-wide, established alongside `backend`/`frontend`.

Why it mattered: `../backend/CLAUDE.md` is already a 90K+ word engineering reference — adding
strategy/marketing/SEO/decision-log content there would make it unwieldy and mix "how the code
works" with "why we did X." Separating them keeps each document scannable.

Reusable as: This structure (`daily-log/`, `tasks/TASKS.md`, `skills/SKILLS.md`,
`docs/decisions/`, `docs/claude/`, `docs/agents/`) can be reused as a template for any future
project that needs a Claude-Code-driven memory system — see `README.md` for the folder map.

## 2026-09-09 — Copy-not-clone to start a new project from existing code

What: When spinning up a new project (`wood-vintage`) from an existing codebase
(`unique-dressup`) that must stay untouched and shouldn't hand down its git history/remotes,
`rsync -a` the source tree into the new location (excluding `node_modules/`, build output, logs,
uploads, `.env` secrets) and `git init` fresh there, rather than `git clone`.

Where used: Setting up `wood-vintage/backend` and `wood-vintage/frontend` from
`unique-dressup/backend` and `unique-dressup/frontend`.

Why it mattered: `git clone` would have pulled in the old app's commit history and pointed at its
GitHub remotes (`ud-server`, `ud-c`) — wrong identity for a new brand/product. A plain file copy
gives a real, working starting point (satisfies "don't rebuild from scratch") with a clean slate
for history and remotes.

Reusable as:
```bash
rsync -a --exclude '.git/' --exclude 'node_modules/' --exclude 'dist/' \
  --exclude '.next/' --exclude 'logs/' --exclude 'uploads/' \
  --exclude '.env' --exclude '.env.local' --exclude '*.tsbuildinfo' \
  <source>/ <destination>/
cd <destination> && git init && git branch -m main
```
