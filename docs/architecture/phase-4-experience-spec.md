# Phase 4 — Experience: implementation spec

Date: 2026-09-13. Covers MASTER-PROMPT §47 Phase 4 (new homepage, category discovery, product
storytelling, recommendations, search, filters, wishlist, recently viewed, personalization).

Per the Phase 4 audit (2026-09-13): Filters, Wishlist, and Product Storytelling (backend + PDP)
are already done or near-done. Recommendations (`0020`, backend) and the public Artisan directory
endpoint (`0020`, backend) are already implemented and pushed — see decision `0020`. **This spec
covers what's left: the frontend rework**, item by item. Confirmed with the user (2026-09-13):
**replace the gender axis with Room/Material/Style**, not keep it alongside the new taxonomy.

## §1. The gender axis — what "replace" means precisely

The site is a furniture/handicraft store still built around a MEN/WOMEN/UNISEX toggle
(`genderSlice`, `ud_gender` cookie, `Category.gender`/`Banner.gender`/`Product.gender`/
`InstagramReel.gender` string fields). This is the biggest blast-radius item in Phase 4.

**Do NOT drop the `gender` DB columns or do a destructive migration.** They cost nothing to keep,
existing seeded rows reference them, and a future need (e.g. a "kids' room" facet reusing the same
mechanism) is not worth foreclosing for a cosmetic cleanup. This is a *frontend UX and default*
change, not a schema change.

**Two things must both happen, not just one:**

1. **Hide the UI control.** `Navbar.tsx` already has a `settings.gender_toggle_enabled` admin
   setting (`Navbar.tsx:186`) gating the toggle bar (`Navbar.tsx:211-243` desktop,
   `Navbar.tsx:615-640` mobile drawer). Set this setting to `'false'` via the `/settings` admin API
   or a seed/migration update (check `src/server.ts`'s settings seed for where `gender_toggle_enabled`
   is defined and change its default there, plus update any existing DB row so this doesn't require
   a manual admin step in every environment). Confirm the toggle bar genuinely disappears from both
   desktop and mobile when this is false — it already has the conditional, this should be a real
   effect, not just a default.

2. **Change what "no toggle shown" actually means for browsing** — this is the part that is easy
   to get wrong. `genderSlice`'s default `selected` is `'WOMEN'` (`store/slices/genderSlice.ts:22`),
   and `shop/page.tsx:241` sends `gender: gender || undefined` on every product fetch, `Navbar.tsx`
   filters nav categories/links by it, `homepage/data?gender=` and `categories/home?gender=` do the
   same. If the toggle is merely hidden but `gender` still defaults to `'WOMEN'`, the storefront
   silently hides every product/category/banner not tagged `WOMEN` or `ALL` — a real, silent
   catalogue-visibility bug, worse than the current state. **The default must become "no gender
   filter" (send no `gender` param at all, equivalent to `'ALL'`)**, not just skip rendering the
   toggle. Concretely: default `genderSlice.selected` to `null`/`'ALL'` (whichever the codebase's
   existing `gender === 'ALL'` checks already treat as "everything"), and audit every call site that
   currently reads `s.gender.selected` and forwards it to a fetch — `shop/page.tsx`, `Navbar.tsx`,
   the homepage data fetch, `category`/`collections` pages if they also read it — so all of them
   degrade to "show everything" rather than "show WOMEN." Grep for `gender.selected` and
   `s.gender` across `frontend/` to find every call site; this list is a starting point, not
   exhaustive — re-check as you go, the way the URL-restructuring pass did.

3. Remove the gender-suffix copy in `GenderHomePage.tsx` (`genderLabel` appended to section titles,
   e.g. "Featured Products for Women" → just "Featured Products") and the gender badge on
   `CategoryShowcase.tsx` (~line 132-144). `GenderHomePage.tsx` can keep its filename if renaming
   it is high-effort for no functional gain — but if renaming to something like
   `ExperienceHomePage.tsx` is a small mechanical rename (update the one import site), do it; use
   judgment, this is not the point of the change.

