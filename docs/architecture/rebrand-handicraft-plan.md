# Plan: "The Wood Vintage" client-presentation rebrand

Goal: the storefront and admin must read as a premium Indian handicraft/wooden-furniture brand, not a
fashion-app copy. Everything visible in a client demo (logo, palette, nav, homepage, catalogue,
copy, emails, admin) is in scope. `unique-dressup` is never touched.

## Findings (2026-09-20)
- Logo/brand: `Navbar`, `Footer`, `AdminLayoutClient`, `public/logo*.png`, email layout, ~20 storefront
  pages/constants still say "The Unique Dressup".
- DB settings: site_name "Unique Dressup", tagline "Express Your Unique Style", fashion description,
  `uniquedressup@gmail.com`, announcement banner.
- Mega-menu (screenshot): Accessories / Cargo Pants / Co-ord Sets / Denim / Dresses / Hoodies /
  Oversized T-Shirts, "New Season Styles" promo, snow-mountain banner — all fashion seed data.
- Handicraft taxonomy tables already exist and are empty or generic (Material 11, Style 11, Room 8,
  Artisan 0).

## Workstreams (run by a specialised team)
1. **Brand & UI team (frontend)** — process supplied logo into transparent light/dark/mark/favicon/OG
   variants; wire into Navbar, Footer, admin, emails, metadata; warm wood palette (deep walnut
   `#3B2314`, copper `#A0693A`, cream `#FFFCF5`) applied through the MUI theme, not scattered
   overrides; replace every fashion string with brand-appropriate copy; rework mega-menu to show
   category imagery + real handicraft promo instead of the empty "Browse our complete X" panel.
2. **Catalogue & seeder team (backend/DB)** — repeatable `prisma/seed-handicraft.ts` (backup first,
   never `db push`): real category tree, ~40 products with variants/stock/pricing, materials, rooms,
   styles, artisans with stories, banners, homepage sections, CMS pages, blog posts, coupon, settings
   (name, tagline, contact, announcement). Fashion demo data removed. Product images: real photos only if
   licensable sources are reachable; otherwise clearly-marked generated placeholders (to be swapped for
   client photography) — never fake "real" photos.
3. **QA & design review team** — after 1+2: headless-Chrome walkthrough of every storefront route +
   admin at desktop and 390px mobile, screenshot review for leftover fashion/Unique Dressup content,
   broken images, layout defects, console errors; type-check/build; checkout smoke test with order
   cancelled through the real flow.
4. **Docs** — decision record, TASKS/CHANGELOG/daily-log.

## Constraints
No claude-in-chrome; local headless Chrome only. Push to both remotes per repo (backend, frontend),
origin for docs, after independent verification.
