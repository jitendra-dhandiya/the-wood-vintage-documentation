# 0001. Fresh repo setup under `wood-vintage`, sourced from `unique-dressup`

Date: 2026-09-09

## Decision

Set up three fresh, independent git repositories — `backend`, `frontend`, `documentation` — under
`/home/jitendra/work/dev/office/wood-vintage/`, each with clean git history and no remotes yet.
`backend` and `frontend` are seeded with a file copy of the existing Unique Dressup code
(`unique-dressup/backend`, `unique-dressup/frontend`), excluding `node_modules/`, build output,
logs, uploads, and `.env` secrets. The original `unique-dressup` repos are left completely
untouched and treated as a read-only reference source going forward.

## Why

The project is transforming an existing production **fashion** e-commerce app into a global
**handicraft/furniture** platform (see `MASTER-PROMPT.md`). The new platform is a distinct brand
("wood vintage") and product domain from Unique Dressup, and the user explicitly required that no
changes be made to the `unique-dressup` repos, and that the new setup live under `wood-vintage`
with its own fresh repos rather than reusing the old ones in place or inheriting their git history/remotes.

## Alternatives considered

1. **Transform `unique-dressup/backend` and `/frontend` in place.** Rejected — user explicitly
   required `unique-dressup` be left unmodified.
2. **`git clone` the existing repos (keeping history + remotes) into `wood-vintage`.** Rejected —
   user asked for "whole setup new"; inheriting the fashion app's commit history and GitHub remotes
   (`ud-server`, `ud-c`) doesn't fit a new brand/repo identity.
3. **File copy into fresh repos, no inherited history/remotes** (chosen). Keeps the working code as
   a real starting point (per MASTER-PROMPT §2/§3 — don't rebuild from scratch) while giving the new
   project its own clean identity.

## Chosen approach

- `rsync -a` copy of source files only (code, config, docs, `.gitignore`, `CLAUDE.md`), excluding
  `node_modules/`, `dist/`, `.next/`, `logs/`, `uploads/`, `.env`/`.env.local`, `*.tsbuildinfo`.
- `git init` + branch renamed to `main` in each of the three `wood-vintage` folders.
- `documentation` repo (this one) holds the project memory system described in `README.md`.

## Consequences

- `wood-vintage/backend/CLAUDE.md` and `frontend` currently reflect the state of the code as of the
  copy date (backend `7b7531f`, frontend `69b123f` per the doc header) — it will drift as work
  proceeds here and needs periodic re-verification, not blind trust.
- No remotes exist yet for any of the three `wood-vintage` repos — needs a decision on hosting
  (same GitHub account as `ud-server`/`ud-c`, a new account, naming convention) before pushing.
- `node_modules` need reinstalling (`npm install`) in both `backend` and `frontend` before they can
  run; `.env`/`.env.local` need to be recreated from the `.example` files with real values (not
  copied, since they contained secrets).
- `unique-dressup` remains the frozen source of truth for "what the fashion app currently does" —
  useful for comparison, never a place to make changes going forward.
