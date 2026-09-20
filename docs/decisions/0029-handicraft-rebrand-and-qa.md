# 0029. Handicraft rebrand for client presentation (logo, theme, copy, QA)

Date: 2026-09-20

## Decision
The storefront and admin were still visibly a fashion app ("The Unique Dressup", Cargo Pants/Co-ord
Sets menu, "New Season Styles"). Rebranded end to end as "The Wood Vintage" and verified with a
specialised team pass (brand/UI, catalogue seeder, QA/design review). Catalogue detail: `0028`. QA
detail: `docs/qa/2026-09-20-rebrand-qa.md`.

## What changed
- Logo from the client's supplied image: transparent full/horizontal/mark/light variants, favicon,
  apple icon, OG image; used in Navbar, Footer, admin sidebar/login, customer login, DB logo settings.
- Walnut `#3B2314` / copper `#A0693A` / cream `#FFFCF5` theme centralised in the MUI theme;
  Cormorant Garamond headings; sale badge/category tiles recoloured to the palette.
- All old-brand and fashion copy replaced (pages, emails, exports, env defaults, package names);
  `initDatabase()` in `server.ts` no longer recreates fashion defaults on boot.
- Mega-menu rebuilt: subcategories + featured products on hover, "Handcrafted by artisans" promo.
- Fixes found by QA: blog detail 404 (wrong endpoint) and cover shape, `/admin-login` 404 behind the
  country middleware, Finish filter chips matching no product, free-shipping threshold now actually
  applied by the backend (was announced but never applied), contact details unified.

## Known gaps / follow-ups
- Product/banner/category images are labelled placeholders; 9 Wikimedia photos need a credits line
  before public launch. Client photography to replace them.
- Contact email/domain/Instagram are placeholders; testimonials/artisans/blogs are fictional demo.
- Shipping charges: FAQ/shipping-policy (₹79/149/249) match hardcoded backend rates, not admin
  settings (₹199/499) — needs one source of truth.
- Add/Edit Product still has a Gender selector; every product shows "Sale" (all have compare-at
  prices); product descriptions repeat structured-field text; cart/checkout/login use default titles.
- Policy figures (36-hour window etc.) inherited from the fashion app, unreviewed.