4. Do **not** touch `Product.gender`/`Category.gender`/`Banner.gender` write paths in the admin
   panel (admin forms keep the field — no reason to remove admin flexibility) — only the storefront
   read/default path changes.

## §2. New homepage sections (backend already done, see `0020`)

`HomepageSectionType` now includes `SHOP_BY_ROOM`, `SHOP_BY_MATERIAL`, `ARTISAN_SPOTLIGHT`
(migration `20260913143742_add_homepage_taxonomy_sections`, already applied and pushed). The admin
homepage builder (`app/(admin)/admin/homepage/page.tsx`) has a hardcoded `SECTION_TYPES` array
(~line 53-67) the admin picks from when adding a section — add three entries there, following the
existing `{ type, label, desc }` shape, e.g.:
- `{ type: 'SHOP_BY_ROOM', label: 'Shop by Room', desc: 'Grid of rooms linking to filtered results' }`
- `{ type: 'SHOP_BY_MATERIAL', label: 'Shop by Material', desc: 'Grid of materials linking to filtered results' }`
- `{ type: 'ARTISAN_SPOTLIGHT', label: 'Artisan Spotlight', desc: 'Carousel of artisans linking to their bio page' }`

`GenderHomePage.tsx`'s section-type switch (~line 175-264) needs three new `case` branches. Data
source: `roomApi`/`materialApi`/`styleApi`/`artisanApi` already exist in `services/api.service.ts`
(confirmed by the audit) — call `roomApi.getAll()`/`materialApi.getAll()` for the grids and the new
`artisanApi.getAll()` (public list endpoint added in `0020`) for the spotlight. Link targets:
`/shop?roomSlug=<slug>` / `/shop?materialSlug=<slug>` (the shop page's `FilterPanel` already reads
these params — confirmed by the audit) and `/artisans/<id>` (new page, see §4). Follow the existing
section components' patterns (`CategoryShowcase.tsx` is the closest analog for a linked grid) rather
than inventing new visual language.

## §3. Category discovery

Per the audit, no room/material-based discovery surface exists today — only the category tree with
a (now-removed, see §1) gender badge. §2's `SHOP_BY_ROOM`/`SHOP_BY_MATERIAL` homepage sections are
the primary fix here — they ARE the discovery surface Phase 4 asks for. Do not build a separate
`/rooms` or `/materials` index page unless it's essentially free after §2 (e.g. if the section
component is easily reused as a standalone page) — a second navigation surface for the same three
taxonomies is unnecessary scope for what's actually being asked.

## §4. Product storytelling — close the one real gap

Artisan bio content on the PDP (`ProductDetailClient.tsx:746-807`) already works when data exists.
The one missing piece per the audit: **no public artisan directory page**. Add
`app/[country]/(store)/artisans/page.tsx` (list, using the new `artisanApi.getAll()`) and
`app/[country]/(store)/artisans/[id]/page.tsx` (bio page, using the existing `artisanApi.getById`).
Link the artisan name/photo in `ProductDetailClient.tsx`'s maker card to `/artisans/<id>` (currently
presumably just static text — confirm and add the link). Follow the existing blog or CMS page
pattern for a simple content listing/detail pair rather than inventing new layout primitives.

## §5. Recommendations — done, backend-only (`0020`)

No frontend change needed. `ProductDetailClient.tsx`'s existing "You May Also Like" section already
reads `product.suggestedProducts` — the backend now fills that array with real frequently-bought-
together data first, category fallback second, same field, same shape. Confirm this still renders
correctly after the backend change (it should — the shape is unchanged) but no code change is
expected here.

## §6. Search — add real filters

