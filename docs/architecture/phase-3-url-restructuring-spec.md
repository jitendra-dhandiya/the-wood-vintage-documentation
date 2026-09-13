# Phase 3 — International URL Restructuring: Implementation Spec

Per MASTER-PROMPT §43. Implements the decision already made in
`docs/decisions/0004-international-url-strategy.md` (subdirectory-per-country). **This is the
single most invasive change in the roadmap so far** — every existing storefront URL moves. Written
as its own spec, not folded into the shipping-rules/admin-UI spec, exactly as `0004` said it should
be, and flagged for a confirmation before implementation given the blast radius (touches every
route file, every internal link, sitemap, robots, canonical tags — a mistake here is visible on
every single storefront page, not contained to one feature).

## Problem

Every storefront route today is flat (`/`, `/product/[slug]`, `/category/[slug]`, `/shop`, `/cart`,
`/checkout`, `/[page]` for CMS). There is no URL-level country signal — a shopper in the UK and a
shopper in India see the same URL for the same product, which blocks real hreflang, country-specific
canonicalization, and shareable/indexable per-country pages (the entire point of `0004`'s decision).

## Proposed solution

Move the four storefront-facing route groups under a new `app/[country]/` dynamic segment.
`(admin)`, `(account)`, `(auth)` stay exactly where they are — `0004` already decided these don't
need a country prefix (session-scoped, authenticated surfaces, no SEO value from a URL-level
signal; `CountryContext`'s existing cookie mechanism handles country there unchanged).

### Route tree change

```
Before:                          After:
app/                             app/
├── (store)/                     ├── [country]/
│   ├── page.tsx                 │   └── (store)/
│   ├── product/[slug]/          │       ├── page.tsx
│   ├── category/[slug]/         │       ├── product/[slug]/
│   ├── shop/                    │       ├── category/[slug]/
│   ├── cart/                    │       ├── shop/
│   ├── checkout/                │       ├── cart/
│   └── [page]/                  │       ├── checkout/
├── (admin)/        ← unchanged  │       └── [page]/
├── (account)/      ← unchanged  ├── (admin)/        ← unchanged
└── (auth)/         ← unchanged  ├── (account)/      ← unchanged
                                  └── (auth)/         ← unchanged
```

### Middleware (new — this app currently has none)

`middleware.ts` at the frontend root:
- Matches all paths except `/admin/*`, `/account/*`, `/login`, `/register`, `/api/*`, `/_next/*`,
  static assets.
- If the first path segment is a valid, enabled `Country.code` (case-insensitive, checked against
  a short-lived cached copy of `GET /countries` — don't call the backend on every request; cache
  with a short TTL, e.g. 5 minutes, refreshed in the background), pass through unchanged.
- If the first segment is NOT a valid country code (i.e., this is an old-style flat URL, or the
  root `/`), redirect (307, temporary — country resolution can change) to the same path prefixed
  with a resolved country: `wv_country` cookie if valid → browser `Accept-Language` region → the
  `Country.isDefault` row. This is the same resolution order `CountryContext` already uses
  client-side (`documentation/docs/decisions/0010-...`) — the middleware needs its own
  server-side copy of that logic, since it runs before any React code.
- If the first segment IS a valid country code but that country is currently disabled, redirect to
  the same path under the resolved default country instead (a market can be turned off in admin
  without leaving dead, indexed URLs live).

### CountryContext changes

`CountryContext` currently resolves country from a cookie/locale/default and never reads the URL.
It needs to become URL-first: read the `[country]` route param (available via Next's `useParams()`
or passed down from the server layout, same as `initialGender`/`initialCountry` today) as the
primary source of truth, and use `setCountry()` (the existing cookie-writing function) to keep the
cookie in sync with the URL rather than the URL following the cookie. The country selector's
`setCountry` action changes from "write cookie, update context" to "navigate to the equivalent path
under the new country segment" (e.g., switching from IN to AE on a product page navigates from
`/in/product/x` to `/ae/product/x`, not just updating client state on the same URL).

### hreflang + canonical

Every storefront page's `generateMetadata` gains:
- `alternates.canonical`: the current country's own full path (not the default country's) — each
  country's page is its own canonical entity per `0004`'s reasoning (content/pricing/availability
  legitimately differ).
