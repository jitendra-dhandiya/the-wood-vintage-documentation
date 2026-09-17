# 0024. Phase 7 (Analytics): Order.countryId + country revenue breakdown

Date: 2026-09-17

## Decision

Started Phase 7 (Analytics: event tracking, funnel tracking, country dashboards, product analytics,
marketing attribution) by scoping which sub-items are genuinely code-doable without a third-party
analytics vendor decision (see `docs/architecture/phase-7-analytics-spec.md` for the full scope
decision). Two turned out to be already-close: product analytics (`topProducts` already existed in
the admin dashboard, using `totalSold`) and country dashboards, which only needed one real gap
closed: `Order` had no country FK. `wood-vintage/backend` commit `ce44722`. Pushed to both remotes.

## What was built

`Order.countryId` (nullable FK to `Country`, `SetNull` on delete — never `Cascade`, an order is a
permanent record) — real migration (`20260917103634_add_order_country`). `createOrder` already
resolves the `Country` row for pricing/shipping (`resolveCountryByCode`); it just never persisted the
id onto the order itself. Before this, the only country signal on an order was a free-text country
*name* buried inside the `shippingAddress` JSON snapshot — not reliably groupable, and not even
guaranteed to match the `Country` model's canonical name.

New `GET /analytics/country-breakdown` (admin): revenue + order count grouped by country, for `PAID`
orders. Orders with no resolved country (placed before this migration, or with no `country` sent)
report as an explicit `country: null` bucket rather than being silently dropped, so the breakdown's
totals always reconcile with the existing dashboard's revenue figures.

## Verification

- `npx tsc --noEmit` clean.
- Placed a real order with `country: "IN"`, confirmed `Order.countryId` was actually populated
  (not just that the field exists) by querying it directly.
- Marked the order `PAID` and confirmed `GET /analytics/country-breakdown` correctly aggregated it:
  1 order, real revenue total, correct country (`IN`, "India", `₹`).
- Cleaned up afterward: deleted the test order directly (not via `cancelOrder`), which — correctly
  identified during cleanup — bypasses the normal stock-restoration transaction, so
  `stockQuantity`/`totalSold` drifted (99/1 instead of 100/0). Caught and corrected before finishing,
  same discipline as an earlier session's identical lesson (`0013`'s "Data drift from early
  testing").

## Consequences

- Country-level revenue reporting is now real and reliable going forward. Historical orders (all
  test data in this dev DB, already cleaned up) have `countryId: null` and report under the
  "Unknown" bucket — no backfill was needed or attempted.
- The remaining Phase 7 items (event tracking, funnel tracking, marketing attribution) are specified
  in `docs/architecture/phase-7-analytics-spec.md`, built next.