Per the audit, `getProducts` (the same endpoint the shop page already uses) already supports
`search` combined with `materialSlug`/`styleSlug`/`roomSlug`/price/etc — this is a backend
capability that already exists, confirmed by reading `product.service.ts`. The gap is purely
frontend: `app/[country]/(store)/search/page.tsx` currently calls the narrower
`productApi.search({ q, page, limit })` with no facet UI at all. Change it to call
`productApi.getAll({ search: q, ...facetParams })` (the same call shape `shop/page.tsx` already
uses) and reuse `shop/page.tsx`'s `FilterPanel` component so search results get the same
Material/Style/Room/price filters as browsing. Also fix the fashion-era placeholder text ("Search
for styles, brands, categories...") to furniture-appropriate copy. Do not touch the backend.

## §7. Recently viewed — sync for signed-in users

Per the audit: the backend model + endpoints (`GET/POST /users/recently-viewed`) exist and are
unused; the frontend uses a parallel localStorage-only mechanism
(`lib/recentlyViewed.ts`, `ud_recently_viewed` key, 12-item cap), explicitly documented there as not
touching the backend table.

**Approach:** keep `lib/recentlyViewed.ts` as the mechanism for guests (no backend identity to key
on). For signed-in users, call `userApi.addRecentlyViewed(productId)` when a PDP is viewed
(`ProductDetailClient.tsx`, alongside the existing localStorage write) and, when rendering the
recently-viewed rail, prefer `userApi.getRecentlyViewed()` over localStorage when authenticated,
falling back to localStorage for guests. Do not attempt to merge/de-dupe guest and signed-in
history on login in this pass — that's a reasonable future refinement, not required for Phase 4;
note it as a follow-up in `tasks/TASKS.md` rather than building it now (avoid scope creep here).
Use the existing `useAuth()` hook (`isAuthenticated`) to branch.

## §8. Personalization

Per the audit, zero implementation exists, and building real affinity scoring/ML is explicitly
Phase 8 (Scale) territory per MASTER-PROMPT §47 ("recommendation engine", "AI-assisted
merchandising" are listed there, not Phase 4). **Scope this down**: §5's frequently-bought-together
recommendations and §7's server-synced recently-viewed together constitute this phase's
personalization — no additional work item here. Do not build a "for you" homepage section or any
affinity model in this pass.

## Non-goals (explicitly out of scope for this spec)

- Relabeling/hiding Size/Color filters on `shop/page.tsx` for furniture products (a real, separate
  gap the audit found — track it in `tasks/TASKS.md`, don't fold it into this change).
- Any destructive schema change to `gender` fields.
- A standalone `/rooms` or `/materials` index page beyond the homepage sections (§3).
- Merging guest and authenticated recently-viewed history on login (§7).

## Rollout / commit plan

Follow the URL-restructuring precedent: separate, well-scoped commits so any one piece is
revertible independently. Suggested split:
1. Gender-axis default change + toggle hide (§1) — highest risk, do first and verify catalogue
   visibility carefully (every product/category should be visible with no gender param sent).
2. New homepage sections + admin builder entries (§2) + category-discovery note (§3, likely no code).
3. Artisan directory pages + PDP link (§4).
4. Search facets (§6).
5. Recently-viewed server sync (§7).

## Verification checklist (independent, beyond the implementing agent's own report)

- Real curl/DB check: with the gender toggle disabled, `GET /products` and `GET /categories/home`
  with no `gender` param return the full active catalogue (not silently scoped to WOMEN) — this is
  the single most important check, given §1's silent-hiding risk.
- Homepage renders `SHOP_BY_ROOM`/`SHOP_BY_MATERIAL`/`ARTISAN_SPOTLIGHT` sections when an admin adds
  one of each (create real test sections, verify, then remove them — don't leave test content).
- `/artisans` lists real active artisans (there may be none yet — verify the empty state renders
  sanely, not broken).
- `/search?q=...` shows Material/Style/Room filter chips and narrows results when one is applied.
- A signed-in user's recently-viewed rail matches `GET /users/recently-viewed` after viewing a
  product, not just localStorage; a guest (logged out) still gets a working rail from localStorage.
- `npm run type-check` and `npm run build` both clean.
- No regression: cart, checkout, wishlist, existing homepage sections (hero, featured/new/trending/
  best-sellers, testimonials, instagram reels, store locator, marquee) still render correctly.
