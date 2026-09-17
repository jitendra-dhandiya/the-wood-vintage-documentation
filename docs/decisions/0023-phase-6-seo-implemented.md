# 0023. Phase 6 (SEO) implemented

Date: 2026-09-17

## Decision

Implemented the frontend half of Phase 6 (SEO) per `docs/architecture/phase-6-seo-spec.md`, built
by a delegated agent and independently re-verified beyond its own report, same discipline as every
prior phase. `wood-vintage/frontend` commits `0319c4a`, `ebba75b`, `a79906e`, `77fe00d`, `40673e6`.
Pushed to `origin` and `woodvintage`.

## What was built

1. **Fashion-era fallback metadata fixed** (`0319c4a`) — the root layout's title/description/
   keywords said "Premium Fashion Store" / "streetwear, co-ord sets, dresses", silently leaking onto
   5 real, already-indexed pages with no metadata of their own (shop, search, categories, collections
   index, contact). All 5 are Client Components, which cannot export `generateMetadata` directly —
   fixed by adding a sibling Server Component `layout.tsx` per route segment (the codebase's existing
   pattern for this, matching `(auth)/layout.tsx`), each carrying real furniture-appropriate copy.
2. **Footer country-prefixing** (`ebba75b`) — every Footer internal link (Shop/Help/Company groups,
   bottom legal bar) had no `withCountry()` call, forcing a 307 redirect hop on every sitewide
   footer click — the one place decision `0018`'s otherwise-thorough sweep missed.
3. **Blog detail fixes** (`a79906e`) — no `alternates` at all (not even canonical, worse than `0018`
   originally flagged), a hardcoded "Unique Dressup Blog" fallback title, an uncountry-prefixed
   `openGraph.url`, zero JSON-LD. All fixed; `Article` schema added.
4. **Structured data** (`77fe00d`) — two real bugs in the one file that had any JSON-LD
   (`product/[slug]/page.tsx`): hardcoded `priceCurrency: 'INR'` (now resolved via the country's real
   ISO 4217 `.currency` field, same resolution `generateMetadata` in the same file already used for
   hreflang) and a `'LUXÉ'` brand-name leftover. Added sitewide `Organization`+`WebSite` JSON-LD
   (root layout, once), `BreadcrumbList` on product/category/collection/artisans pages (built from
   each page's own real breadcrumb trail, not invented), `Article`/`ItemList` on the blog list page.
5. **Material/Room/Style landing pages** (`40673e6`) — the biggest item. The data model (slug,
   description, image, product relation), admin CRUD, and backend filter support
   (`materialSlug`/`roomSlug`/`styleSlug` on `GET /products`) all already existed; only the frontend
   route was missing. New `TaxonomyPageClient.tsx` (generalizes `CategoryPageClient`'s structure,
   parameterized by taxonomy type) + 3 new routes, each with real metadata, hreflang, and
   `BreadcrumbList`. `sitemap.ts` updated to include these plus collections and artisans, which it
   had omitted entirely before this.

## Deliberately not built (per the spec's non-goals)

- `LocalBusiness` schema for the `Store` model — it has no `lat`/`lng` field; needs a backend
  migration first. Tracked in `tasks/TASKS.md`, not built here.
- Editorial/content-strategy tooling (`targetKeyword` fields, content briefs) — not worth building
  ahead of an actual content program.
- Rebranding seeded DB content — **confirmed live** during verification that `settings.site_name`/
  `site_description` still literally return "Unique Dressup"/fashion copy, and no seeded product has
  a Material/Room/Style FK set (so the new landing pages render correctly but empty). Same root
  cause as the already-tracked "Rebrand seeded content" task — not new, not fixed here, now
  confirmed against the live DB rather than only suspected from code.
- Sitemap index split — current single-file `sitemap.ts` judged adequate at this catalogue size.

## Verification

Independently re-verified beyond the implementing agent's own report:

- Reviewed the actual diff of the highest-risk piece (the currency-resolution logic in
  `product/[slug]/page.tsx`) line by line — confirmed it matches the spec exactly and reuses the
  same country-resolution pattern `generateMetadata` in the same file already used for hreflang.
- Confirmed `GET /materials/:slug` (and the room/style equivalents) are real, existing public
  endpoints before trusting the new landing pages' fetch calls.
- `npm run type-check` and `npm run build` — both clean, run myself.
- Booted both servers for real. `curl` confirmed all 5 metadata-fix pages show furniture-appropriate
  `<title>` tags. `curl` on a product page confirmed all 4 JSON-LD blocks present and correct
  (Organization, WebSite, Product with `priceCurrency: "INR"` correctly *resolved* rather than
  hardcoded, and the real brand name; BreadcrumbList with the correct trail).
- `curl` on `/material/sheesham` and `/room/living-room` (real slugs, fetched live from the backend
  first, not assumed) confirmed `200`, correct title, correct canonical + hreflang tags.
- Headless-Chrome (local, never `claude-in-chrome`) post-hydration DOM dump on a real category page
  confirmed zero un-prefixed Footer links and 15+ correctly `/in/`-prefixed ones.
- `curl`'d `sitemap.xml` directly and counted real entries: 11 material, 8 room, 11 style, 6
  collections, 1 artisans URL — matching the agent's reported counts exactly.
- Both dev servers stopped cleanly before pushing.

## Consequences

- Phase 6's highest-value, code-doable gaps are closed. The new Material/Room/Style landing pages
  are real, working, indexable surface area — currently empty of products only because no seeded
  product has that taxonomy data set yet (a catalog-content gap, not a code gap).
- `LocalBusiness` schema is now blocked on a small, well-scoped follow-up (`Store.lat`/`lng`
  migration) whenever store-locator SEO becomes a priority.
- Every future page needing metadata that's a Client Component should follow the sibling
  `layout.tsx` pattern established here, not silently inherit the root fallback.
