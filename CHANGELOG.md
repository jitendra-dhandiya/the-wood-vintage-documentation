# Changelog

Project-level changelog across all three `wood-vintage` repos (backend/frontend/documentation),
per MASTER-PROMPT §44. Record date, feature, files/DB/API changed, migration requirements, testing
status, deployment notes for every major change. Day-to-day detail belongs in `daily-log/`; this
file is the higher-level, release-facing summary.

## 2026-09-09

- Initiated the `wood-vintage` project: `backend`, `frontend`, `documentation` set up as fresh git
  repos, `backend`/`frontend` seeded from a file copy of `unique-dressup` (no inherited history or
  remotes). `documentation` repo scaffolded with daily-log, task tracker, skills log, decision
  records, and `docs/claude` + `docs/agents` structure.
  - Files changed: new repos, no application logic changed yet.
  - DB changes: none.
  - API changes: none.
  - Migration requirements: none yet — `.env` setup still pending in `backend`/`frontend` (see
    `tasks/TASKS.md`).
  - Testing status: N/A (no code changes).
  - Deployment notes: no remotes configured yet for any of the three repos.
- Ran `npm install` in `wood-vintage/backend` (510 packages) and `wood-vintage/frontend`
  (487 packages).
  - Files changed: `package-lock.json` and `node_modules/` (gitignored) in both repos.
  - DB changes: none.
  - API changes: none.
  - Migration requirements: none.
  - Testing status: install completed clean in both; `npm audit` found frontend has 2 critical +
    7 high vulnerabilities (`next`, `swiper` among them) and backend has 17 (2 low, 8 moderate,
    7 high, none critical) — logged in `docs/claude/technical-debt.md`, not yet fixed (available
    fixes for the critical ones are breaking changes).
  - Deployment notes: neither app has a working `.env`/`.env.local` yet, so neither runs end-to-end.
- Stood up a working local dev environment: `backend/.env` and `frontend/.env.local` recreated,
  new local MySQL DB `wood_vintage` created and schema pushed, frontend's hardcoded `API_URL` fixed
  to read `NEXT_PUBLIC_API_URL`, dev port conflicts with other projects on this machine resolved
  (frontend now on :3030). Full stack verified booting and talking to each other end-to-end.
  - Files changed: `backend/.env` (new, gitignored), `frontend/.env.local` (new, gitignored),
    `frontend/package.json` (`dev` script → port 3030), `frontend/constants/index.ts` (`API_URL`
    fix), `frontend/lib/axios.ts` (removed stray `console.log`). See `wood-vintage/frontend` commit
    `97e502d`.
  - DB changes: new local MySQL database `wood_vintage` created; full Prisma schema pushed to it
    (`npm run prisma:push`); first-boot seed ran (settings, categories, collections, homepage
    sections, banners, testimonials, coupons, SEO meta, CMS pages, one SUPER_ADMIN).
  - API changes: none (bugfix to how the frontend reads its own config, not an API contract change).
  - Migration requirements: none for this change; real third-party secrets (Razorpay, Google OAuth,
    Brevo/SMTP) still need to be supplied before those features work.
  - Testing status: backend boot verified (`GET /health` → 200, seed completed); frontend boot
    verified (`GET /` → 200, correct title reflecting `NEXT_PUBLIC_SITE_NAME`); frontend
    `tsc --noEmit` clean. No automated test suite exists in either repo (inherited from
    `unique-dressup` — `backend/CLAUDE.md` §23).
  - Deployment notes: local dev only. Dev servers were stopped after verification, not left
    running. See `docs/decisions/0002-local-dev-environment-setup.md` for the full rationale.
- Completed Phase 0 (Discovery): `docs/architecture/phase-0-discovery-report.md`, all 25 sections
  per MASTER-PROMPT §50. Sections 1–17 are current-state facts (synthesized from the inherited
  `CLAUDE.md`, spot-verified not fully re-audited); 18–25 are new recommendations — Country/
  CountryContext model, country-scoped CMS extension, a revised Phase 1 sequencing (migration
  history + server-authoritative pricing before country work), and an explicitly undecided
  international URL strategy flagged for its own future decision record.
  - Files changed: `docs/architecture/phase-0-discovery-report.md` (new), `tasks/TASKS.md`,
    `docs/claude/current-roadmap.md`.
  - DB changes: none.
  - API changes: none.
  - Migration requirements: none for this entry; the report itself recommends migration-history
    adoption as the first Phase 1 task.
  - Testing status: N/A (documentation only).
  - Deployment notes: N/A. One open product question raised, not resolved — see `tasks/TASKS.md`
    Phase 0.
