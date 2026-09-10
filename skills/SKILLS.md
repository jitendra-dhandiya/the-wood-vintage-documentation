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

## 2026-09-09 — Verify a "fixed" pricing/security bug by attempting the exploit, not just reading the diff

What: After fixing `OrderService.createOrder`'s client-trusted price (see
`docs/decisions/0003-phase-1-foundation-prerequisites.md`), didn't stop at "the code now reads
`effectivePrice()` instead of `item.price`" — created a throwaway test user + signed JWT directly
(no HTTP register flow existed to go through — see the next entry), and sent a real
`POST /orders` request with a spoofed `price: 1` against a real ₹399 product to confirm the
resulting order was actually charged ₹399.

Where used: the order-pricing fix in `wood-vintage/backend`.

Why it mattered: a code-review-only "this looks right" leaves open the possibility of a wrong field
name, an untested code path, or a subtly wrong precedence rule. Placing the actual attack request
turns "should be fixed" into "confirmed fixed," and would have caught it immediately if it wasn't.

Reusable as: for any fix to a claimed injection/trust vulnerability, don't just read the diff —
construct the smallest real request that would have exploited the original bug and confirm it now
fails/produces the correct result. Clean up the test data afterward (test user, test order) so it
doesn't pollute the dev DB.

## 2026-09-09 — Check the actual auth routes before assuming a documented flow still exists

What: `backend/CLAUDE.md` documents `POST /auth/register` with a password. The actual route file
(`auth.routes.ts`) has no `/register` route at all — registration is now OTP-based
(`/otp/request`, `/otp/verify`), a passwordless flow added after the doc's last full analysis date.
Bypassed this for a quick test by creating the user row directly via Prisma and signing a JWT with
the app's own `signAccessToken()` util, rather than going through the (changed) HTTP auth flow.

Where used: setting up a test account to verify the order-pricing exploit fix.

Why it mattered: assuming an inherited architecture doc's documented API surface is exactly
current wastes time chasing a 404 that isn't the bug you're looking for. The project's own git log
already hinted at this ("feat(auth): passwordless sign-in...") — worth checking before trusting a
specific documented endpoint still exists.

Reusable as: when a documented endpoint 404s, check the actual route file before assuming
something else is broken — inherited docs (`CLAUDE.md` here) can drift from the code they describe,
especially around auth flows that get iterated on. For a quick internal test, creating a DB row +
signing a token with the app's own utilities is faster and just as valid as going through HTTP auth.

## 2026-09-10 — `claude-in-chrome` can't verify this sandbox's dev servers; a local headless Chrome can

What: `claude-in-chrome` (the browser-automation MCP tool) drives the **user's own Chrome
browser on their machine**, not a browser inside this sandbox — its own tool description confirms
this (it lists "every connected browser" and asks the user to pick one). That machine has no
network route to this sandbox's `localhost:3030`/`:5000`. This came up three times this session
(`0007`'s Swiper carousel check, `0011`'s checkout shipping display) as "tooling couldn't reach
localhost" without ever identifying *why* — it isn't transient or fixable by retrying, it's
architectural. Retrying it wastes a turn.

Where used: would apply to any real-browser (post-JS-hydration) verification of an app running in
this sandbox, in this or a similarly-sandboxed project.

Why it mattered: two verification gaps got disclosed as open rather than closed, when a real fix
was available and just hadn't been looked for. `google-chrome` turns out to be installed as a
system binary in this sandbox (`which google-chrome` → `/usr/bin/google-chrome`) and **can** reach
this sandbox's own localhost, since it runs inside it. No new dependency needed — no Playwright/
Puppeteer install, which would add a heavy, testing-only dependency to a repo that otherwise has no
test tooling at all (`backend/CLAUDE.md` §23 notes this explicitly).

Reusable as:
```bash
# Static/SSR-rendered HTML after JS execution:
google-chrome --headless=new --disable-gpu --no-sandbox --dump-dom <url>
# Screenshot (add --window-size=W,H before --screenshot for a specific viewport):
google-chrome --headless=new --disable-gpu --no-sandbox --screenshot=/path/out.png <url>
```
Confirmed working against a real URL (`https://example.com`) before relying on it. Use this
instead of `claude-in-chrome` for any "does this actually render/hydrate correctly" check against
an app running in this sandbox — reserve `claude-in-chrome` for tasks that genuinely need the
user's own browser (their logged-in sessions, their extensions, something they want to watch).
