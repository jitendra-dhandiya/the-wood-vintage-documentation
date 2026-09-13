# 0020. Phase 4 backend: real recommendations, artisan directory endpoint, taxonomy homepage sections

Date: 2026-09-13

## Decision

Started Phase 4 (Experience) with a read-only audit of all 9 sub-items (new homepage, category
discovery, product storytelling, recommendations, search, filters, wishlist, recently viewed,
personalization) across both repos, then did the backend-only, well-understood pieces directly
(backend was free). `wood-vintage/backend` commits `35705b4`, `e9486eb`, `ccd6625`.

## What was built

1. **Public artisan directory endpoint** (`35705b4`). `GET /artisans` previously had no list route
   — the controller comment said so explicitly ("no real artisan data yet"). Added
   `ArtisanController.getAll` (active artisans only, mirrors `getById`'s `isActive` filter) and the
   route, ahead of `/:id` per the existing static-before-dynamic convention.
2. **Taxonomy-driven homepage section types** (`e9486eb`). Added `SHOP_BY_ROOM`, `SHOP_BY_MATERIAL`,
   `ARTISAN_SPOTLIGHT` to `HomepageSectionType` via a real migration
   (`20260913143742_add_homepage_taxonomy_sections`). No resolution logic needed backend-side —
   homepage sections are just typed configs; the frontend fetches each section's data from the
   already-existing `roomApi`/`materialApi`/`artisanApi`, same pattern as every other section type.
3. **Real frequently-bought-together recommendations** (`ccd6625`). `getProductBySlug`'s "You May
   Also Like" only ever read the empty, hand-curated `RelatedProduct` join or fell back to
   same-category best-sellers — no actual purchase signal. Added
   `ProductService.getFrequentlyBoughtWith(productId)`: two-step Prisma query (orders containing
   this product → other products in those same orders, grouped and ranked by co-occurrence count).
   Ranked ahead of the category fallback, which now only fills remaining slots up to 8.
   Cancelled/returned/refunded orders are excluded from the signal — verified this mattered: a real
   test order (two products bought together) produced a genuine mutual recommendation, and after
   cancelling that order, the recommendation correctly disappeared (would not have, without the
   status filter, since cancel doesn't delete the `OrderItem` rows — only sets `Order.status`).

## Verification

- `npx tsc --noEmit` clean after each of the three changes.
- Booted the backend for real; minted a real JWT for the seeded admin.
- `GET /artisans` → `200`, empty array (no real artisan data yet, expected).
- Placed a real order (COD, two real products, real inline shipping address) → `201`.
- `GET /products/statement-canvas-tote` → `suggestedProducts` correctly showed the other product
  (real co-purchase signal, not the category fallback — that category has only 1 product).
- Cancelled the test order → re-fetched the same product → `suggestedProducts` correctly went back
  to empty (status filter working, not just coincidence).
- Re-verified the pre-existing category-fallback path separately on a product with a real sibling
  (`floral-wrap-dress`, 2 products in its category) — still returns the sibling correctly.
- Deleted the cancelled test order afterward (not just cancelled) — DB confirmed back to 0 orders.

## Consequences

- The frontend rework this unblocks (new homepage sections, artisan directory page, search facets,
  recently-viewed sync, and — the real headline decision — replacing the MEN/WOMEN gender axis with
  Room/Material/Style as the storefront's primary browsing axis, confirmed with the user) is
  specified separately in `docs/architecture/phase-4-experience-spec.md`, not built here.
- `RelatedProduct` (manual curation) still wins when an admin has actually set it — unchanged
  precedence, just no longer the only non-trivial path.
- No schema/data change to `Product.gender`/`Category.gender`/etc — those stay for the admin side;
  the gender-axis change is a storefront default/UX change, not a data migration. See the spec for
  why a destructive change was explicitly ruled out.