- `alternates.languages`: one entry per enabled country, pointing to the equivalent path under that
  country's segment (`x-default` pointing at the default country's path).

### Sitemap

`sitemap.ts` currently emits one URL per product/category/blog. It needs to emit one per
(product/category/blog × enabled country) — multiply, don't replace. At current catalog size this
is small; if it grows large enough to matter, a sitemap index (multiple sitemap files, one per
country) is the documented follow-up (`0004`'s "Consequences" already flagged this), not done now.

### Existing bookmarked/indexed URLs

None exist in any real, indexed sense yet (this is still pre-launch, local dev only) — so the
"redirect map for existing SEO equity" concern `0004` raised is **not yet live-relevant**. The
middleware's default-country redirect (above) already handles the mechanical case (flat URL → same
path under the resolved country) with no additional mapping needed. Revisit if real traffic/indexing
exists before this ships to production.

## API changes

None — this is entirely a frontend routing change. The backend's `?country=` query-param interface
(products, orders, CMS, homepage/banners) is unaffected; the frontend still calls it the same way,
just resolves the country value from the URL segment instead of only the cookie now.

## Admin changes

None directly, though admin-authored internal links (e.g., a CMS page linking to a product) need to
either be relative (works automatically under any country prefix) or explicitly country-aware if
absolute — flag this for whoever authors CMS content once real content exists, not a code change.

## Performance impact

Middleware runs on every storefront request — keep the country-validity check cheap (cached list,
not a live API call per request). Negligible otherwise; no additional data fetching per page beyond
what already happens.

## Security impact

None new. Country segment is a routing/display concern; it doesn't touch the order-pricing trust
boundary (`0003`) — `?country=` sent to the backend is still resolved server-side the same way,
regardless of whether it came from a URL segment or a cookie.

## Testing plan

- Every existing storefront page (`/`, `/shop`, `/product/[slug]`, `/category/[slug]`, `/cart`,
  `/checkout`, CMS `[page]`) still renders correctly under its new `/<country>/...` location.
- Middleware redirect: visiting a flat URL (`/`, `/product/x`) redirects to the resolved country's
  equivalent path. Visiting an invalid segment (`/xx/product/x`) and a disabled country's segment
  (`/ae/product/x` while AE is disabled) both redirect to the default country's equivalent path.
- Country selector navigates to the equivalent path under the new country, not just updating state.
- `(admin)`/`(account)`/`(auth)` routes are unaffected — no country prefix, no redirect loop.
- Full re-run of the `0013`-style real end-to-end walkthrough (homepage → shop → product → cart →
  checkout → place order) under the new URL structure, via real CDP-driven browser clicks, not just
  page loads — this is exactly the kind of change where "the page loads" can be true while "the
  actual user flow" is subtly broken (e.g., a Link component pointing at a stale flat path).
- hreflang tags present and correct on a page with the app running under 2+ enabled countries
  (temporarily enable a second country for the test, disable it again afterward — same pattern used
  in `0013`/`0012`'s verification passes).

## Rollback plan

This is a structural move, not additive — rollback means moving the route files back under
`(store)/` and removing `middleware.ts`/the hreflang metadata additions. Because it's a `git mv`-
style restructuring rather than new files, a clean revert is just `git revert` of the commit(s), as
long as it's landed as a small number of well-scoped commits rather than one giant one.

## Why this needs a confirmation, not just autonomous execution

Every other piece of Phase 1–3 so far has been additive (new tables, new nullable columns, new
components) with a clean "does nothing if unused" fallback. This one is different in kind — it
moves every existing route's file location and changes every internal link's effective URL. A
subtle mistake (a stale absolute link, a middleware redirect loop, a missed route) would be visible
on literally every page of the storefront, not contained to one feature. Flagging this explicitly
before implementation, per this session's standing "flag high-blast-radius actions" rule — this
is the first Phase 1–3 piece that clears that bar.

## Status

Spec written, **not yet implemented — awaiting confirmation to proceed** given the scope above.
