# Phase 3 — Country Shipping Rules + Country Admin UI: Implementation Spec

Per MASTER-PROMPT §43. Covers the two additive, non-invasive pieces of Phase 3 (Internationalization)
— country shipping rules (§18) and a country admin UI (§10) — done ahead of the much larger,
invasive URL-restructuring piece (`docs/decisions/0004-international-url-strategy.md`), which gets
its own separate spec given its blast radius touches every existing route.

## Problem

`Country`, `ProductCountryPricing`, `ProductCountryAvailability` exist and work (`0009`, `0010`,
`0013`), but:
1. Shipping is still the flat `SHIPPING_RATES`/per-product-override system from `order.service.ts`
   — no country dimension at all. MASTER-PROMPT §18 wants shipping method, cost, free-shipping
   threshold, estimated delivery, and customs messaging to be country-configurable.
2. There's no admin screen for the `Country` model itself, or for assigning per-country product
   pricing/availability — an admin can only do this via direct API calls today (noted as a gap in
   `0009`/`0010`).

## Proposed solution

### Country shipping rules (backend)

```prisma
model CountryShippingRule {
  id                  String   @id @default(uuid())
  countryId           String
  country             Country  @relation(fields: [countryId], references: [id], onDelete: Cascade)
  method              String   // "STANDARD" | "COD" | "EXPRESS" — same vocabulary order.service.ts already uses
  cost                Decimal  @db.Decimal(10, 2)
  freeShippingThreshold Decimal? @db.Decimal(10, 2)
  estimatedDaysMin    Int?
  estimatedDaysMax    Int?
  customsMessage      String?  @db.Text
  isActive            Boolean  @default(true)
  createdAt           DateTime @default(now())
  updatedAt           DateTime @updatedAt

  @@unique([countryId, method])
  @@map("country_shipping_rules")
}
```

**Resolution rule** (same shape as `ProductCountryPricing`): if a `CountryShippingRule` row exists
for `(country, method)`, use its `cost` (and apply its `freeShippingThreshold` if the order subtotal
qualifies); otherwise fall back to the existing flat `SHIPPING_RATES`/per-product-override logic
unchanged. This is additive — no existing behavior changes for countries with no rules configured
(i.e., India, until someone configures it, keeps behaving exactly as today).

Wire into `order.service.ts`'s existing shipping-charge calculation, extending the precedence chain
that already exists there (per-product override → flat rate) to become: country rule → per-product
override → flat rate. Same file, same function, additive branch — not a rewrite.

Extend `resolveCountryIdForBrowsing`'s sibling logic to also resolve shipping display for the
storefront checkout (mirrors how `0011`'s shipping-display fix mirrors backend logic client-side)
— once a country has shipping rules, checkout should show them, not just the flat rate.

### Country admin API + UI

Backend: `PUT /countries/:id` already exists (from `0009`) for the base fields. Add
`GET/POST/PUT/DELETE /countries/:id/shipping-rules` (admin-only, nested under the country) for
`CountryShippingRule` CRUD — one rule per method per country, matching the `@@unique` constraint.

Frontend admin: a new "Countries" screen (`app/(admin)/admin/countries/`) — list of all 8 seeded
countries (not just enabled ones, unlike the public endpoint) with enable/disable toggle, edit
(name/currency/locale/timezone/isDefault), and a per-country shipping-rules sub-section (add/edit/
delete a rule per method). Also add a lightweight per-country pricing/availability view on the
existing product edit form (a lot of this UI shape already exists for materials/styles/rooms from
Phase 2 — same CRUD screen pattern, reuse it) — a table of enabled countries with an optional
override price/availability field per row, so an admin doesn't need direct API calls to set a
`ProductCountryPricing`/`ProductCountryAvailability` row.

## API changes

- `GET/POST/PUT/DELETE /api/v1/countries/:countryId/shipping-rules` (admin), `GET
  /api/v1/countries/:countryId/shipping-rules` could also be public if the storefront needs to
  display available shipping options per country before checkout — decide based on what the
  frontend piece actually needs when built.
- `order.service.ts`'s shipping calculation extended with the country-rule precedence step.
- Product create/update payload gains an optional array of per-country
  pricing/availability overrides, submitted alongside material/style/room the same way Phase 2's
  product form already handles those.

## Admin changes

New "Countries" admin section (nav entry, matching the pattern Phase 2 added for Materials/Styles/
Rooms/Artisans). Product edit form gains a "Country Pricing & Availability" section.

## SEO / Performance / Security impact

None new — same patterns as `0009`/`0010`/Phase 2's admin CRUD (`isAdmin` guard, indexed FK lookup).

## Testing plan

- `CountryShippingRule` CRUD (create, unique-constraint-per-method enforcement, update, delete).
- Order shipping charge resolves a country rule when one exists, falls back correctly when none
  does — re-run the same style of check `0013` used (real order, real numbers, not just a code read).
- Confirm a country with no shipping rules configured (i.e., every country except whichever gets a
  test rule) behaves identically to before this change — no regression to the existing flat-rate/
  per-product-override behavior.
- Admin Countries screen: enable/disable a country, edit shipping rules, confirm reflected on a
  subsequent order.

## Rollback plan

Fully additive — one new table, no existing column changed. Reverting drops the table and the
admin screen; `order.service.ts`'s fallback path is unaffected since the country-rule branch is
purely additive to the existing precedence chain.

## Status

Spec only, implementation is next — one backend agent (shipping rules + wiring) and one frontend
agent (Countries admin screen), launched in parallel since they don't share files in a way that
would conflict (backend agent stays in `backend/`, frontend agent stays in `frontend/`, and the
frontend piece only needs already-existing `Country`/pricing/availability endpoints, not the new
shipping-rules endpoints, for its first pass — it can add the shipping-rules UI in a follow-up once
the backend contract exists, or the backend agent can finish fast enough that both land together).
