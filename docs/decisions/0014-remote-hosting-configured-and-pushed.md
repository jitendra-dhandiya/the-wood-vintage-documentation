# 0014. Remote hosting configured and pushed — all three repos now on GitHub

Date: 2026-09-10

## Decision

Generated a dedicated SSH key/identity ("skm") for the `shilpamaheshwari1210-cmd` GitHub account,
configured it alongside this machine's other per-identity SSH keys, and pushed all three
`wood-vintage` repos to five GitHub remotes total.

## Why

This had been sitting in the backlog since the very first session (`0001`'s "Status" section) —
deprioritized repeatedly in favor of engineering work, per the daily log's own recurring note. The
user provided real GitHub repo URLs and asked directly to configure and push.

## What was set up

**SSH**: `~/.ssh/id_ed25519_skm` (ed25519, comment `skm`, no passphrase), plus a `Host github-skm`
block in `~/.ssh/config` — following the exact same per-identity pattern already used on this
machine for other GitHub accounts (`github-jatin`, `github-lalit`, etc.), so `git@github-skm:...`
resolves to this key specifically via `IdentitiesOnly yes`. This was the only sensible approach
given the machine already juggles several GitHub identities via this convention — inventing a
different pattern would have been inconsistent for no reason.

**Remotes** (all repos pushed to `main`, all as `[new branch]`, no conflicts):

| Local repo | `origin` | secondary remote |
|---|---|---|
| `documentation` | `wood-vintage-documentation` | — |
| `backend` | `ud-server` | `woodvintage` → `wood-vintage-server` |
| `frontend` | `ud-client` | `woodvintage` → `wood-vintage-client` |

## A clarification that mattered

The user's repo list included `ud-client`/`ud-server` alongside the three `wood-vintage`-named
repos. Given the standing "never touch `unique-dressup`" rule, this was genuinely ambiguous —
could have meant pushing the *original* `unique-dressup` fashion-app code (which would have
violated that rule) rather than the `wood-vintage` code. Asked rather than guessed: confirmed the
user wants the **same `wood-vintage/backend` and `wood-vintage/frontend` content** pushed to both
sets of repo names — `ud-server`/`ud-client` and `wood-vintage-server`/`wood-vintage-client` are
two GitHub-side names for the same local repos, not two different codebases. `unique-dressup`
itself was never touched — no remote was added or changed there, no push originated from it.

A second ambiguous instruction ("remove the current git remote & set the new") was also clarified
before acting, since one reading would have meant modifying `unique-dressup`'s own git config — the
user meant swapping which of the two GitHub names is `origin` vs. secondary on the already-copied
`wood-vintage` repos, not touching the original.

## Commit author identity

Every commit made this session (across all three repos, ~35 commits) carries this machine's
pre-existing global `git config` identity: `Alexander The Great <great@alexander.com>` — set before
this session began, not something introduced by this work. Once pushed to the user's real GitHub
account, this was visible in the real history, and the user asked about it directly.

Resolved: set `user.name`/`user.email` to `Shilpa Maheshwari <shilpamaheshwari1210-cmd@users.noreply.github.com>`
**locally in each of the three `wood-vintage` repos only** (`git config user.name`/`user.email`,
no `--global`) — the user explicitly wanted this scoped to this project, not applied machine-wide,
since the global config is presumably intentional for other projects on this machine. Deliberately
did **not** rewrite the already-pushed commit history (would need `git filter-branch`/`git
rebase` across every commit plus a force-push to the now-real remotes) — the user chose "fix going
forward only," and rewriting already-pushed history is exactly the kind of destructive,
force-push-requiring operation this session's standing rules say needs explicit confirmation, not
a default action.

## Consequences

- All three repos are now backed by real GitHub remotes, not local-only — a real risk (single
  machine, no backup) that existed since the project started is now closed.
- `backend` and `frontend` each push to two remote names by design — `git push` alone only updates
  `origin` (`ud-*`); pushing to `wood-vintage-*` needs an explicit `git push woodvintage main`. Any
  future session doing routine commits should remember both exist, or decide to push both after
  meaningful changes rather than just `origin`.
- The SSH key has no passphrase — appropriate for a single-user dev machine wanting frictionless
  push/pull, not for a shared or production-adjacent environment. (Not independently verified
  whether this machine's other per-identity keys are passphrase-protected or not; this one was
  generated without one for ergonomics, matching the non-interactive setup used throughout this
  session.)
- Commit history up to this point (all of Phase 0–2's work) is permanently authored as
  `Alexander The Great` on GitHub. Every commit from here forward in these three repos will
  correctly show `Shilpa Maheshwari`. If this history-split ever looks confusing later, this
  record explains why.
