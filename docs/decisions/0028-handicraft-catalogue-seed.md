# 0028. Handicraft catalogue seed replaces the fashion demo data

Date: 2026-09-20

## Decision

Replace all leftover fashion demo data in the `wood_vintage` DB with a believable handicraft
catalogue, via a repeatable, idempotent script: `backend/prisma/seed-handicraft.ts`
(`npm run seed:handicraft`), with content in `backend/prisma/seed-data/{catalogue,content}.ts`.
For the client presentation; all products, prices, artisans, reviews and testimonials are
**fictional demo content**.

## Why

The rebrand (`docs/architecture/rebrand-handicraft-plan.md`, workstream 2) left the storefront showing
Accessories / Cargo Pants / Denim, fashion products, "Unique Dressup" settings and a snow-mountain
banner, and the Phase 6 Material/Room/Style landing pages had no products to show.

## Alternatives

- Hand-editing through the admin UI: not repeatable, slow, and loses work on a DB reset.
- Adding to `initDatabase()` boot seeding: that path is deliberately "create if missing"; this needs
  cleanup plus richer data and should not run on every boot.
- Only real photography: not available yet (see images).

## Chosen approach

- **Backup first.** `mysqldump` (credentials parsed from `.env`, never printed) before any change.
- **Upsert on natural keys** (slug, sku, code, setting key, title): re-running converges. Homepage
  sections and testimonials are rebuilt; product images, tags, badges, FAQs, related products are
  replaced per product. Runs in ~10 s once images exist.
- **Removes** only a hard-coded list of the old fashion rows (10 products, 10 categories, 5
  collections, 8 banners, FASHION15/FLAT200, 6 testimonials). Users, countries, shipping config,
  orders and carts are untouched. Products present on orders would be soft-deleted rather than deleted.
- **Seeded:** 17 categories (4 top-level + 13 children), 44 products (finish variants Natural /
  Walnut / Honey and sizes only where sensible, e.g. beds), 9 materials, 8 styles, 8 rooms (every one
  linked to at least one product), 8 artisans, 4 collections, 6 banners (3 hero, 3 promotional), 11
  homepage sections (incl. SHOP_BY_ROOM, SHOP_BY_MATERIAL, ARTISAN_SPOTLIGHT), 5 blog posts in 3
  categories, 7 CMS pages, 6 sample testimonials, 3 coupons (WELCOME10, FREESHIP, HANDMADE500) and
  the settings (`site_name` "The Wood Vintage", tagline, description, `hello@thewoodvintage.com`
  placeholder, announcement, free-shipping threshold 4999).
- Unused legacy taxonomy rows (Oak, Metal, Industrial, Modern, Scandinavian) are set inactive so no
  landing page is empty.
- **CMS duplicates fixed:** `cms_pages` held 426 rows for 6 slugs (MySQL unique index treats NULL
  `countryId` as distinct). The seed removes the global rows for its slugs and recreates one each.
- **Small backend fix:** `GET /products?categorySlug=` / `categoryId=` now includes a parent
  category's children (Furniture previously returned 0 products because products sit in leaf
  categories).
- **No schema change**; no `db push`.

## Images

Internet access is available (Wikimedia Commons reachable), but suitable licence-free photos of the
specific catalogue items were only found for a handful. Rule: no fabricated "real photos".

- **9 real photos** (Wikimedia Commons, downloaded to `backend/prisma/seed-assets/`, attribution in
  `seed-assets/ATTRIBUTION.json` and below) are used only where they genuinely depict the subject:
  Channapatna toys and artisans, Kutch lacquerware, a hand-carved wooden mirror frame, a wooden
  elephant sculpture, a wooden chopping board, a wooden planter.
- **Everything else is a generated placeholder** (warm wood-grain gradient with the product type and
  "PLACEHOLDER IMAGE - PHOTOGRAPHY TO FOLLOW" printed on it), made with `sharp`. Artisan portraits
  are initials placeholders. **These must be replaced by client photography before launch.**
- Every image is written under `uploads/<folder>/seed-*.jpg` and registered via `getImageUrl()`, so
  the normal derivative pipeline (AVIF/WebP, LQIP) pre-warms it. `uploads/` is not committed; the
  seed regenerates it. `SEED_FORCE_IMAGES=1` regenerates, `SEED_SKIP_PREWARM=1` skips the wait.

### Attribution (all via Wikimedia Commons)

| File | Author | Licence |
|---|---|---|
| Channapatna toys26 / toys107 / toys13 | MaximusPrasad | CC BY-SA 4.0 |
| Finished Channapatna toys | KartikMistry | CC BY-SA 4.0 |
| Lacquerware of Kutch | Geetanjalidhar | CC BY-SA 3.0 |
| Wooden elephant sculptures | AlvinDulle | CC BY-SA 4.0 |
| Wooden Chopping Board | Pisethinfo | CC BY-SA 4.0 |
| A vintage, hand-carved wooden wall mirror frame | Papori Bora | CC BY-SA 4.0 |
| Wooden planter | Stex-1999 | CC0 |

Images were resized and cropped only. CC BY-SA requires attribution and share-alike; add a
credits line/page before public launch (blog posts using them already carry a caption).

## Consequences

- Re-running the seed resets homepage sections and the seeded rows to the script's content:
  admin edits to *those* rows are overwritten. Admin-created products/categories are left alone.
- Testimonials and blog posts are sample content; replace with real ones before launch.
- The seeded coupon/free-shipping threshold are demo values.
- `/settings/public` still returns `logo_url` etc. owned by the frontend rebrand workstream.
- The login validator rejects `.local` emails (`admin@woodvintage.local` cannot log in through
  `POST /auth/login`): pre-existing, not touched here; flagged for the QA team.
