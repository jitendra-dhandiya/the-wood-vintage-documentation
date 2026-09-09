# Technical Debt Register

Populate this during Phase 0 discovery and as debt is found later. Format per entry:

```
## Title
Where: file/module
Impact: what it costs us (perf, security, maintainability, SEO...)
Fix: proposed remediation (or "defer until X")
Found: YYYY-MM-DD
```

The inherited `../backend/CLAUDE.md` §25 ("Known Issues") and §26 ("Future Improvements") are also
a starting point until Phase 0 discovery (MASTER-PROMPT §2, §47, §50) is run properly against the
copied codebase.

## Frontend: 2 critical + 7 high npm vulnerabilities (post `npm install`)
Where: `frontend/package.json` / `package-lock.json`
Impact: `next` (critical) — includes unauthenticated RCE on Windows-hosted servers and RCE via
AVIF image optimization, SSRF in Server Actions/rewrites, DoS in Server Actions and SVG image
optimization, cache confusion. `swiper` (critical) — prototype pollution. Plus high-severity issues
in `axios`, `brace-expansion`, `form-data`, `js-yaml`, `nanoid`, `postcss`, `sharp` (transitive via
`next`).
Fix: `npm audit fix` resolves the non-breaking ones. The critical `next` and `swiper` fixes require
`npm audit fix --force` — `next` would bump to 15.5.25 (outside `package.json`'s stated range) and
`swiper` to 14.2.0 (breaking change per npm). **Deliberately not auto-applied** — a major-version
bump to Next.js and a breaking Swiper upgrade need testing before landing, not a blind force-fix.
Fix: track in `tasks/TASKS.md` backlog; do before Phase 5 (Performance)/production readiness at the
latest, sooner given the RCE severity.
Found: 2026-09-09

## Backend: 17 npm vulnerabilities (2 low, 8 moderate, 7 high) (post `npm install`)
Where: `backend/package.json` / `package-lock.json`
Impact: not yet triaged in detail beyond confirming none reported as critical; includes a moderate
`uuid` buffer-bounds issue (transitive via `exceljs`, `gaxios`) needing `uuid@14` (breaking) via
`npm audit fix --force`.
Fix: run `npm audit` for the full list and triage each; apply non-breaking fixes via
`npm audit fix`, evaluate breaking ones individually.
Found: 2026-09-09

## FIXED — Frontend `API_URL` hardcoded to production, ignoring `NEXT_PUBLIC_API_URL`
Where: `frontend/constants/index.ts`
Impact: `../backend/CLAUDE.md` §25 #5 already documented this — `API_URL` was a hardcoded literal
(`https://api.theuniquedressup.com/api/v1`) rather than reading the env var. It would have silently
defeated the `.env.local` set up for local dev — the frontend would have kept calling the old
production fashion-store API regardless of what `NEXT_PUBLIC_API_URL` said.
Fix: changed to `process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000/api/v1'`. Verified: full
stack booted locally (backend :5000 + MySQL `wood_vintage` + frontend :3030) and the homepage SSR
fetch reached the local backend successfully.
Found: 2026-09-09. Fixed: 2026-09-09 (`wood-vintage/frontend` commit `97e502d`).

## FIXED — Frontend logged `API_URL` (incl. backend IP) to the browser console in production
Where: `frontend/lib/axios.ts:4`
Impact: `../backend/CLAUDE.md` §20/§25 #5 already documented this stray `console.log`.
Fix: removed. Fixed: 2026-09-09 (`wood-vintage/frontend` commit `97e502d`).

## FIXED — No Prisma migration history (`db push` only)
Where: `backend/prisma/migrations/`
Impact: `../backend/CLAUDE.md` §25 #12 (critical-adjacent) — `db push` can silently drop
columns/tables to converge the schema; no rollback path, no audit trail.
Fix: reset the (then seed-only) dev DB, generated baseline migration `20260909115445_init`.
Schema changes now go through `prisma migrate dev`, not `db push` — see `backend/CLAUDE.md` §13 and
`docs/decisions/0003-phase-1-foundation-prerequisites.md`.
Found: (inherited, dated 2026-07-27 in the original doc). Fixed: 2026-09-09
(`wood-vintage/backend` commit `2e2f827`).

## FIXED — Order totals computed from client-supplied prices
Where: `backend/src/modules/orders/services/order.service.ts`
Impact: `../backend/CLAUDE.md` §25 #1 (🔴 critical) — `subtotal` was computed from
`data.items[].price`, a browser-controlled value. **Confirmed exploitable before the fix**: ordered
a real ₹399 seeded product while sending `price: 1`; would have been charged ₹1.
Fix: added `effectivePrice()`, re-deriving price server-side (same precedence
`cart.controller.ts` already uses: `variant.price ?? product.salePrice ?? product.basePrice`).
Re-tested the same exploit attempt after the fix — charged the real ₹399. See
`docs/decisions/0003-phase-1-foundation-prerequisites.md`.
Found: (inherited, dated 2026-07-27). Fixed: 2026-09-09 (`wood-vintage/backend` commit `2e2f827`).

## NOT CURRENT — "Frontend/backend shipping charges disagree" (`CLAUDE.md` §25 #2, as originally written)
Where: `frontend/constants/index.ts` (`SHIPPING_METHODS`) vs `backend/src/modules/orders/services/order.service.ts` (`SHIPPING_RATES`)
Impact: the specific claim (mismatched rate constants) is no longer true in the current code — both
are 79/149/249 and the frontend's old mismatched constants are explicitly marked legacy/unused.
Residual, lower-severity gap found while checking this: the backend prefers a per-product shipping
override (`standardShippingCharge` etc.) when set on a product; the frontend's pre-checkout display
doesn't know about that override, so it can show the flat rate while the (correctly, server-side
computed) charged amount differs for a product with an override. The *charged* total is still
correct — this is a display-accuracy gap, not a pricing-integrity one.
Fix: have checkout fetch a real price/shipping quote from the backend before display, rather than
computing the shown shipping charge purely from the static `SHIPPING_METHODS` table. Not urgent —
no product currently has a shipping override set in seed data; do before this becomes common.
Found: 2026-09-09 (during the order-pricing fix above).

## Fill in real third-party keys before those features work
Where: `backend/.env` (`RAZORPAY_KEY_ID`/`_SECRET`, `CASHFREE_*`, `GOOGLE_CLIENT_ID`/`_SECRET`,
`BREVO_API_KEY`/`SMTP_*`), `frontend/.env.local` (`NEXT_PUBLIC_RAZORPAY_KEY`,
`NEXT_PUBLIC_GOOGLE_CLIENT_ID`)
Impact: payments, Google sign-in, and transactional email are all non-functional until real
credentials are supplied — cannot be fabricated.
Fix: supply real values (sandbox is fine for dev) when each feature is actually being worked on.
Found: 2026-09-09.
