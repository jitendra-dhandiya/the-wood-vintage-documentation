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

### Middleware — CORRECTION (2026-09-13): this app already has one, extend it, don't replace it

This spec originally said "this app currently has none" — **wrong**, verified by actually reading
the file before implementation started. `frontend/middleware.ts` already exists and does real,
deliberate SEO work: a permanent (301) redirect for `/wishlist` → `/account/wishlist`, and a
lookup-based (not config-based, precisely because a slug rename in admin and a deploy are separate
acts at separate times) permanent redirect for renamed category slugs, matched only against
`/category/:slug` and `/wishlist` via `export const config = { matcher: [...] }`. **This logic must
be preserved and composed with the new country-prefix logic, not deleted or overwritten** — read
the full existing file before writing a single line of the new middleware.

Composition, once `[country]` prefixing is live:
- `/wishlist` needs no change — it redirects straight to `/account/wishlist`, which was never
  going to be country-prefixed anyway (an account-family destination). Keep matching the bare
  `/wishlist` path (before any country prefix could apply) or add it to the "never country-prefix
  this" exclusion list — either way, it must keep firing exactly as today.
- `/category/:slug` legacy-slug forwarding moves to firing against `/[country]/category/:slug`
  instead, since `/category` is a `(store)` route and does move under the country segment. The
  slug is at path segment index 3 after restructuring (`['', country, 'category', slug]`), not 2.
  The API check (`fetch .../categories/:slug`) is unaffected — it doesn't need a country.
- Order of operations for a flat legacy request like `/category/old-slug` (no country prefix,
  possibly also a renamed slug): country-prefix redirect fires first (→
  `/in/category/old-slug`), the browser follows it, a *second* request arrives at
  `/in/category/old-slug`, and the legacy-slug redirect fires on *that* request (→
  `/in/category/new-slug`) if the slug is confirmed renamed. Two redirects in sequence for that one
  specific combination (flat + renamed) is correct and acceptable — most requests hit only one or
  neither.

`middleware.ts`'s `matcher` config needs broadening from `['/category/:slug', '/wishlist']` to
cover every storefront path that needs country-prefix resolution, while still explicitly excluding
`/admin`, `/account`, `/login`, `/register`, `/api`, `/_next`, static assets — get this matcher
right or either the exclusions leak (admin gets prefixed, breaking it) or storefront paths get
missed (no redirect happens, defeating the point).

### Middleware — original design (still applies, now composed with the above)

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

## Exact scope, confirmed by reading the actual codebase (2026-09-13)

**Route files that move from `app/(store)/` to `app/[country]/(store)/`** (confirmed via `find`,
26 page/loading/layout/template/error files across these routes — move the whole `(store)`
directory as one unit, don't recreate it file-by-file): `about`, `blog/(index)`, `blog/[slug]`,
`cart`, `categories`, `category/[slug]`, `checkout`, `collections/(index)`, `collections/[slug]`,
`contact`, `error.tsx`, `faq`, `(home)` (the root `page.tsx`), `layout.tsx`, `not-found.tsx`,
`order-success`, `[page]` (CMS catch-all), `privacy-policy`, `product/[slug]`, `return-policy`,
`search`, `shipping-policy`, `shop`, `template.tsx`, `terms`, `track/[waybill]`.

**Files confirmed (via grep) to contain internal absolute links to now-country-prefixed paths —
every one of these needs its `href`/`router.push`/`redirect` calls updated to include the current
country** (read each file, don't guess at the exact link — some may already be relative or use a
helper worth extending rather than hand-editing every occurrence):
`app/(account)/account/orders/page.tsx`, `app/(account)/account/wishlist/page.tsx`,
`app/(store)/about/page.tsx`, `app/(store)/cart/page.tsx`, `app/(store)/categories/page.tsx`,
`app/(store)/collections/(index)/page.tsx`, `app/(store)/not-found.tsx`,
`app/(store)/order-success/page.tsx`, `components/cart/CartDrawer.tsx`,
`components/category/CategoryPageClient.tsx`, `components/home/HeroSlider.tsx`,
`components/layout/MegaMenu.tsx`, `components/layout/MobileBottomNav.tsx`,
`components/product/ProductDetailClient.tsx`, `components/layout/Navbar.tsx` (links to `/`, `/shop`,
`/search?q=`; its `/account/*` and `/admin/*` links are correct as-is, don't touch those).
**This list may not be exhaustive** — it was produced by one grep pattern; the implementer should
re-search (`grep -rn 'href="/\|router\.push(' app components`) after the route move to catch
anything this pattern missed, including relative-looking links that break once nesting changes.

**A `withCountry(path, country)` (or similarly named) helper is worth adding** — a single function
these files call instead of hand-writing `` `/${country}${path}` `` everywhere. Reduces the edit
surface and gives one place to fix if the prefix scheme ever changes again.

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
