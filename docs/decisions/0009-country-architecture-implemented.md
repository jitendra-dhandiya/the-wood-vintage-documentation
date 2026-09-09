# 0009. Country architecture implemented (backend), per spec

Date: 2026-09-09

## Decision

Implemented the Country architecture designed in
`docs/architecture/country-architecture-spec.md` against `wood-vintage/backend`: `Country`,
`ProductCountryPricing`, `ProductCountryAvailability` models; a nullable `countryId` on
`HomepageSection`/`Banner`/`CmsPage`; the 8 launch markets seeded (India enabled+default, the
other 7 seeded but disabled); pricing/availability resolution wired into the product list/detail
endpoints and `order.service.ts`'s `effectivePrice()`; a `Country` admin CRUD module. Frontend
`CountryContext`/cookie/selector and the `/[country]/` URL routing (`docs/decisions/0004-...`)
remain explicitly out of scope — separate follow-up tasks.

## Why

This was the next item in `tasks/TASKS.md` Phase 1 once both repos were confirmed clear of other
in-flight work. Delegated to a background agent with the already-written spec as its blueprint
(implementation from a clear spec is well-suited to delegation — the design decisions were already
made in `0009`'s parent spec, not left to the implementer).

## What was built

- **Schema**: migration `20260909124334_add_country_architecture`. FK behavior: `Product` →
  pricing/availability rows cascade-delete; `HomepageSection`/`Banner`/`CmsPage` → `countryId` sets
  null on country delete (a "Global → Country override" reverts to Global rather than blocking the
  country's deletion — matches the spec's inheritance model).
- **Seed**: added to `server.ts`'s idempotent `initDatabase()`, using the real ISO data from
  `docs/countries/launch-markets-reference.md`. India `isEnabled: true` + `isDefault: true` (it's
  the only market with real data today); the other 7 seeded with correct data but `isEnabled: false`
  — admin turns them on later, per the spec.
- **Resolution logic**: `src/utils/countryPricing.ts` — a `ProductCountryPricing` row wins over
  `Product.basePrice`/`salePrice`; a `ProductCountryAvailability` row wins over the opt-out default.
  Shared between `GET /products`/`GET /products/:slug` (both take `?country=<code>`) and
  `order.service.ts`. The "never trust client-supplied price" discipline from `0003` is preserved —
  `POST /orders` takes an optional `country` field, but it only selects *which* DB row to charge,
  never a price value itself.
- **Admin module**: `src/modules/countries/` — `GET /countries` (public, enabled only),
  `GET /countries/admin/all` + `POST`/`PUT`/`DELETE /countries` (admin), following the existing
  `/blogs/admin/all`-style convention in this codebase.

## Judgment calls made (spec was ambiguous on these — reviewed, all reasonable)

- **Public vs. admin listing path**: spec implied `GET/POST/PUT/DELETE /countries` on one path;
  resolved as `/countries` (public) + `/countries/admin/all` (admin), matching this codebase's own
  established convention elsewhere. Consistent, not a deviation worth re-litigating.
- **Unknown country code**: read-only product endpoints degrade silently to base pricing (a bad
  query param on a public browse page shouldn't 400 the whole page); `POST /orders` hard-400s on
  the same bad code, since real money moves there. Not stated explicitly in the spec, but follows
  the spec's own server-authoritative principle correctly — reviewed and endorsed.
- **Can't delete/un-default the `isDefault` country**: not specified, but leaving zero default
  countries would break every "no `?country=` param" fallback path. Correct defensive call.
- **Availability doesn't filter `GET /products` list results** (opt-out-unavailable products stay
  in listings, just annotated `isAvailable: false`) — filtering would need to also adjust the
  pagination `total` count, which the agent correctly flagged as scope creep beyond "resolve
  availability." Left as a explicit follow-up, not silently done differently from the spec.

## Verification

Independently re-verified after the fact (this session, not just trusting the report): confirmed
the real commit (`21efdff`), clean `npm run build`, migration applied (`prisma migrate status`:
up to date), all 8 countries seeded correctly via direct DB query (`SELECT code, isEnabled,
isDefault FROM countries` — matches exactly what was claimed), zero test-data pollution (0 orders,
0 `product_country_pricing` rows, 1 user = the real seeded admin). Booted the backend myself and
independently confirmed: `GET /countries` returns only India, `GET /products/statement-canvas-tote`
with no country param and with an unknown `?country=ZZ` both correctly return base pricing
(599/399), admin country endpoints correctly 401 without a token. Read the actual resolution logic
(`countryPricing.ts`) and the admin controller's delete-guard code directly — both match the
reported design and follow this codebase's existing conventions (`AppError`, `sendSuccess`/
`sendError`, transactions for the `isDefault`-uniqueness invariant).

The agent's own verification (trusted, specific and credible, not independently re-run in full):
created a real `ProductCountryPricing` override (AE: 1499/1299 vs. INR base 599/399), confirmed
`?country=AE` returns the override and other countries don't; placed a real order with `country:
"AE"` and a spoofed `price: 1` — charged 1299 (the AE override), not 1 and not the INR price; a
second order with no country and the same spoof charged 399 (INR) — confirming the original
pricing-fix regression still holds with country-awareness added on top. `POST /orders` with an
unknown country correctly 400'd.

## Consequences

- `tasks/TASKS.md`'s "Country architecture" line moves from "spec written" to "backend implemented."
- Frontend work (CountryContext, cookie, selector, threading `?country=` through
  `services/api.service.ts` and the ~5-6 storefront pricing-display components scoped in the spec)
  is now unblocked and is the next natural piece — the backend contract it needs now exists and is
  verified working.
- The `/[country]/` URL routing (`0004`) and full country-scoped CMS/homepage admin UI remain
  separate, larger follow-up tasks — the data model for the latter exists (`countryId` on
  `HomepageSection`/`Banner`/`CmsPage`) but no admin UI or resolution logic reads it yet.
