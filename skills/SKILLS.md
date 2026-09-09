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

## 2026-09-09 — Check for port conflicts on a shared dev machine before assuming defaults

What: Before starting a new project's dev server, check what's already listening
(`ss -ltn`), rather than assuming the framework default port is free.

Where used: `wood-vintage/frontend` — `next dev` (default port 3000) failed with `EADDRINUSE` even
after Next's own auto-increment logic, because this machine already runs ~10 unrelated projects
(the `sfg`/suwalka services) with dev servers spanning ports 3000–3010.

Why it mattered: the instinct was to assume something was wrong with the new setup. It wasn't —
the machine is just shared across many projects. Killing whatever was on those ports would have
broken someone else's active work; picking an explicitly free port (3030) was the safe fix.

Reusable as: `ss -ltn | grep ':<port> '` to check a single port, or scan a range before assuming a
framework's default port is available on a dev box that runs multiple projects. Pick an unused
port explicitly (`next dev -p <port>`) rather than relying on auto-increment, and keep the CORS
allow-list (`FRONTEND_URL`/`ADMIN_URL` here) and `NEXT_PUBLIC_SITE_URL` in sync with whatever port
you land on — see `docs/decisions/0002-local-dev-environment-setup.md`.

## 2026-09-09 — Set explicit seed-time admin credentials, don't rely on a one-time log line

What: `backend/src/server.ts` seeds a `SUPER_ADMIN` on first boot only if none exists, generating a
random password shown once in the server log when `ADMIN_PASSWORD` isn't set in `.env`.

Where used: `wood-vintage/backend` first boot.

Why it mattered: the first boot generated a throwaway password, logged once. For a dev environment
meant to be reused across sessions (not a CI/ephemeral boot), that's a trap — losing the log line
means the only way back in is deleting the seeded admin row and reseeding. Setting `ADMIN_EMAIL`/
`ADMIN_PASSWORD` explicitly in `.env` *before* first boot avoids it; if you miss that window, the
fix is `DELETE FROM users WHERE role='SUPER_ADMIN'` in the DB and restart to reseed.

Reusable as: for any app that auto-seeds an admin/root account on first boot, set the credential
env vars before the first boot, not after — check the seed logic for "only if none exists" guards
that make a do-over require a manual DB delete.
