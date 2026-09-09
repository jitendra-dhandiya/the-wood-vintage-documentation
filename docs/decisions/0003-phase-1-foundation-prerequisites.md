# 0003. Phase 1 prerequisites: migration history + server-authoritative order pricing

Date: 2026-09-09

## Decision

Completed, ahead of any country/currency schema work: (1) adopted real Prisma migration history
in `wood-vintage/backend` (baseline migration `20260909115445_init`, replacing `db push` as the
schema-change workflow), and (2) fixed `OrderService.createOrder` to compute order pricing entirely
server-side (`effectivePrice()`), instead of trusting the client-supplied `data.items[].price`.

## Why

Both were identified in `docs/architecture/phase-0-discovery-report.md` §17/§24 as the two things
that get materially more expensive to retrofit the more Phase 1–2 schema/logic gets built on top of
them — migration history because every subsequent schema change needs it, and pricing because a
`Country`/`CountryPricingRule` model (MASTER-PROMPT §7/§17) sitting on top of a still-client-trusted
price field would make the exploit worse, not better, and would need re-touching once pricing
becomes country-aware anyway.

The pricing issue was already flagged in the inherited `backend/CLAUDE.md` §25 #1 as a known
critical issue — this wasn't a new discovery, it was already-agreed-necessary work that had not yet
been done. It was verified exploitable before fixing (see Testing below), not assumed.

## Alternatives considered

- **Defer both until Phase 1 "officially" starts.** Rejected — both are correctness/security fixes
  independent of the handicraft transformation itself; there's no reason a fashion-store order
  should currently be exploitable for arbitrary pricing, transformation or not. MASTER-PROMPT §3's
  priority order (existing stable functionality → reusability → ... → security) supports fixing
  this now rather than treating it as blocked on later phases.
- **Retrofit migration history later, once the schema stabilizes.** Rejected — "later" keeps getting
  more expensive as more schema (country, pricing, materials, styles) gets added via `db push` in
  the meantime; doing it now, while the DB only has demo seed data, is close to free.
- **Use `prisma migrate resolve --applied` to baseline without resetting data.** Not needed —
  `wood_vintage` only held throwaway seed data (created earlier this same day), so a full reset was
  simpler and safer than trying to reconcile drift between `db push` history and a new baseline.

## Chosen approach

See `wood-vintage/backend` commit `2e2f827`. Migration: `mysqldump` backup →
`prisma migrate reset --force --skip-seed` → `prisma migrate dev --name init`. Pricing:
`effectivePrice(productId, variantId)` helper in `order.service.ts`, mirroring the precedence
`cart.controller.ts` already uses (`variant.price ?? product.salePrice ?? product.basePrice`), used
for both the order subtotal and each `OrderItem.price`/`total`. `data.items[].price` kept in the
request type (optional now) for backwards compatibility but never read for money.

## Consequences

- `npm run prisma:push` still works technically but is no longer the intended workflow for this
  repo — using it now would desync the DB from migration history. `npm run prisma:migrate`
  (`prisma migrate dev`) is the path forward. This is a deliberate divergence from `unique-dressup`,
  which still uses `db push` — noted in `backend/CLAUDE.md` so it isn't mistaken for drift.
- Verified with a real exploit attempt, not just code review: ordering a ₹399 seeded product
  (`Statement Canvas Tote`) while sending `price: 1` in the request. Before the fix this would have
  charged ₹1; after, it charged the real ₹399. Test user/order deleted after verification — not
  left in the dev DB.
- A smaller, separate gap surfaced while checking the related "frontend/backend shipping disagree"
  claim in `CLAUDE.md` §25 #2: that specific claim is no longer current (the constants match), but
  per-product shipping-charge overrides aren't reflected in the frontend's pre-checkout display.
  Logged in `docs/claude/technical-debt.md`, not fixed here — lower severity (display-only; the
  charged amount is still server-computed correctly) and out of scope for this pass.
- Stock-not-restored-on-cancel (`CLAUDE.md` §25 #3, also 🔴 critical) was **not** touched in this
  pass — still open, tracked in `tasks/TASKS.md`.
