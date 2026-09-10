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
Confirmed working against a real URL (`https://example.com`) before relying on it.

**Update, same day:** the user said explicitly "I dont want to use claude chrome" on this project.
Use local headless Chrome for *all* browser verification here — don't fall back to
`claude-in-chrome` even as a retry, not just prefer headless Chrome when convenient.

## 2026-09-10 — Real click-through E2E testing via CDP, in a scratchpad project (no repo dependency)

What: `--dump-dom` (a single snapshot after page load) is enough to confirm a page renders
correctly, but not enough to confirm an actual user flow (fill a form, click a button, land on the
next state) works. For that, drove headless Chrome via the DevTools Protocol directly:
`google-chrome --headless=new --remote-debugging-port=<port>` exposes a CDP endpoint;
`chrome-remote-interface` (an npm package) gives a clean JS API over it — `Runtime.evaluate` to
read/set page state and dispatch real DOM/React-compatible input events, `Page.navigate` to move
between routes in the same session (preserving cart/auth state across the walkthrough, like a real
user).

Where used: full storefront walkthrough — homepage → shop → product detail → add to cart → cart →
checkout → fill address form → place a real order.

Why it mattered: this is qualitatively more rigorous than "the SSR HTML looks right" — it proved
the React components actually wire up correctly to the (already API-verified) business logic, by
driving them the way a shopper would, not by re-checking the API directly.

Reusable as:
```bash
mkdir /tmp/.../scratch-cdp && cd /tmp/.../scratch-cdp && npm init -y && npm install chrome-remote-interface
google-chrome --headless=new --disable-gpu --no-sandbox --remote-debugging-port=9333 about:blank &
```
```js
const CDP = require('chrome-remote-interface');
const client = await CDP({ port: 9333 });
const { Page, Runtime, Console } = client;
await Page.enable(); await Runtime.enable(); await Console.enable();
await Page.navigate({ url: 'http://localhost:3030/...' });
await Page.loadEventFired();
// Set a React-controlled <input>'s value the way real typing would (not el.value = x, which React
// won't see as a change without the native setter + a dispatched 'input' event):
await Runtime.evaluate({ expression: `
  const el = document.querySelector('input[name="firstName"]');
  const setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
  setter.call(el, 'value'); el.dispatchEvent(new Event('input', { bubbles: true }));
`});
// Click a button found by its visible text (no test-ids in this codebase):
await Runtime.evaluate({ expression: `
  Array.from(document.querySelectorAll('button')).find(b => /place order/i.test(b.innerText)).click();
`});
```
Install the npm package in a scratchpad-only throwaway project (`npm init -y` in `/tmp/.../scratch`),
never in either app repo — this is a verification tool, not a project dependency, and this
codebase deliberately has no test tooling installed (`backend/CLAUDE.md` §23).

## 2026-09-10 — Kill background dev servers *by PID*, and verify the port is actually free, not just that the kill command returned success

What: `TaskStop` on a background bash task doesn't always guarantee the process it started (or a
detached child of it) is actually gone. Hit this twice in one session: (1) a `next-server` process
outlived a supposedly-stopped background task and caused a *later* fresh `npm run dev` to fail with
`EADDRINUSE`, whose confusing symptom was a 500 from the **stale** server, momentarily looking like
a regression; (2) a `google-chrome --headless` process launched with `nohup ... & disown` survived
a `pkill -f <port pattern>` because the actual argv didn't match the grep pattern used.

Where used: the full E2E walkthrough — both the app dev servers and the CDP-driving headless Chrome
instances.

Why it mattered: a stale process serving a *previous* build/state can make a real bug look present
(or a real bug look absent) depending on which version happens to answer the request. Chasing a
"bug" that's actually just old code still running wastes time and can lead to a wrong conclusion.

Reusable as: after stopping a background dev server (or before starting a new one on the same
port), verify with `ss -ltn | grep :<port>` — don't trust the stop command's exit code alone. If
something's still bound, find the exact PID (`ss -ltnp` or `ps aux | grep <name>`) and `kill <pid>`
directly rather than a pattern-matched `pkill`, which can miss processes whose argv doesn't match
the pattern used.

## 2026-09-10 — A hydration-mismatch console warning can be a testing artifact, not a real bug — isolate before concluding either way

What: Saw a real React hydration-mismatch error (MUI `InputLabel`'s `data-shrink` state disagreeing
between server and client) on `/checkout` during the E2E walkthrough. Rather than logging it as a
bug or dismissing it as noise, isolated the variable: re-ran the identical page load in a
**completely fresh Chrome profile** (`--user-data-dir=<empty new dir>`), with no prior navigation
or typed-field history. Zero hydration warnings.

Where used: the E2E checkout verification.

Why it mattered: the original test run reused one Chrome profile across many navigations to
`/checkout`, typing into fields named `firstName`/`phone`/etc. repeatedly — Chrome's own
form-autofill memory pre-filled those fields from its own history before React hydrated, which is
exactly the kind of client/server mismatch React's hydration warning describes, but the "server" in
this case never had a chance to know about it — it's an artifact of the test methodology (a reused,
autofill-remembering profile), not the application's code.

Reusable as: when a real-browser check shows a hydration warning tied to form-field state (label
shrink, defaultValue vs. value, autofill-shaped attributes), re-test in a fresh
`--user-data-dir` before concluding it's a real app defect — autofill contamination from a reused
profile is a common false-positive source specific to iterative browser-based testing, not
something a single clean page load would ever surface.
