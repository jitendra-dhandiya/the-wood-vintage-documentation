# Rebrand QA and design review, 2026-09-20

Scope: full storefront and admin walk-through after the handicraft rebrand and catalogue seed
(ADR 0028), ahead of the client presentation. Method: headless Chrome driven over CDP at 1440px
and 390px, screenshots viewed, console/network/overflow captured per page, plus an API-level
order smoke test. Screenshots: `/tmp/claude-1000/qa/*.png` (local, not committed).

## Route results

| Route | 1440 | 390 | Notes |
|---|---|---|---|
| Home | Pass | Pass | Hero overlay, sections and rhythm reworked (see fixes) |
| Shop (+ filters) | Pass | Pass | Finish chips now Natural / Walnut / Honey |
| Category parent (furniture) | Pass | Pass | Includes children products |
| Category leaf (beds) | Pass | Pass | |
| Product: variants (bed), simple (elephant), chess set | Pass | Pass | "Color" relabelled "Finish" |
| Search (`?q=teak`) | Pass | Pass | Same facets as shop |
| Collections list and detail | Pass | Pass | Stale fashion collections were reappearing (fixed) |
| Material, room, style landing | Pass | Pass | |
| Artisans list | Pass | Pass | Artisan detail route not screenshotted (same data path as list) |
| Blog list | Pass (after fix) | Pass | Covers were broken, now render |
| Blog post | Pass (after fix) | Pass | Was a 404 |
| About, contact, FAQ, shipping, returns, terms, privacy | Pass | Pass | Contact details unified |
| Categories index | Pass | Pass | |
| Cart (empty state) | Pass | Pass | |
| Checkout | Pass | Pass | Prompts sign-in modal when logged out |
| Login / register | Pass | Pass | Logo added; register redirects to login |
| Account pages | Not screenshotted | Not screenshotted | Need a real customer session; API flow covered |
| Admin login | Pass (after fix) | n/a | Was 404, no logo |
| Admin dashboard, products, categories, orders, settings, reports | Pass | n/a | |
| Admin product add / edit | Pass | n/a | Both load; edit takes a few seconds to hydrate |
| Admin homepage, banners | Pass | n/a | Only timeouts seen were during a backend restart |

No horizontal overflow at 390px on any storefront route. No console errors on any page apart
from transient connection resets while servers were restarting.

## Defects fixed

1. Blog post pages returned 404: frontend fetched `/blog/:slug`, API is `/blogs/:slug`. Blog covers, category and
   author also used field names the API does not return (`coverImage`, `category`, `author`); added `lib/blog.ts` normaliser.
2. `/admin-login` was redirected under the country prefix and 404'd (middleware matcher). Admin login also had no logo.
3. Backend `initDatabase()` re-created fashion categories, collections, coupons, CMS copy and "Unique Dressup" settings on
   every restart. Defaults are now handicraft; `Home Decor` name chosen so the slug matches the seeded row.
4. Old brand in `emails/layout.ts` (name, tagline, domain, logo, support address, ink/gold colours), `productExport`
   (creator, product URL), `env.ts` mail defaults, package names, admin sidebar ("Unique Dreessup", misspelt),
   admin blog default category "Fashion", admin settings preview rows, `importShopify` meta title.
5. DB settings `logo_url` / `logo_url_light` now point at `/logo-horizontal.png` / `/logo-horizontal-light.png`
   (via `updateLogoSettings.ts --force`; script and seed defaults updated).
6. Red sale badge, "% OFF" text and Save chip changed to walnut/copper. Category tile titles were fluorescent yellow with a red
   button; now white on copper.
7. Finish filter had Mahogany / Espresso / Whitewash / Black chips matching no product; now only the three real finishes.
   Product page label "Color" is now "Finish".
8. Placeholder images baked a large title that duplicated the on-page overlay and was clipped at the edges. Taxonomy,
   category, collection, banner and blog placeholders are now quiet (label only); product labels are fitted to the frame.
   Images regenerated with `SEED_FORCE_IMAGES=1`.
9. Homepage: hero now has an editorial overlay (headline, sub-line, CTA) with a taller mobile box; room/material grids
   centre their last row (8 rooms as 4+4, 9 materials as 5+4); footer had 13 grid columns so Contact wrapped; footer copyright
   contrast raised.
10. Free shipping: announcement said "above 4,999", cart used 999, backend never applied any threshold. Constants and marquee
    copy now 4,999; backend applies `free_shipping_threshold` to Standard delivery and checkout mirrors it. Verified: a
    5,590 order totals 5,590.
11. Page titles doubled the brand ("X | The Wood Vintage | The Wood Vintage"); `NEXT_PUBLIC_SITE_NAME` in `.env.local` was
    "Wood Vintage".
12. Contact page had `+91 XXXXX XXXXX` and a different email from the footer; unified on hello@thewoodvintage.com and the
    settings phone/hours.
13. Admin products page had an "All genders" filter; removed.

## Functional smoke test

Test customer minted with a JWT from the backend secret (OTP login is broken in dev, pre-existing). Add to cart, create order
(COD), then `POST /orders/:id/cancel`. Stock went 22 to 21 on order and back to 22 on cancel. Test order, cart and user were
then deleted; DB now has 0 orders, 0 QA users, 44 products, 17 categories.

## Build

`npx tsc --noEmit` clean in frontend and backend. `npm run build` in frontend succeeds. `.next` was removed and the dev server
restarted on :3030.

## Remaining / not done

- Product images and most banners are labelled placeholders (expected). Hero slide 1 and 3 are placeholders; slide 2 is a real photo.
- Shipping charges quoted on the FAQ and shipping-policy pages (79 / 149 / 249) match the backend's hardcoded rates but not
  the admin "standard/express shipping rate" settings (199 / 499), which the order service does not read. Pick one source of truth.
- Admin Add/Edit Product still shows a Gender selector; `seedGenderDemo.ts` legacy script and the `/admin/settings/gender` page remain.
- Product descriptions concatenate the structured fields, so some text repeats on the product page.
- Cart, checkout and login pages use the default site title rather than a page-specific one.
- Every product shows a "Sale" badge because every product has a compare-at price. Consider making some full-price for realism.
- Account pages and artisan detail not visually reviewed.
- Placeholder brand email domain and phone number are fictional.
