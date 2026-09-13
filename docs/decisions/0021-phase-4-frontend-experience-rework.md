# 0021. Phase 4 frontend: gender-axis replacement, new homepage sections, artisan directory, search facets, recently-viewed sync

Date: 2026-09-13

## Decision

Implemented the frontend half of Phase 4 (Experience) per
`docs/architecture/phase-4-experience-spec.md`, built by a delegated agent and independently
re-verified beyond its own report — this touches the storefront's primary browsing axis, the
highest-blast-radius single item in Phase 4 (bigger than `0018`'s URL restructuring in terms of
what silently breaks if done wrong). `wood-vintage/frontend` commits `6153d9a`, `4e1c285`,
`ec3b18e`, `8728b75`, `e7596b0`; one small `wood-vintage/backend` commit `3163a16`. All pushed to
`origin` and `woodvintage` on both repos.

## What was built

1. **Gender axis replacement** (`6153d9a` + backend `3163a16`) — the highest-risk item. The
   MEN/WOMEN toggle bar is now hidden by default (`gender_toggle_enabled` setting, added to the
   backend seed, defaulting `false`). Critically, hiding the toggle alone was not enough:
   `genderSlice`'s old default (`'WOMEN'`) would have silently scoped the *entire* catalogue to
   women's products the moment the toggle disappeared — nobody would have seen it happen, since
   there would be no toggle to notice was "stuck." Fixed by changing the default to `'ALL'` (no
   filter) throughout — `genderSlice`, `lib/genderPreference.ts`, and every call site that read the
   browsing gender and used to treat only exact-matching/`UNISEX` content as visible
   (`lib/navMenu.ts`, `lib/headerLinks.ts`, `Navbar.tsx`'s quick links, `GenderHomePage.tsx`'s
   category filter) now treats `'ALL'`/unset as "show everything." Also found and fixed a second,
   *ungated* MEN/WOMEN toggle inside `ShopLatestSection.tsx` that the admin setting never controlled
   — not named in the spec, same class of bug, caught during implementation.
   `Product.gender`/`Category.gender`/`Banner.gender` DB columns and admin forms are unchanged —
   this is a storefront default/UX change, not a schema change, as the spec required.
2. **New taxonomy-driven homepage sections** (`4e1c285`) — `SHOP_BY_ROOM`, `SHOP_BY_MATERIAL`
   (new `TaxonomyShowcase.tsx` grid component), `ARTISAN_SPOTLIGHT` (new `ArtisanSpotlight.tsx`
   strip), added to the admin homepage builder's section picker and `GenderHomePage.tsx`'s render
   switch. Backend enum values were already migrated in `0020`.
3. **Public artisan directory** (`ec3b18e`) — `app/[country]/(store)/artisans/page.tsx` (list) and
   `.../artisans/[id]/page.tsx` (bio), following the existing blog/collections listing pattern.
   `ProductDetailClient.tsx`'s "Meet the Maker" card now links to the bio page — the one real gap
   the Phase 4 audit found in product storytelling (the PDP content itself already worked).
4. **Search facets** (`8728b75`) — `/search` now calls `productApi.getAll({ search, ... })` (same
   as `/shop`) instead of the narrower `productApi.search`, and shares `/shop`'s `FilterPanel`
   (extracted to `components/shop/FilterPanel.tsx` — Next.js's route-export validation rejected it
   staying inline in `shop/page.tsx` once `search/page.tsx` needed it too). Fashion-era placeholder
   copy fixed to furniture-appropriate wording.
5. **Recently-viewed server sync** (`e7596b0`) — signed-in shoppers now get `GET
   /users/recently-viewed` (a previously-unused backend endpoint) instead of localStorage, written
   to via `POST /users/recently-viewed` on each PDP view. Guests are unchanged (localStorage only).
   Merging guest/signed-in history on login is explicitly deferred (tracked in `tasks/TASKS.md`).

## Verification

Independently re-verified beyond the implementing agent's own report, per this session's standing
practice:

- Reviewed every commit's actual diff, not just the agent's summary — confirmed the gender-default
  fix is applied consistently across all real call sites (`genderSlice`, `genderPreference.ts`,
  `navMenu.ts`, `headerLinks.ts`, `Navbar.tsx`), and that the backend's existing `gender !== 'ALL'`
  convention (already used by every product/category/homepage endpoint) lines up with the new
  frontend default with no backend changes required beyond the settings-seed default.
- `npm run type-check` and `npm run build` — both clean, run myself, not just trusted from the
  agent's report.
- **The critical check**: real `curl` against a running backend — `GET /products` with no `gender`
  param returns the full 10-product catalogue; `gender=WOMEN` returns 6; `gender=ALL` (what the
  frontend now sends) returns 10. Confirms the silent-narrowing risk is genuinely closed, not just
  plausible from reading the code.
- Confirmed `gender_toggle_enabled: "false"` is actually seeded (`GET /settings/public`), and that
  `categories/home` returning 0 rows is a pre-existing seed-data fact (`showOnHome` never set on
  any category) unrelated to this change — checked `featured` categories separately (7 rows) to
  rule out a regression.
- `/search?q=tote` → real furniture-appropriate placeholder, `200`. `/artisans` → real empty state
  ("No artisans listed yet"), `200`. `/artisans/<bogus-id>` → `404`.
- **Created a real `SHOP_BY_ROOM` homepage section via the admin API**, loaded the homepage through
  local headless Chrome (`google-chrome --headless=new --dump-dom`, never `claude-in-chrome`) to get
  the post-hydration DOM (a raw `curl` only shows the unrendered SSR props for this client-fetched
  section) — confirmed real Room cards rendered with correct `?roomSlug=<slug>` links, then deleted
  the test section.
- Minted a real JWT directly (not fabricated) and round-tripped `POST`/`GET
  /users/recently-viewed` — confirmed the response shape (`data[].product.slug`) exactly matches
  what `ProductDetailClient.tsx` expects, closing the one thing the implementing agent could not
  verify live (it was blocked by an unrelated harness guardrail on its own JWT-minting attempt).
- DB confirmed clean after all testing: 8 homepage sections (original count, test row removed), 0
  artisans, 0 orders, recently-viewed test row removed.
- Both dev servers (backend :5000, frontend :3030) stopped cleanly before pushing.

## Consequences

- Phase 4 (Experience) is substantially done. Remaining, deliberately out of scope here (tracked in
  `tasks/TASKS.md`): Size/Color filter relabeling for furniture products, guest/signed-in
  recently-viewed merge on login, and deeper personalization (explicitly Phase 8 territory per
  MASTER-PROMPT §47).
- Every future homepage section type addition follows the same three-place pattern: schema enum +
  migration, admin builder `SECTION_TYPES` entry, `GenderHomePage.tsx` render case.
- The gender toggle can still be re-enabled by an admin (`/admin/settings/gender` — pre-existing
  screen, unchanged) for a deployment that wants it; the code path is intact, just off by default.
