# Country Architecture — Implementation Spec

Per MASTER-PROMPT §43 (No Blind Coding): write this before implementing. Covers the first real
piece of Phase 1 Foundation — the `Country` model, `CountryContext`, and the minimum wiring needed
for country to become a first-class concept, per the discovery report §18–19.

## Problem

Nothing in the current schema represents "country" anywhere — no country field on `Product`,
`Order`, `User`, or a dedicated model (confirmed in `docs/architecture/phase-0-discovery-report.md`
§4). Every downstream piece of the transformation (pricing, shipping, content, SEO, availability,
promotions per MASTER-PROMPT §9) depends on this existing first.

## Current architecture

Single implicit market (India): prices are one `Decimal` per product (`basePrice`/`salePrice`),
shipping is a flat rate table in `order.service.ts`, content (`HomepageSection`/`Banner`/`CmsPage`)
has no per-market variation, and there's no request-time signal for "which country is this
visitor in."

## Proposed solution

Add `Country` as a first-class Prisma model, plus the minimum set of relations needed for pricing,
availability, and content scoping to actually use it — deliberately **not** building shipping/tax
rule engines yet (that's Phase 3, MASTER-PROMPT §18), just the foundation those will attach to.
Resolve country per-request via a cookie (mirroring the existing `ud_gender` cookie pattern in
`lib/genderPreference.ts` / the SSR gender-read in `CLAUDE.md` §19 — same shape, new concern) rather
than IP/edge detection for this first pass — MASTER-PROMPT §8 wants IP/edge detection as the
*preferred* strategy but explicitly allows falling back through user preference → cookie → browser
locale → default, and edge/IP detection depends on hosting infrastructure (CDN/edge functions) not
yet chosen. **Deliberately scoping this down:** ship the cookie-based context first (fallback tiers
2–4 of §8), add edge/IP detection (tier 1) once real hosting is in place — documented as a
follow-up, not a silent gap.

## Data model

```prisma
model Country {
  id             String   @id @default(uuid())
  code           String   @unique              // ISO 3166-1 alpha-2: "IN", "US", "AE", ...
  name           String
  currency       String                          // ISO 4217: "INR", "USD", "AED", ...
  currencySymbol String
  locale         String                          // "en-IN", "en-US", ...
  timezone       String
  isEnabled      Boolean  @default(false)         // admin turns markets on explicitly
  isDefault      Boolean  @default(false)         // exactly one row should be true; enforced in code, not DB
  sortOrder      Int      @default(0)
  createdAt      DateTime @default(now())
  updatedAt      DateTime @updatedAt

  pricingRules   ProductCountryPricing[]
  availability   ProductCountryAvailability[]
  homepageSections HomepageSection[]
  banners        Banner[]
  cmsPages       CmsPage[]

  @@map("countries")
}

model ProductCountryPricing {
  id         String   @id @default(uuid())
  productId  String
  product    Product  @relation(fields: [productId], references: [id], onDelete: Cascade)
  countryId  String
  country    Country  @relation(fields: [countryId], references: [id], onDelete: Cascade)
  basePrice  Decimal  @db.Decimal(10, 2)
  salePrice  Decimal? @db.Decimal(10, 2)
  createdAt  DateTime @default(now())
  updatedAt  DateTime @updatedAt

  @@unique([productId, countryId])
  @@map("product_country_pricing")
}

model ProductCountryAvailability {
  id         String   @id @default(uuid())
  productId  String
  product    Product  @relation(fields: [productId], references: [id], onDelete: Cascade)
  countryId  String
  country    Country  @relation(fields: [countryId], references: [id], onDelete: Cascade)
  isAvailable Boolean @default(true)

  @@unique([productId, countryId])
  @@map("product_country_availability")
}
```

Plus one nullable `countryId` FK added to `HomepageSection`, `Banner`, and `CmsPage` (null = global
default, set = country override — MASTER-PROMPT §30's Global → Country inheritance, minus the
Language tier for now, since no multi-language work is scoped yet).

**Pricing resolution rule** (mirrors MASTER-PROMPT §29's flat-array pattern, not `priceUSA`/
`priceIndia` columns): if a `ProductCountryPricing` row exists for `(product, country)`, use it;
otherwise fall back to `Product.basePrice`/`salePrice`. This means **not every product needs a row
per country** — only ones that actually need different pricing. Matches "avoid unnecessary
duplication" (MASTER-PROMPT §29).

**Availability resolution rule**: if a `ProductCountryAvailability` row exists, use its
`isAvailable`; if none exists, the product is available (opt-out model, not opt-in) — otherwise
every existing product would vanish from every country the moment this ships, which is wrong.

## API changes

- New admin endpoints: `GET/POST/PUT/DELETE /api/v1/countries` (👑), `GET /api/v1/countries` (🔓,
  enabled countries only, for the frontend's country selector).
- `GET /products` and `GET /products/:slug`: accept `?country=<code>`, resolve price/availability
  per the rules above. Falls back to the default country's pricing when no `country` param is sent
  (backwards compatible — existing calls keep working unchanged).
- `POST /orders`: `effectivePrice()` (added in the pricing fix, `docs/decisions/0003-...`) gets a
  country parameter and checks `ProductCountryPricing` before falling back to `Product` fields —
  same server-authoritative principle, now country-aware. **This is the reason the pricing fix had
  to land before this work**, not the other way around.

## Frontend changes

- `CountryContext` (React context + a resolver), reading from a `wv_country` cookie
  (mirrors `ud_gender`), falling back to browser locale → `Country.isDefault` row. Set via a
  country-selector component (MASTER-PROMPT §21 lists this as a design-system component).
- SSR pages that already read the gender cookie (`/` homepage, category/product pages) add the
  same read for `wv_country`, passed down like `initialGender` is today.
- `services/api.service.ts` calls include `?country=` the same way gender filtering is threaded
  through today.

## Admin changes

- New "Countries" admin section: enable/disable markets, set default, edit currency/locale/timezone.
- Product edit form: optional per-country price/availability override section (only shown for
  enabled countries) — additive to the existing form, not a rebuild.
- Homepage/banner/CMS builders: add a country selector (defaulting to "Global") to the existing
  create/edit forms — same pattern as the existing gender selector on banners.

## SEO impact

None in this pass — no URL structure change yet (MASTER-PROMPT §31 URL strategy is still an open
decision, tracked separately, not resolved by this spec). Country-scoped content becomes possible
but isn't yet reachable by a distinct URL/hreflang — that's Phase 3/6 work once §31 is decided.

## Performance impact

One additional join (`ProductCountryPricing`) on product list/detail queries when a country param
is present; negligible at current catalog size. Indexed via the `@@unique([productId, countryId])`
constraint, which also serves as the lookup index.

## Security impact

None new. Country selection is a display/pricing concern, not an auth concern — no new trust
boundary. The existing "never trust client-supplied price" rule (`docs/decisions/0003-...`)
extends unchanged: country-aware pricing is still resolved server-side from `country` + DB rows,
never accepted as a price value from the client.

## Testing plan

- Unit: pricing resolution (row exists / row doesn't exist / country not found → error) and
  availability resolution (both cases).
- Integration: `POST /orders` with a `ProductCountryPricing` row present charges that price, not
  `Product.basePrice`; with no row present, falls back correctly. Repeat the same exploit-attempt
  style verification used in `docs/decisions/0003-...` (spoof a price, confirm still ignored) now
  in the country-aware path specifically, since that's new code that could reintroduce the bug.
- Manual: enable two countries in admin, set different pricing for one product, confirm the
  storefront shows the right price when the `wv_country` cookie differs.

## Rollback plan

All new tables/columns are additive (new models, nullable FKs) — no existing column is
altered or dropped. Reverting is: drop the new tables via a follow-up migration, remove the
nullable FKs, revert the application code. No data loss risk to existing `Product`/`Order`/content
rows since nothing existing is modified, only extended.

## Status

**Spec only, not yet implemented.** Next step: generate the migration and wire the resolution
logic, once `wood-vintage/backend` is free of other concurrent work (two agents are mid-flight on
security fixes and the stock-restoration bug in that same repo as this spec is being written —
implementing schema changes concurrently in the same working tree risks git/file conflicts, so this
is deliberately sequenced to land after they finish, not in parallel with them).
