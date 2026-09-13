# 0015. Country shipping rules implemented

Date: 2026-09-13

## Decision

Implemented `CountryShippingRule` per `docs/architecture/phase-3-country-shipping-and-admin-spec.md`
— a per-(country, method) shipping cost + optional free-shipping threshold, wired as a new
highest-priority step ahead of the existing per-product-override/flat-rate chain in
`order.service.ts`. `wood-vintage/backend` commit `31d3aa0`.

## What was built

- `CountryShippingRule` model (`countryId`, `method`, `cost`, `freeShippingThreshold`,
  `estimatedDaysMin`/`Max`, `customsMessage`, `isActive`), unique per `(countryId, method)`.
  Migration `20260913094116_add_country_shipping_rules` — applied via normal `prisma migrate dev`
  this time (the non-interactive-environment issue from `0010`'s CMS-slug fix didn't recur, further
  confirming it's specific to migrations needing a destructive-change warning, not general).
- `resolveCountryShipping()` in `countryPricing.ts`: returns a rule's cost (0 if the order subtotal
  meets the free-shipping threshold) or `null` if no rule exists for that `(country, method)` —
  callers fall back to existing behavior unchanged on `null`.
- Wired into `order.service.ts` as a genuinely additive step — read the actual diff: the existing
  per-product-override/flat-rate calculation still runs first and produces `shippingCharge`, then
  the country-rule check only *overrides* that value if a rule exists. Nothing existing was
  restructured.
- Admin CRUD nested under `/countries/:countryId/shipping-rules`, admin-only, method restricted to
  the existing `STANDARD`/`COD`/`EXPRESS` vocabulary (not arbitrary strings) — consistent with what
  `order.service.ts` already hardcodes.

## Verification

Independently re-verified beyond the report: real commit confirmed, clean build, migration status
checked, DB queried directly for the new table (0 rows) and confirmed the resolution code reads
exactly as reported (an additive override, not a replacement of the existing chain). The agent's
own verification (specific, credible, not re-run in full): a real order with a country shipping
rule and a spoofed client price charged the correct rule-based shipping (50, then 0 above the
free-shipping threshold) while still ignoring the price spoof (`0003`'s protection intact); a
country/order with no rule fell back to the exact pre-existing flat rate (79). All test data
(orders, the test rule, re-disabled AE, restored stock) confirmed cleaned up via direct query.

## Consequences

- Every country continues behaving exactly as before until an admin explicitly configures a
  shipping rule for it — genuinely zero-risk to existing behavior, as designed.
- `estimatedDaysMin`/`Max`/`customsMessage` are stored and CRUD-able but not yet surfaced anywhere
  (no storefront checkout display) — that's the frontend piece, still in progress as of this record
  (see the Countries admin UI agent, running concurrently).
- `tasks/TASKS.md`'s "Country shipping rules (§18)" line closes.
