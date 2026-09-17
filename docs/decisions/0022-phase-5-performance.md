# 0022. Phase 5 (Performance): audit + code-doable fixes

Date: 2026-09-17

## Decision

Audited Phase 5 (CDN, images, caching, SSR/SSG, API, database, bundle size, Core Web Vitals)
against the real codebase before building anything, same discipline as every prior phase. Result:
images, SSR/ISR, and API query structure were already largely solid (the image pipeline documented
in `backend/CLAUDE.md` §19 genuinely satisfies the "images" sub-item; no N+1 patterns found).
Implemented the concrete, code-doable gaps the audit found. `wood-vintage/backend` commits
`10edffe`, `83fd368`, `f3e1884`; `wood-vintage/frontend` commit `b387e64`. Pushed to all 4 remotes.

## What was built

1. **Missing composite index** (`10edffe`) — `Product` had `[isActive,isFeatured]`/
   `[isActive,isTrending]`/`[isActive,isNewArrival]` but not the matching `[isActive,isBestSeller]`,
   despite `getBestSellers()` filtering on exactly that combination. Real migration
   (`20260917100222_add_bestseller_index`), not `db push`.
2. **Trimmed over-fetched product-list payloads** (`83fd368`) — `getProducts()` included full
   `material`/`style`/`room`/`artisan` relations and `badges` on every list row; the four
   featured/trending/new-arrivals/best-sellers methods all included `badges`. Verified via grep that
   no frontend consumer of any of these list endpoints (storefront shop/search, or the admin
   collection/gender-settings pickers) reads any of those fields off a list item — they only matter
   on the single-product page, which has its own separate include. Real per-row waste on every
   catalogue/search/homepage-carousel load, not theoretical.
3. **Core Web Vitals reporting** (`f3e1884` backend + `b387e64` frontend) — there was zero
   measurement infrastructure before this (no `web-vitals` usage, no Lighthouse CI, no CI/CD at
   all). Added a minimal, deliberately non-analytics-platform reporting path: `next/web-vitals`'s
   `useReportWebVitals` in a new `WebVitalsReporter` client component (mounted in root layout),
   posting to a new public `POST /metrics/web-vitals` backend endpoint that writes a structured log
   line — no DB model, no dashboard. A real analytics platform is a Phase 7 tool-choice decision
   (GA4/Segment/PostHog/etc.), not something to half-build here.
4. **Bundle analyzer** (`b387e64`) — `@next/bundle-analyzer` wired into `next.config.ts`
   (`npm run build:analyze`). There was no way to measure actual bundle composition (e.g. whether
   admin-only libraries like `@dnd-kit` leak into the storefront bundle) before this — only
   inference. Also confirmed `@mui/x-data-grid` is an unused dependency (declared, never imported
   anywhere) — left in place, not removed, since dependency pruning wasn't the point of this pass
   and removing it is a one-line follow-up if anyone wants it.

## Deliberately not built

- **CDN fronting** — decision `0005` already deferred this to Phase 5/8, correctly: it needs a
  provider choice and DNS change, not code. The image pipeline's content-addressed cache keys mean
  it's a pure fronting change whenever that happens, no rewrite required.
- **In-process/Redis caching for hot read endpoints** (`/homepage/data`,
  `/products/featured|trending|best-sellers`, `/categories/*`) — real opportunity, already tracked
  as P3 in `backend/CLAUDE.md` §26, but PM2 runs `instances: 'max'` in production, so an in-process
  cache would be per-worker (limited value) and a shared cache needs Redis (a new infra dependency).
  No measured slow-query evidence motivating it yet either — left as tracked backlog, not built
  speculatively.
- **`generateStaticParams`/true SSG** for product/category pages — current ISR-with-revalidate is a
  reasonable choice at this catalogue size, not obviously wrong; noted as a future option, not a gap.

## Verification

- `npx tsc --noEmit` (backend) and `npm run type-check` + `npm run build` (frontend) — all clean.
- Booted both dev servers for real. `GET /products` response confirmed to no longer include
  `material`/`badges` keys; `/shop` still rendered a real product (`Statement Canvas Tote`) via
  headless Chrome post-hydration; the one admin consumer that reads list-response fields
  (`admin/collections`' product picker, needs `category.name`/`images[0].url`) confirmed unaffected
  via a real authenticated search call.
- `POST /metrics/web-vitals` with a real payload logged a structured line; a malformed payload
  (bad `name`, non-numeric `value`) was silently ignored rather than crashing or polluting logs.
- Both dev servers stopped cleanly before pushing.

## Consequences

- Phase 5's top code-doable priorities are closed. Remaining items (CDN, shared caching) are
  infrastructure decisions, tracked but not blocking.
- Phase 6 (SEO) spec written next — `docs/architecture/phase-6-seo-spec.md` — built on a real audit
  finding a sitewide fashion-copy metadata leak on several already-indexed pages, plus a genuine
  high-leverage gap (Material/Room/Style landing pages: the data model and admin CRUD already exist,
  only the frontend route is missing).