- Phase 1 (Foundation), first two prerequisite tasks: real Prisma migration history, and
  server-authoritative order pricing (was trusting client-supplied `data.items[].price` — a real,
  confirmed-exploitable critical bug, not a hypothetical one).
  - Files changed: `backend/prisma/migrations/20260909115445_init/` (new), `backend/CLAUDE.md`
    (migration-strategy section + Known Issues #1/#2/#12 corrected), `backend/src/modules/orders/
    services/order.service.ts` (`effectivePrice()`). See `wood-vintage/backend` commit `2e2f827`
    and `docs/decisions/0003-phase-1-foundation-prerequisites.md`.
  - DB changes: `wood_vintage` reset (mysqldump backup taken first; DB held only throwaway seed
    data) and rebuilt from the new migration baseline. No production DB touched.
  - API changes: none to the request/response contract — `POST /orders` still accepts
    `items[].price` for backwards compatibility, it's simply no longer used for any calculation.
  - Migration requirements: schema changes from here forward go through `prisma migrate dev`, not
    `prisma db push` (still technically works, but would desync history if used).
  - Testing status: `npm run build` clean. Migration verified via `prisma migrate status` (in
    sync) and a full backend boot/reseed. Pricing fix verified with an actual exploit attempt
    (spoofed `price: 1` on a real ₹399 product, correctly charged ₹399 after the fix) — not code
    review alone. Test user/order/script cleaned up afterward.
  - Deployment notes: local dev only; not deployed anywhere. `unique-dressup` unaffected — this
    fix was not backported there.
- Frontend: all 9 npm vulnerabilities fixed (2 critical, 7 high), `npm audit` now clean. `next`
  patched (`15.5.19` → `^15.5.25`, no code changes), `swiper` patched (`^11.1.14` → `^14.2.0`,
  npm called it breaking but the real usages needed no changes), `postcss` pinned via an
  `overrides` entry.
  - Files changed: `frontend/package.json`, `frontend/package-lock.json`. See
    `wood-vintage/frontend` commit `d1ec1a0` and `docs/decisions/0007-frontend-npm-vulnerabilities-fixed.md`.
  - DB changes: none.
  - API changes: none.
  - Migration requirements: none.
  - Testing status: `tsc --noEmit` + `npm run build` clean; full-stack boot + `curl` confirmed
    correct SSR markup for both carousels. Independently re-verified after the fact (not just
    trusted): `npm audit` re-run shows 0 vulnerabilities. **Disclosed gap**: real-browser
    hydration/interactivity of the carousels not verified (tooling couldn't reach this sandbox's
    localhost) — tracked as a follow-up.
  - Deployment notes: local dev only.
- Six architecture decisions recorded for Phase 1 Foundation, done in parallel with the two
  background agents above (no code changes, documentation-repo only): Country/Currency
  architecture spec (not yet applied to the backend schema), international URL strategy
  (subdirectory-per-country), launch-market reference data for all 8 markets, Media/CDN
  architecture (reuse existing pipeline), and SEO foundation scope. See `docs/decisions/0004`
  through `0006` plus the country spec in `docs/architecture/`.
  - Files changed: `docs/architecture/country-architecture-spec.md`,
    `docs/decisions/0004-international-url-strategy.md`,
    `docs/decisions/0005-media-cdn-architecture.md`, `docs/decisions/0006-seo-foundation-scope.md`,
    `docs/countries/launch-markets-reference.md`, plus `tasks/TASKS.md` and
    `docs/claude/known-decisions.md` updates.
  - DB/API changes: none — specs and decisions only, no implementation yet.
  - Testing status: N/A (documentation only).
  - Deployment notes: N/A. Three open product/business questions consolidated at the top of
    `tasks/TASKS.md`, explicitly not blocking current engineering work.
- Backend: npm vulnerabilities 17 → 2 (remaining confirmed unreachable, left deliberately), plus
  two critical/high correctness bugs fixed: stock-not-restored-on-cancel (`CLAUDE.md` §25 #3) and
  `InventoryLog` never written (§25 #21) — both fixed together since they're the same code path.
  - Files changed: `backend/package.json`/`package-lock.json`, `backend/src/modules/orders/
    services/order.service.ts`, `backend/src/utils/imagePipeline.ts` (one import fix from the
    `sharp` bump), `backend/CLAUDE.md`. Commits `044b79d`, `bf811c8`. See
    `docs/decisions/0008-backend-security-and-stock-restoration.md`.
  - DB changes: none to schema; `InventoryLog` rows now populated going forward.
  - API changes: none to the contract.
  - Migration requirements: none.
  - Testing status: each dependency bump individually verified (build + boot + real endpoint
    curls) before keeping; stock-restoration verified live with real before/after numbers (stock
    50→47→50, totalSold 0→3→0) plus the resulting `InventoryLog` rows. Independently re-verified
    after the fact (this session): real commits confirmed, `npm audit`/`npm run build` re-run
    myself, dev DB confirmed free of test pollution.
  - Deployment notes: local dev only. Not backported to `unique-dressup`.
- Frontend: fixed the CMS-routing 404 bug (`CLAUDE.md` §25 #7) — one-line URL fix
  (`/cms/` → `/seo/cms/`), applied directly (not delegated) once both background agents' work was
  confirmed complete and their repos clean.
  - Files changed: `frontend/app/(store)/[page]/page.tsx`. Commit `3f4763c`.
  - Testing status: verified live — `GET /about` went from 404 to 200 with real seeded content.
  - Deployment notes: local dev only.
- Backend: implemented the Country architecture per the earlier spec — `Country`,
  `ProductCountryPricing`, `ProductCountryAvailability` models; nullable `countryId` on
  `HomepageSection`/`Banner`/`CmsPage`; 8 launch markets seeded (India enabled+default, 7 others
  seeded but disabled); pricing/availability resolution wired into `GET /products*` and order
  creation; a `Country` admin CRUD module.
  - Files changed: `backend/prisma/schema.prisma` + new migration
    `20260909124334_add_country_architecture`, `backend/src/utils/countryPricing.ts` (new),
    `backend/src/modules/countries/` (new), `backend/src/modules/orders/services/order.service.ts`,
    `backend/src/modules/products/**`, `backend/src/server.ts` (seed). Commit `21efdff`. See
    `docs/decisions/0009-country-architecture-implemented.md`.
  - DB changes: 3 new tables, 3 new nullable FK columns, 8 new `Country` rows.
  - API changes: `GET /products`/`GET /products/:slug` accept `?country=<code>` (backwards
    compatible — no param behaves as before); `POST /orders` accepts an optional `country` field
    (still never trusts a client-supplied price, only selects which DB row to charge); new
    `/api/v1/countries*` endpoints.
  - Migration requirements: none beyond the migration itself (already applied to the dev DB).
  - Testing status: real verification, not just a code read — a live `ProductCountryPricing`
    override was created and confirmed to actually change the served price; a real order was
    placed with a spoofed client price *and* a country override present, and was correctly charged
    the DB-derived country price, not the spoofed value; unknown country codes correctly degrade
    (browse endpoints) or 400 (orders); admin endpoints correctly require auth. Independently
    re-verified after the fact (this session) with extra scrutiny given this touches pricing again
    — re-ran the build, the migration status check, the DB seed check, several live endpoint calls,
    and read the actual resolution-logic and admin-controller source directly.
  - Deployment notes: local dev only. Frontend `CountryContext` and the `/[country]/` URL routing
    are explicitly separate, not-yet-started follow-ups.
- Backend: Global→Country content resolution for CMS pages, homepage sections, and banners — the
  data model existed (previous entry) but nothing read it. Also fixed a real schema gap found
  along the way: `CmsPage.slug` was still globally unique, which would have blocked a country
  override from ever coexisting with the global page under the same slug.
  - Files changed: `backend/prisma/schema.prisma` + new migration
    `20260909130000_cms_page_slug_per_country` (hand-written — `prisma migrate dev` can't run
    non-interactively once it needs to warn about a constraint change), `backend/src/utils/
    countryContent.ts` (new), `backend/src/modules/{seo,homepage,banners}/controllers/*.ts`,
    `backend/src/modules/products/services/product.service.ts` (moved a shared helper into
    `countryPricing.ts`). Commit `9c7d0ad`. See `docs/decisions/0010-...`.
  - DB changes: `cms_pages` unique index changed from `(slug)` to `(slug, countryId)`.
  - API changes: `GET /seo/cms/:slug`, `GET /homepage`, `GET /homepage/data`, `GET /banners/:type`
    all accept `?country=<code>` now; no param behaves exactly as before.
  - Testing status: verified directly against the DB with a throwaway script (deliberately no HTTP
    server, to avoid a port collision with a concurrently-running agent using the same repo) —
    global content resolves correctly with no country, a real country override wins for that
    country while other countries still see global, an unknown slug returns null rather than
    erroring, and homepage sections/banners correctly show only the country-specific set (not
    merged with global) once one exists. All test rows cleaned up, confirmed via direct query.
  - Deployment notes: local dev only.
- Frontend: `CountryContext`, `wv_country` cookie, `CountrySelector`, `?country=` threaded through
  the real storefront pricing surface (product detail, category/collection listings, cart,
  checkout).
  - Files changed: `frontend/lib/countryPreference.ts` (new), `frontend/contexts/CountryContext.tsx`
    (new), `frontend/components/common/CountrySelector.tsx` (new), plus `app/layout.tsx`,
    `app/(store)/*`, `components/{layout,category,product}/*.tsx`, `services/api.service.ts`,
    `types/index.ts`, `utils/format.ts`. Commit `6536c70`. See `docs/decisions/0010-...`.
  - DB/API changes: none new (consumes the backend contract from the previous entry).
  - Testing status: `tsc --noEmit` + `npm run build` clean. Verified twice — once by the
    implementing agent (live pricing-override test via curl, `POST /orders` with both a spoofed
    price and a country override charging correctly, an unknown country code 400ing at checkout),
    and again independently in this session (booted both servers, created a fresh real pricing
    override, `curl`'d the SSR product page with and without the country cookie, confirmed the
    exact price difference directly rather than trusting the report). DB confirmed clean both times.
  - Deployment notes: local dev only. No admin UI yet for authoring country-scoped content — the
    resolution logic works, but creating country-scoped rows currently requires direct API calls.

## 2026-09-10

- Frontend: checkout now shows the real per-product shipping-charge override instead of always the
  flat rate (`technical-debt.md` gap tracked since `0003`).
  - Files changed: `frontend/types/index.ts`, `frontend/app/(store)/checkout/page.tsx`. Commit
    `76c55e4`. See `docs/decisions/0011-checkout-shipping-display-fix.md`.
  - DB/API changes: none — the data was already returned by the existing cart/product endpoints.
  - Testing status: `tsc --noEmit` + `npm run build` clean. **Not** live/browser verified — checkout
    is a client component, and the browser-automation tool available in this environment can't
    reach this sandbox's localhost (confirmed again, same limitation as the Swiper carousel
    verification gap in the 2026-09-09 entry). Disclosed as an open gap, not claimed as done.
  - Deployment notes: local dev only.
- Backend: Phase 2 (Handicraft Domain) implemented — `Material`/`Style`/`Room`/`Artisan` models
  (11/11/8 seeded, artisans correctly unseeded), CRUD modules, `Product` gains material/style/room/
  artisan relations plus dimensions/finish/assembly/customization/manufacturing-time/craft-story
  fields, `GET /products` gains `?materialSlug=&styleSlug=&roomSlug=`.
  - Files changed: `backend/prisma/schema.prisma` + migration `20260910043130_add_handicraft_domain`,
    `backend/src/modules/{materials,styles,rooms,artisans}/` (new), `backend/src/server.ts` (seed),
    `backend/src/modules/products/**`. Commit `59964a4`. See
    `docs/architecture/phase-2-handicraft-domain-spec.md` and `docs/decisions/0012-...`.
  - DB changes: 4 new tables, 4 new nullable FK columns + several scalar columns on `Product`,
    30 new seeded rows (11 materials + 11 styles + 8 rooms).
  - API changes: new `/materials*`, `/styles*`, `/rooms*`, `/artisans*` endpoints (public read +
    admin CRUD); `GET /products` gains the three new filters; product responses include the new
    relations as full objects.
  - Migration requirements: none beyond the migration itself (applied to the dev DB). Notably, this
    migration applied via normal `prisma migrate dev` with no non-interactive-environment issue —
    that problem (hit for the CMS-slug fix in `0010`) appears specific to migrations needing a
    destructive-change warning, not a general limitation.
  - Testing status: real verification — an existing demo product was updated with a full set of the
    new fields via the API and confirmed to round-trip correctly (nested objects, not just ids);
    filters confirmed matching/non-matching/unknown-slug cases; a pre-existing untouched product
    confirmed unaffected (all-null new fields, renders fine); full admin CRUD exercised end-to-end
    on one taxonomy module. Independently re-verified after the fact: real commit confirmed, DB
    counts queried directly (not just trusted), controller source read directly, filter checks
    re-run independently.
  - Deployment notes: local dev only. Frontend (display, filters, admin UI) not yet started.
- Closed/narrowed two disclosed browser-verification gaps using a newly-found capability (local
  headless Chrome, since `claude-in-chrome` drives the user's own machine and can't reach this
  sandbox — see `skills/SKILLS.md`).
  - The Swiper carousel hydration gap from the 2026-09-09 entry (`0007`) is **closed**: post-JS DOM
    dump of the homepage shows real Swiper runtime classes (`swiper-initialized`,
    `swiper-slide-active`, `swiper-pagination-bullet-active`), proving actual client-side
    initialization, not just correct SSR markup.
  - The checkout shipping-display gap from earlier today (`0011`) is **narrowed, not closed**:
    confirmed `/checkout` renders without a JS crash on an empty cart; the full override
    calculation with a populated cart still isn't verified in a real browser (would need CDP
    scripting to seed cart state before navigating — deferred as disproportionate effort against a
    low-risk, already-reviewed few lines of logic).
  - See `docs/decisions/0012-phase-2-backend-and-closed-verification-gaps.md`.
- Frontend: Phase 2 (Handicraft Domain) frontend — material/style/room/dimensions/finish/assembly/
  customization display on the product page, a craft-story narrative section, a "Meet the Maker"
  artisan card, Material/Style/Room filter chips on `/shop`, four new admin taxonomy CRUD screens
  (Materials/Styles/Rooms/Artisans), and a new product-form section for all of it.
  - Files changed: `frontend/types/index.ts`, `frontend/services/api.service.ts`,
    `frontend/components/product/ProductDetailClient.tsx`, `frontend/app/(store)/shop/page.tsx`,
    `frontend/app/(admin)/admin/{materials,styles,rooms,artisans}/page.tsx` (new),
    `frontend/components/admin/AdminLayoutClient.tsx`,
    `frontend/app/(admin)/admin/products/{add,[id]}/page.tsx`. Commit `969ab39`.
  - DB/API changes: none new — consumes the backend contract from the previous entry.
  - Testing status: `tsc --noEmit` + `npm run build` clean. Verified with real data via the API
    (assigned a full set of attributes to a demo product, confirmed via headless-Chrome DOM dump
    that the product page renders all of it, and that a product with nothing set still renders
    cleanly). Independently re-verified after the fact: real commit confirmed, DB queried directly
    and found back at its clean pre-test state.
  - Deployment notes: local dev only.
- **Full end-to-end application verification** — the user asked directly for the whole app working,
  not each piece checked separately. Built real browser automation (Chrome DevTools Protocol via
  `chrome-remote-interface`, in a throwaway scratchpad project — no new dependency in either repo)
  and drove the actual storefront: homepage → shop → product detail → clicked "Add to Bag" → cart
  → checkout → filled the real address form → clicked "Place Order" → **a real order was created in
  the database** with correct pricing/shipping/total, stock and `InventoryLog` updated correctly →
  cancelled it through the real API, confirmed stock restored → all test data cleaned up.
  - Files changed: none in the app repos from this pass itself (found two false alarms — a stale
    orphaned dev-server process, and a Chrome-autofill testing artifact misread as a hydration bug
    — both correctly ruled out, not fixed because they weren't real). Fixed a data-integrity drift
    in the dev DB left over from an early-session verification pass done before the stock-restoration
    fix existed (direct SQL correction, not an app code change). See
    `docs/decisions/0013-full-end-to-end-verification.md`.
  - Result: the application works end to end — browsing, cart, checkout, order creation, pricing
    integrity, stock management, cancellation — for everything except completing real payment. That
    step correctly fails because Razorpay/Cashfree credentials are still placeholders (flagged since
    `0002`), not because of a code defect. This is now the one concrete, identified blocker to a
    fully completable purchase, promoted to a distinct open question in `tasks/TASKS.md`.
  - Testing status: this entry *is* the testing — the most rigorous verification pass of the
    session, real user-driven interaction rather than API/SSR-level checks.
  - Deployment notes: local dev only. Needs real payment gateway credentials from the user before
    a purchase can actually complete anywhere.
- Ops: all 3 repos pushed to GitHub for the first time (5 remotes total — `backend`/`frontend`
  each have `origin` = `ud-*` plus a `woodvintage` remote = `wood-vintage-*`). New dedicated SSH
  identity `github-skm` → `shilpamaheshwari1210-cmd` account. Per-repo git author set to
  `Shilpa Maheshwari` going forward (history through this point stays as the machine's global
  `Alexander The Great` identity — not rewritten, by user choice). `unique-dressup` untouched.
  See `docs/decisions/0014-remote-hosting-configured-and-pushed.md`.

## 2026-09-13

- Real URLs for the 5 named Indian competitors (MASTER-PROMPT §32) — found via search, not
  guessed. Real finding: Sunrise International, The Timber Guy, and Sunrise Art & Exports are the
  same company, not three separate competitors. `docs/competitor-research/indian-competitors-directory.md`.
- **Phase 3 (Internationalization) completed in full.**
  - Backend: `CountryShippingRule` (per country+method, additive highest-priority step ahead of the
    existing flat-rate/override chain — zero risk to unconfigured countries). Commit `31d3aa0`.
    See `docs/decisions/0015-country-shipping-rules.md`.
  - Frontend: Countries admin screen + shipping-rules UI. Commit `394adb8`. Found a real gap: no
    write endpoints existed for per-product country pricing/availability. See
    `docs/decisions/0016-country-admin-ui.md`.
  - Backend: closed that gap — `PUT`/`DELETE /products/:id/country-pricing|country-availability/:countryId`.
    Commit `03e63b4`. Real round-trip verified. See `docs/decisions/0017-...`.
  - Frontend: **the `/[country]/...` URL restructuring** — the highest-blast-radius change in the
    project. All 34 storefront routes moved, the pre-existing SEO-redirect middleware (wishlist,
    renamed-category-slug) preserved and correctly composed with new country-prefix logic,
    14+ internal-link sites fixed, hreflang/canonical/sitemap/robots updated. Commits `c8cc8c1`,
    `c148290`, `a866124`, `44eb691`. Verified more thoroughly than anything else this session,
    including independently reproducing the trickiest redirect chain from scratch. See
    `docs/decisions/0018-url-restructuring-implemented.md`.
  - Files changed: extensive — see the individual decision records for full file lists per piece.
  - DB changes: new `country_shipping_rules` table; `country_shipping_rules`/
    `product_country_pricing`/`product_country_availability` all confirmed empty (no default data)
    after all testing.
  - API changes: new `/countries/:id/shipping-rules*` and `/products/:id/country-pricing|
    country-availability/:countryId` endpoints; every storefront URL now lives under
    `/<country-code>/...` (e.g. `/in/product/x`) instead of flat paths — old flat paths 307-redirect
    to the resolved country's equivalent.
  - Testing status: each piece independently re-verified beyond the implementing agent's own
    report — real DB queries, real re-run redirect chains, a genuine order placed and cancelled
    through the real UI post-restructuring. Found and logged (not fixed, out of scope) a real
    pre-existing bug: `GET /orders/my` throws a Prisma error.
  - Deployment notes: local dev only. Pushed to all relevant GitHub remotes.
- **Fixed the `GET /orders/my` pagination bug** found above. `getUserOrders`/`getAllOrders`
  discarded `paginationParams()`'s sanitized `limit`, passing the raw (possibly `NaN`) value to
  Prisma's `take`. Commit `68db808`. See `docs/decisions/0019-fix-orders-pagination-bug.md`.
  - Files changed: `backend/src/modules/orders/services/order.service.ts`.
  - DB changes: none.
  - API changes: none (bug fix only — same contract, now actually works with no query params).
  - Testing status: `tsc --noEmit` clean; booted the backend and called `GET /orders/my` (no
    params, and with `page`/`limit`) and the admin `GET /orders` with a real JWT — all `200`.
  - Deployment notes: local dev only. Pushed to `origin` and `woodvintage`.
