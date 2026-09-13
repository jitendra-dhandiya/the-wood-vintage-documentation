# 0018. International URL restructuring implemented — `/[country]/...` live

Date: 2026-09-13

## Decision

Implemented the full `/[country]/...` restructuring per
`docs/architecture/phase-3-url-restructuring-spec.md` and decision `0004`. This is the highest-
blast-radius change in the project so far, and was verified accordingly — both by the implementing
agent and independently, more thoroughly than any prior piece this session.
`wood-vintage/frontend` commits `c8cc8c1`, `c148290`, `a866124`, `44eb691` (four well-scoped
commits, matching the spec's rollback-plan preference over one giant commit).

## What was built

- All 34 `(store)` route files moved to `app/[country]/(store)/` via a pure `git mv` (commit 1,
  zero content changes — kept separate from the fix-ups specifically so a revert of "the move
  itself" is unambiguous if ever needed).
- Broken relative imports repaired, `CountryContext` rewritten to be URL-first (`useParams()` wins
  over the cookie tiers; switching country now navigates to the equivalent path, not just updating
  client state), `alternates.canonical`/`alternates.languages` (hreflang) added to product,
  category, collection, CMS `[page]`, and homepage metadata (commit 2).
- **`middleware.ts` extended, not replaced** — composed the new country-prefix resolution with the
  pre-existing wishlist/category-slug-rename redirects exactly per the spec's correction section
  (commit 3).
- Internal links fixed via a new `withCountry()` helper across the 14 spec-listed files plus
  several more a post-move re-grep found (checkout's order-success push, cart's product link,
  collections links, login/admin-login back-links, mobile nav's active-tab matching) — the spec
  explicitly warned its file list might not be exhaustive, and the agent correctly treated that as
  an instruction to re-check, not a ceiling. `sitemap.ts`/`robots.ts` updated for multi-country URLs
  (commit 4).

## Verification

This got more scrutiny than anything else this session, proportionate to the blast radius. The
agent's own verification was already thorough (real CDP clicks, a real category-rename-and-revert
test, hreflang checked with 2 countries temporarily enabled, a full real order placed and
cancelled). Independently re-verified beyond that, with real curl-based redirect-chain testing:

- `/` → 307 → `/in` ✓
- Flat `/product/statement-canvas-tote` → 307 → `/in/product/statement-canvas-tote` → 200 with
  real content ✓
- Invalid country `/xx/product/...` → 307 → `/in/product/...` ✓
- Disabled country `/ae/shop` → 307 → `/in/shop` ✓ (confirmed AE was actually disabled in the DB
  first, not assumed)
- `/wishlist` → 301 → `/account/wishlist` (pre-existing redirect, unaffected) ✓
- **Reproduced the agent's exact category-slug-rename test independently**: renamed
  `hoodies-sweatshirts` to `denims` directly via SQL, requested the old slug —
  `/category/hoodies-sweatshirts` → 307 → `/in/category/hoodies-sweatshirts` → 301 →
  `/in/category/denims` → 200. (First attempt used a slug of `denims-test` instead of the exact
  `denims` the legacy map expects, which correctly 404'd — my own test error, not an app bug;
  redoing it with the exact right slug confirmed the real chain works.) Reverted the category slug
  afterward, confirmed back to `hoodies-sweatshirts`.
- hreflang tags present and correct on a product page (`en-IN` + `x-default`, both pointing at
  `/in/...` — correct, since India is the only enabled country right now).
- `/admin/dashboard` → 200 directly, no country prefix, no redirect.
- `npm run build` succeeded; the route manifest was inspected directly and confirmed the exact
  expected split: 22 `/[country]/...` storefront routes, bare `/admin/*`, `/account/*`, `/login`,
  `/register`.
- DB confirmed clean after all testing: 0 orders, 1 user (the real seeded admin), AE back to
  disabled, product stock/totalSold at 100/0, category slug reverted.

## A real, unrelated bug found along the way

`GET /orders/my` throws a Prisma validation error — `paginationParams()` is called without a
`limit` argument somewhere in that path, producing an incomplete `take`. **Confirmed pre-existing,
not caused by this work** — the agent correctly identified it as out of scope for a frontend-only
change rather than trying to fix a backend bug mid-task, and flagged it instead. Added to
`tasks/TASKS.md` as a new, separate item.

## Consequences

- `tasks/TASKS.md`'s "Country SEO / hreflang / URL strategy" line closes — the last open Phase 3
  item. Phase 3 (Internationalization) is now fully done.
- Every future storefront route addition must land under `app/[country]/(store)/`, not `app/`
  directly — worth a note in `backend/CLAUDE.md`'s frontend-architecture section for anyone (or any
  future session) adding a new page without knowing this changed.
- Blog detail page's metadata was deliberately left without hreflang (the spec's list didn't name
  it) — a small, known gap, not an oversight; add it in a follow-up pass if blog pages become SEO-
  relevant.
- The real `GET /orders/my` bug needs its own fix — tracked, not fixed here.
- This is now the second time this session a "the spec's file list may not be exhaustive, re-check"
  instruction produced a better result than a literal reading would have — worth continuing to
  phrase delegated specs this way for anything involving "fix every occurrence of X."
