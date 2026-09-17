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

## FIXED — Frontend: 2 critical + 7 high npm vulnerabilities
Where: `frontend/package.json` / `package-lock.json`
Impact: `next` (critical RCE/SSRF/DoS), `swiper` (critical prototype pollution), plus 7 high-severity
transitive issues.
Fix: `next` → `^15.5.25` (patch bump, no code changes), `swiper` → `^14.2.0` (npm called it breaking,
but the two real usages — `HeroSlider.tsx`, `TestimonialsSection.tsx` — already used the stable
modern API, unchanged across that range, so no component changes were needed), `postcss` pinned via
an `overrides` entry rather than forcing a `next@16` major bump. `npm audit` now reports 0
vulnerabilities. Verified: `tsc --noEmit` + `npm run build` clean, booted the full stack and
confirmed the homepage renders correctly with real carousel markup. **Disclosed gap**: client-side
hydration/interactivity wasn't verified in a real browser (tooling couldn't reach this sandbox's
localhost) — only SSR markup confirmed. See `docs/decisions/0007-frontend-npm-vulnerabilities-fixed.md`.
Found: 2026-09-09. Fixed: 2026-09-09 (`wood-vintage/frontend` commit `d1ec1a0`).

## MOSTLY FIXED — Backend: 17 npm vulnerabilities → 2 remaining (confirmed unreachable)
Where: `backend/package.json` / `package-lock.json`
Impact: was 2 low, 8 moderate, 7 high. Fixed via `npm audit fix` (form-data, joi, js-yaml, morgan),
removing unused `csurf` (also cleared a `cookie` CVE), a `qs` override, and individually-verified
bumps (`uuid` 9→14, `google-auth-library` 9→10, `sharp` 0.33→0.35, `nodemailer` 6→10 — each checked
for actual API usage and smoke-tested before keeping).
Remaining: 2 moderate `uuid <11.1.1` findings, both via `exceljs`'s own pinned `uuid@8.3.0`.
**Deliberately not fixed** — `exceljs` 4.4.0 is the latest release, npm's only suggested remediation
is downgrading to 3.4.0 (a real regression), and the vulnerable code path (`uuid` v3/v5/v6 with a
`buf` argument) is confirmed unreachable — `exceljs` only ever calls `uuid.v4()`. See
`docs/decisions/0008-backend-security-and-stock-restoration.md`.
Found: 2026-09-09. Mostly fixed: 2026-09-09 (`wood-vintage/backend` commit `044b79d`).

## FIXED — Stock not restored when an order is cancelled; `InventoryLog` written nowhere
Where: `backend/src/modules/orders/services/order.service.ts`
Impact: `../backend/CLAUDE.md` §25 #3 (🔴 critical) and #21 — cancelled orders permanently leaked
inventory and inflated `totalSold`; the `InventoryLog` model existed but was never written to.
Fix: `cancelOrder()` now runs in a transaction restoring `stockQuantity`/reversing `totalSold` per
line item; both `createOrder` and `cancelOrder` now write `InventoryLog` rows (`SALE`/`RETURN`).
Verified live (agent) and independently re-checked (this session): build clean, boots clean, dev DB
has zero leftover test rows. See `docs/decisions/0008-backend-security-and-stock-restoration.md`.
Found: (inherited, dated 2026-07-27). Fixed: 2026-09-09 (`wood-vintage/backend` commit `bf811c8`).

