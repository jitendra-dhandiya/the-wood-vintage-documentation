# 0017. ProductCountryPricing/Availability write endpoints added

Date: 2026-09-13

## Decision

Added `PUT`/`DELETE` endpoints for `ProductCountryPricing` and `ProductCountryAvailability`,
nested under products (`/products/:id/country-pricing/:countryId`,
`/products/:id/country-availability/:countryId`), matching the existing variant-routes nesting
pattern. `wood-vintage/backend` commit `03e63b4`.

## Why

`0016` (Countries admin UI) found these tables had only read-side resolution
(`applyCountryOverrides`, wired since `0009`) — no way to set an override except a direct SQL
write. This blocked the product-form "Country Pricing & Availability" section the original
architecture spec called for.

## What was built

Thin controller methods delegating to new `product.service.ts` methods
(`get/set/deleteCountryPricing`, `get/set/deleteCountryAvailability`), following the exact
conventions already established by the sibling variant CRUD in the same file (`AppError` for
not-found, `Number()` coercion, upsert via the existing `@@unique([productId, countryId])`
constraint). `setCountryPricing`/`setCountryAvailability` are upserts — "set" is the natural verb
for "this product's price/availability in this country," not create-vs-update.

## Verification

Real round-trip test, not just a code read: set a real AE override for the seeded "Statement
Canvas Tote" (1499/1299, `isAvailable: false`) via the new endpoint, then confirmed via
`GET /products/statement-canvas-tote?country=AE` that the **existing, already-wired resolution
logic** picked it up immediately — no other code needed to change, confirming the read/write sides
are now correctly connected through the same tables. Deleted both overrides, confirmed a clean 404
on a repeat delete, and confirmed the product correctly fell back to its base price/availability
(599/399/true) once no override existed. Confirmed via direct DB query that no rows were left
behind afterward.

## Consequences

- `tasks/TASKS.md`'s new backend task closes. The product-form "Country Pricing & Availability"
  UI section (deferred in `0016`) can now be built against a real API — tracked as the next
  frontend follow-up once the current URL-restructuring work is done and verified.
- Pushed to both `backend` remotes (`ud-server` and `wood-vintage-server`) — a reminder that this
  repo has two remotes since `0014`, and both need pushing after a meaningful change.
