# 0032. Per-product country selection (admin) + enforced availability

Date: 2026-09-21

## Decision
Admins choose, per product, the countries it is sold in (add and edit forms, plus a bulk action on the
products list). Each selected non-default country carries its own price in that country's currency.
Availability is now ENFORCED on the storefront and at checkout, not merely annotated.

## Why
0016/0017 left the country tables writable only one row at a time with no UI, and 0009 explicitly left
availability as an annotation (unavailable products still appeared in lists). The client needs
"product A in 2 countries, product B in 3".

## Semantics (exact)
- Country row exists in `ProductCountryAvailability` -> its `isAvailable` wins. **No row -> available**
  (unchanged opt-out default, so legacy/seeded products and any future-enabled market behave as before).
- The admin form always writes an explicit row for EVERY country (enabled or not), so a product saved
  through it is effectively opt-in: unselected = `isAvailable=false`. Disabled markets cannot be selected
  (greyed, "disabled"); they are saved false unless an admin had explicitly set them true.
- Prices: default country (India) = the product's own `basePrice/salePrice` (also the fallback). Any other
  selected country needs `ProductCountryPricing` (positive base, sale < base); the server refuses an
  available non-default country with no price given or on file. Prices of deselected countries are kept.
- A product must be available in >= 1 ENABLED country (422 otherwise); to hide everywhere, deactivate it.
- Create defaults to the default country only, labelled in the form. Editing a product with no rows shows
  a "currently sells everywhere" notice; saving stores the explicit selection.

## Backend
- `PUT /products/:id/countries` (atomic, transaction; admin/sub-admin) body `{countries:[{countryId,isAvailable,basePrice?,salePrice?}]}`;
  `GET /products/:id/countries` (effective state, all countries); `POST /products` accepts a `countries`
  JSON field validated first and written in the same transaction as the create;
  `PUT /products/countries/bulk {productIds,countryIds}` (max 200; never invents prices — refuses products
  lacking a price for a selected country). Logic: `product.service.ts` (`planProductCountries` validates,
  `writeProductCountries` writes). Helpers `availableInCountry`/`getUnavailableProductIds` in `countryPricing.ts`.
- Enforcement: `GET /products` (list AND total), `/products/:slug` (404), featured/trending/new-arrivals/
  best-sellers/search (new `?country=`, now also country-priced), related/suggested products, `POST /orders`
  (400 "not available in <country>", checked before pricing), optional `country` on cart add-item.
- Admin list: `availableCountries` codes per product, `?country=` filter ("sold in").

## Frontend
`components/admin/ProductCountriesSection.tsx` (chips + select all/clear, per-country price rows, "Suggest
from INR (estimate)" using rough fixed rates + 25% margin, clearly labelled), used by add and edit pages;
products list gets a Countries column, "Sold in" filter, row checkboxes and a "Set countries" bulk dialog.
Storefront now passes `country` for home sections and navbar search; sitemap lists products per country.

## Verified (real HTTP)
Create IN-only -> visible `?country=IN`, 404/absent for US (detail, list total 47 vs 46, search, new-arrivals);
edit to IN+US with USD 129/99 -> `/us` shows 129/99, IN keeps 1000/800; remove IN -> hidden in IN; order
for IN with the unavailable product -> 400; invalid payloads (nowhere, missing USD price, sale>=base) -> 422
with nothing created. Test data removed (46 products, 0 orders).

## Known gaps
- Cart add-item country check is not wired from the frontend (checkout enforces it regardless).
- Pre-existing: a variant `price` still beats a country price in `effectivePrice` (order.service) — a variant
  priced in INR would be charged as-is in another country. Products with variant prices need review before
  selling abroad. Shop price filter/sort and admin list price column remain INR-based.
- The frontend caches country lists (5 min) and product pages (revalidate 120s), so availability changes can
  take up to that long to show on cached pages.