## FIXED — CMS pages 404 (frontend called `/cms`, backend serves `/seo/cms`)
Where: `frontend/app/(store)/[page]/page.tsx`
Impact: `../backend/CLAUDE.md` §25 #7 — every CMS page (about, privacy-policy, terms, etc.) 404'd.
Fix: one-line URL fix. Verified live: `GET /about` now returns 200 with real seeded content.
Found: (inherited, dated 2026-07-27). Fixed: 2026-09-09 (`wood-vintage/frontend` commit `3f4763c`).

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
## FIXED — Checkout didn't reflect the per-product shipping override
Where: `frontend/app/(store)/checkout/page.tsx`
Fix: mirrors the backend's own logic client-side rather than fetching a new quote endpoint — the
cart/product APIs already return `standardShippingCharge`/`codShippingCharge`/
`expressShippingCharge` on `CartItem.product` (full scalar columns, no backend change needed), so
checkout now takes the same max-across-cart-items override when one applies, falling back to the
flat `SHIPPING_METHODS` rate otherwise. `tsc --noEmit`/`npm run build` clean, logic is a direct
line-by-line match of the already-verified (real exploit-tested) backend calculation.
**Disclosed gap**: no live/browser verification — this is a client component (can't check via
curl) and the `claude-in-chrome` tool can't reach this sandbox's localhost (same limitation as the
Swiper carousel fix in `0007`). Not claimed fully verified.
Found: 2026-09-09. Fixed: 2026-09-09 (`wood-vintage/frontend` commit `76c55e4`).

## Fill in real third-party keys before those features work
Where: `backend/.env` (`RAZORPAY_KEY_ID`/`_SECRET`, `CASHFREE_*`, `GOOGLE_CLIENT_ID`/`_SECRET`,
`BREVO_API_KEY`/`SMTP_*`), `frontend/.env.local` (`NEXT_PUBLIC_RAZORPAY_KEY`,
`NEXT_PUBLIC_GOOGLE_CLIENT_ID`)
Impact: payments, Google sign-in, and transactional email are all non-functional until real
credentials are supplied — cannot be fabricated.
Fix: supply real values (sandbox is fine for dev) when each feature is actually being worked on.
Found: 2026-09-09.

## Product search doesn't scale past a small catalogue
Where: `backend/src/modules/products/services/product.service.ts` (`getProducts`, `searchProducts`)
Impact: search/filter text matching uses Prisma `contains` (`LIKE '%...%'`), which can't use a
B-tree index — degrades non-linearly as the catalogue grows. Not a current problem (catalogue is
near-empty); would become one at real scale.
Fix: add a MySQL `FULLTEXT` index (`name`/`description`/`brand`/`sku`, and `tags` via its own table)
and rewrite the matching query to `MATCH...AGAINST` via `$queryRaw` (Prisma's mysql provider needs
raw SQL for this, no first-class query-builder support). Do this when the catalogue is actually
large enough to need it, not speculatively — the rewrite has real behavioral differences from
`LIKE` (stopwords, minimum word length, relevance ranking) worth doing carefully against real data.
Found: 2026-09-17 (Phase 8 Scale audit).

## Rate limiting and file uploads assume a single machine
Where: `backend/src/app.ts` (rate limiter, `express-rate-limit` default in-memory store),
`backend/src/utils/upload.ts` (`multer.diskStorage` → local `./uploads`)
Impact: both are correct for the current single-machine PM2 cluster (`instances: 'max'`) deployment
target — a shared filesystem, so per-worker state and local disk both work. Neither would survive
running the app on more than one machine behind a load balancer: the rate limiter's counter isn't
shared across machines (effective limit becomes `max × machineCount`, not the configured max), and
an upload landing on one instance wouldn't be visible from another.
Fix: a shared rate-limit store (Redis) and object storage (S3-compatible) for uploads, respectively
— both real infrastructure decisions (new dependency, hosting choice), same class as the CDN/caching
deferral in `0022`. Not built ahead of an actual multi-machine deployment.
Found: 2026-09-17 (Phase 8 Scale audit).

## No per-country tax rate model
Where: `backend/prisma/schema.prisma` (`Product.taxPercent`, single global field, `@default(18)`,
India-GST-shaped)
Impact: VAT (UK/EU), GST-equivalent (AU), and sales tax (US, sub-national) rates differ by market
and aren't modeled per-country at all — every order everywhere uses the same global tax rate/logic.
Fix: the schema change (a per-country tax rate, similar in shape to `CountryShippingRule`) is
straightforward once real rates are known — but building it with placeholder numbers would be
actively wrong, not merely incomplete. Needs real VAT/GST/sales-tax figures per target market from
whoever owns finance/legal compliance before this is worth doing.
Found: 2026-09-17 (Phase 8 Scale audit).
