# Task Tracker

Single source of truth for outstanding and completed work. Update this in place — check items off
(`[x]`) rather than deleting them, so the history of what was done stays visible. Add new tasks as
they come up rather than leaving them only in chat. Cross-reference `daily-log/` entries by date
and `docs/decisions/` records where a task involved a real decision.

Phases below follow `MASTER-PROMPT.md` §47.

## Open questions for the user

Items 1-3 don't block current engineering work. Item 4 is different — it's the one concrete thing
blocking a real customer from completing a purchase.

1. **Does `wood-vintage` eventually replace `unique-dressup` in production** (migrating real
   customers/orders), or launch as a genuinely separate platform/customer base? Changes whether
   MASTER-PROMPT §45/§46 apply. Flagged in the Phase 0 discovery report.
2. **Full UI/content translation into German/French/Dutch (and any other non-English target
   market) — yes or defer?** Phase 1 ships locale-aware number/currency/date formatting for all 8
   markets regardless; this question is specifically about translating actual storefront copy.
   See `docs/countries/launch-markets-reference.md` "Localization scope."
3. **Payment provider(s) for non-India markets** — Razorpay/Cashfree don't meaningfully cover
   UAE/USA/Australia/UK/EU (discovery report §8/§16). Needs a real vendor decision before Phase 3
   country-pricing work can be paired with a working checkout in those markets.
4. **This IS blocking, unlike 1-3**: real Razorpay/Cashfree sandbox credentials for the *existing*
   India market. Confirmed by the full end-to-end walkthrough (`0013`, 2026-09-10) — every step up
   to payment works from a real browser click-through; the payment step itself 500s on placeholder
   keys. Whenever this is answered, drop the real values into `backend/.env`
   (`RAZORPAY_KEY_ID`/`_SECRET`, `CASHFREE_APP_ID`/`_SECRET_KEY`) and
   `frontend/.env.local` (`NEXT_PUBLIC_RAZORPAY_KEY`).

## Phase 0 — Discovery

- [x] Locate and confirm existing `unique-dressup/backend` and `/frontend` repos and their remotes (2026-09-09)
- [x] Set up `wood-vintage/{backend,frontend,documentation}` as fresh repos, seeded from
      `unique-dressup` via file copy, no shared git history/remotes (2026-09-09)
- [x] Initiate `documentation` repo structure (2026-09-09)
- [x] Spot-verify `../backend/CLAUDE.md` against the actual copied code (not a full re-audit —
      see "Verification method" in the discovery report) (2026-09-09)
- [x] Produce the Phase 0 discovery deliverables from MASTER-PROMPT §47 — architecture map,
      dependency map, database map, API map, reusable modules inventory, migration risks — folded
      into the discovery report below rather than as separate documents (2026-09-09)
- [x] Write the PROJECT DISCOVERY REPORT (MASTER-PROMPT §50, 25 sections):
      `docs/architecture/phase-0-discovery-report.md` (2026-09-09)
- [ ] **Open question flagged in the report, not resolved:** is `wood-vintage` meant to eventually
      replace `unique-dressup` in production (migrating real customers/orders), or launch as a
      genuinely separate platform/customer base? Changes whether MASTER-PROMPT §45/§46 (data
      migration, legacy compatibility) apply. Ask the user before Phase 3+ makes assumptions either way.

## Phase 1 — Foundation

- [x] Adopt Prisma migration history (replace `db push`) — baseline `20260909115445_init`
      (2026-09-09). See `docs/decisions/0003-phase-1-foundation-prerequisites.md`.
- [x] Fix server-authoritative order pricing — `effectivePrice()` in `order.service.ts`, confirmed
      exploitable before the fix and re-tested after (2026-09-09). Same decision record.
- [x] Stock-not-restored-on-cancel (`CLAUDE.md` §25 #3, 🔴 critical) — fixed and independently
      re-verified (2026-09-09, `wood-vintage/backend` commit `bf811c8`). `InventoryLog` also wired
      up (was written nowhere before). See `docs/decisions/0008-...`.
- [x] CMS routing bug fixed (`/cms` → `/seo/cms`, `CLAUDE.md` §25 #7) — verified live, `GET /about`
      now returns 200 (2026-09-09, `wood-vintage/frontend` commit `3f4763c`).
- [x] Shipping-display gap for products with a per-product override — **fixed** (2026-09-10,
      `wood-vintage/frontend` commit `76c55e4`), build/type-check verified but **not** live/browser
      verified (client component, `claude-in-chrome` can't reach this sandbox) — see
      `docs/claude/technical-debt.md`.
- [x] Country architecture — **backend implemented and verified** (2026-09-09,
      `wood-vintage/backend` commit `21efdff`): `Country`/`ProductCountryPricing`/
      `ProductCountryAvailability` models, 8 launch markets seeded (India enabled+default),
      pricing/availability resolution wired into `GET /products*` and order creation. See
      `docs/decisions/0009-country-architecture-implemented.md`.
- [x] Country architecture, frontend piece — **implemented and independently verified**
      (2026-09-09, `wood-vintage/frontend` commit `6536c70`): `CountryContext`, `wv_country`
      cookie, `CountrySelector`, `?country=` threaded through the real storefront pricing surface.
      Live-verified with a real pricing override (₹399/599 base → ₹1,299/1,499 AE override, both
      confirmed via SSR HTML). See `docs/decisions/0010-...`.
- [x] Currency architecture — covered by the same spec (`currency`/`currencySymbol` on `Country`).
      Reference data for the 8 launch markets: `docs/countries/launch-markets-reference.md` (2026-09-09).
- [~] Localization architecture — **scoped, not fully decided**: locale-aware formatting for all 8
      markets is decided (Phase 1); full UI/content translation into German/French/Dutch is an
      **open question for the user**, not decided here — see `docs/countries/launch-markets-reference.md`
      "Localization scope."
- [x] CMS foundation (content inheritance: Global → Country → Language, §30) — data model
      (`21efdff`) and **resolution logic now implemented and verified** (2026-09-09,
      `wood-vintage/backend` commit `9c7d0ad`): `resolveCmsPage`/`resolveHomepageSections`/
      `resolveBanners`. Also fixed a real schema gap found along the way — `CmsPage.slug` was
      still globally unique, blocking country overrides from existing. See `docs/decisions/0010-...`.
- [ ] **New**: admin UI for creating country-scoped `HomepageSection`/`Banner`/`CmsPage` rows (the
      resolution logic exists and works; an admin can currently only create country-scoped content
      via direct API calls, not through a UI screen). Not urgent until real country-specific
      content is actually being authored.
- [x] Product architecture updates for handicraft domain — **backend done**, see Phase 2 below.
- [x] Media/CDN architecture — **decided**: reuse existing pipeline as-is, defer CDN fronting to
      Phase 5/8 (`docs/decisions/0005-media-cdn-architecture.md`, 2026-09-09). No code changes needed now.
- [x] SEO foundation — **decided**: existing infra (SeoMeta, sitemap, JSON-LD, robots.ts) is
      adequate; no new Phase 1 work beyond the pre-existing CMS-routing bug fix
      (`docs/decisions/0006-seo-foundation-scope.md`, 2026-09-09). Real SEO buildout is Phase 6.

## Phase 2 — Handicraft Domain

- [x] Materials, styles, room taxonomy (§16) — **backend implemented and verified** (2026-09-10,
      `wood-vintage/backend` commit `59964a4`): `Material`/`Style`/`Room` models (11/11/8 seeded,
      admin-CRUDable with no code change to add a value), `Product` filters
      (`?materialSlug=&styleSlug=&roomSlug=`). See `docs/decisions/0012-...`.
- [x] Product attributes (admin-configurable, no code changes to add new ones) — same commit,
      same models.
- [x] Customization / made-to-order support — `isCustomizable`/`customizationNotes`/
      `manufacturingTimeDays` fields on `Product`, same commit.
- [x] Furniture-specific product detail fields (dimensions, weight, finish, assembly, manufacturing
      time) — `lengthCm`/`widthCm`/`heightCm`/`finish`/`assemblyRequired`/`assemblyInstructions`,
      same commit. `weight` already existed pre-Phase-2.
- [x] Artisan/craft storytelling content model (§33) — `Artisan` model (unseeded — no real data
      yet, correctly left empty) + `craftStory` field on `Product`, same commit.
- [ ] **New**: Phase 2 frontend — material/style/room display + filters on the storefront, artisan
      bio rendering, craft story on product pages, admin UI for the new taxonomy screens (Materials/
      Styles/Rooms/Artisans admin CRUD screens, product edit form's new "Craft & Dimensions"
      section). Backend contract exists and is verified; this is the natural next piece, same
      pattern as the Country architecture's frontend follow-up (`0010`).

## Phase 3 — Internationalization

- [x] Country configuration (admin-manageable, §10) — backend (`0009`) + admin UI, done and
      verified (`0016`, `wood-vintage/frontend` commit `394adb8`). Found a real gap along the way:
      no write endpoints for `ProductCountryPricing`/`ProductCountryAvailability` — tracked as a
      new backend task below.
- [x] `PUT`/`DELETE` endpoints for `ProductCountryPricing`/`ProductCountryAvailability` — done and
      verified (`0017`, `wood-vintage/backend` commit `03e63b4`). Nested under products, matching
      the variant-routes pattern. Real round-trip verified (set → resolution picks it up
      immediately, no other code changed → delete → clean 404 → fallback confirmed).
- [ ] **New**: product-form "Country Pricing & Availability" UI section (deferred in `0016`, now
      unblocked by `0017`'s API existing) — next frontend piece once the URL restructuring lands.
- [x] Country pricing rules (§17) — `ProductCountryPricing`, done and verified (`0009`, `0013`).
- [x] Country content overrides — Global→Country CMS/homepage/banner resolution, done and verified
      (`0010`).
- [x] Country availability — `ProductCountryAvailability`, done (`0009`).
- [x] Country shipping rules (§18) — `CountryShippingRule`, done and verified (`0015`).
- [x] Implement country SEO / hreflang / URL strategy — **done and thoroughly verified**
      (2026-09-13, `wood-vintage/frontend` commits `c8cc8c1`/`c148290`/`a866124`/`44eb691`). All 34
      storefront routes moved under `app/[country]/...`, existing legacy redirects (wishlist,
      renamed-category-slug) preserved and composed with the new country-prefix middleware, 14+
      internal-link sites fixed, hreflang/canonical added, sitemap/robots updated. Independently
      re-verified beyond the agent's own report — reproduced the category-slug-rename redirect
      chain from scratch. See `docs/decisions/0018-url-restructuring-implemented.md`.
      **Phase 3 is now fully done.**
- [x] `GET /orders/my` Prisma validation error — **fixed 2026-09-13**. Root cause: `getUserOrders`/
      `getAllOrders` destructured only `{ skip }` from `paginationParams()` and used the raw,
      unsanitized `limit` (NaN with no query string) in Prisma's `take`. See
      `docs/decisions/0019-fix-orders-pagination-bug.md`.
- [ ] **New**: blog detail page's metadata has no hreflang (the URL-restructuring spec's list
      didn't name it) — minor, low-priority follow-up if/when blog SEO matters.

## Phase 4 — Experience (started 2026-09-13)

Audit done (all 9 sub-items assessed against real code — see `0020` and
`docs/architecture/phase-4-experience-spec.md`). User confirmed: replace the gender axis with
Room/Material/Style rather than keep it alongside the new taxonomy.

- [x] Backend: real frequently-bought-together recommendations, public artisan directory endpoint,
      3 new taxonomy-driven `HomepageSectionType` values. See `docs/decisions/0020-...`.
- [x] Frontend: gender-axis replacement (hide toggle + fix the silent-WOMEN-default risk — see spec
      §1, this is the highest-risk single item), new homepage sections (§2), artisan directory pages
      (§4), search facets (§6), recently-viewed server sync for signed-in users (§7). Full detail in
      `docs/architecture/phase-4-experience-spec.md`. Implemented 2026-09-13 as 5 separate commits in
      `wood-vintage/frontend` (plus one small `gender_toggle_enabled` seed-default commit in
      `wood-vintage/backend`) — **independently re-verified and pushed** to all 4 remotes. Real
      `curl` check confirmed the silent-narrowing risk is closed (no-`gender`-param request returns
      the full catalogue, not just WOMEN). See `docs/decisions/0021-...`. **Phase 4 is now
      substantially done** — remaining items below are deliberately out of scope, not gaps.
- [ ] **New** (found by the audit, deliberately out of scope for the above): Size/Color filter chips
      on `/shop` are unconditional even for furniture products that don't have meaningful
      size/color variants — should be conditional or relabeled (e.g. dimension/finish).
- [ ] **New** (deliberately deferred, spec §7): merging guest (localStorage) and signed-in
      (server) recently-viewed history on login — not required for Phase 4, worth doing later.
- [ ] Personalization beyond recommendations + recently-viewed (real affinity scoring, ML-driven
      "for you" sections) is intentionally deferred to Phase 8 (Scale) per MASTER-PROMPT §47, which
      explicitly owns "recommendation engine" and "AI-assisted merchandising" — not a Phase 4 gap.

## Phase 4 — Experience

**Superseded by the detailed section above (started 2026-09-13) — all items below done there.**
- [x] New homepage structure — taxonomy-driven sections (`0020`/`0021`), not analytics-validated
      (no analytics platform exists yet — see Phase 7) but genuinely rebuilt around Room/Material/
      Style rather than the old gender toggle.
- [x] Category discovery / filters — Material/Style/Room filters + new homepage discovery sections.
- [x] Product storytelling template — artisan bio card + directory (`0021`).
- [x] Recommendations (rule-based) — real order-co-occurrence "frequently bought together" (`0020`).
- [x] Search — facets matching `/shop` (`0021`); typo tolerance/synonyms/Elasticsearch-class infra
      not built (would be a real infra decision, not code-only — not attempted).
- [x] Wishlist / recently viewed / personalization — wishlist was already done; recently-viewed now
      server-synced for signed-in users (`0021`); personalization scoped to recommendations +
      recently-viewed, deeper ML-driven personalization deferred to Phase 8 per MASTER-PROMPT §47.

## Phase 5 — Performance

- [x] Images — already done pre-Phase-5 (see `backend/CLAUDE.md` §19); audit confirmed it genuinely
      satisfies this sub-item, nothing left to build.
- [x] Caching — HTTP cache headers + Next ISR audited and confirmed correct/broad; in-process/Redis
      caching for hot read endpoints deliberately NOT built (PM2 multi-worker limits an in-process
      cache's value; Redis is an infra decision) — tracked in `docs/claude/technical-debt.md`.
- [x] SSR/SSG usage audit — done, `backend/CLAUDE.md` §16's table found stale post-`[country]`
      restructuring; real split documented in `0022`. True SSG (`generateStaticParams`) not used
      anywhere — ISR-with-revalidate judged a reasonable choice at current catalogue size, not a gap.
- [x] API and DB performance pass — no N+1 found; fixed a real missing `[isActive,isBestSeller]`
      index and trimmed over-fetched material/style/room/artisan/badges from product-list responses.
      See `0022`.
- [x] Bundle size audit — `@next/bundle-analyzer` wired in (`npm run build:analyze`); confirmed
      `@mui/x-data-grid` is an unused dependency (not removed, flagged only).
- [x] Core Web Vitals baseline + targets — real reporting now exists (`0022`); no CI/target-gating
      yet since there's no CI/CD pipeline at all (separate, already-known gap, `backend/CLAUDE.md` §24).
- [ ] **New**: CDN fronting for `/img`/`/uploads` — needs a provider choice + DNS change, not code.
      Deliberately deferred since `0005` (2026-09-09); still the right call.

## Phase 6 — SEO

Spec written (`docs/architecture/phase-6-seo-spec.md`) after a real audit found several already-
indexed pages silently shipping fashion-era fallback metadata. Implementation in progress.

- [ ] Technical SEO — fashion-era fallback metadata on `/shop`, `/search`, `/categories`,
      `/collections`, `/contact` (real, already-indexed pages) needs fixing; sitemap needs
      collections/artisans/material/room/style added.
- [ ] Content SEO — blog detail's fallback title still says "Unique Dressup Blog"; no
      editorial/target-keyword tooling (deliberately not building ahead of a real content program).
- [ ] International SEO — core mechanism (`buildCountryAlternates()`) already solid and correctly
      used on most page types; blog detail has no `alternates` at all (worse than `0018` flagged —
      missing canonical too, not just hreflang), same 5 pages above also missing it.
- [ ] Programmatic SEO pages — Material/Room/Style landing pages: **the data model, product
      relations, and admin CRUD already exist**; only the frontend route is missing. Highest-leverage
      item in this phase.
- [ ] Structured data — only `Product` JSON-LD exists (with a real bug: hardcoded
      `priceCurrency: 'INR'`, wrong for non-India country pages); no `BreadcrumbList`/
      `Organization`/`WebSite`/`Article` anywhere despite the UI/data already existing for most.
- [ ] Landing page architecture — same as "Programmatic SEO pages" above.
- [ ] **New**: Footer links don't call `withCountry()` — every sitewide footer link forces a 307
      redirect hop instead of linking to the canonical URL. The one place `0018`'s sweep missed.

## Phase 7 — Analytics (started 2026-09-17)

Spec written (`docs/architecture/phase-7-analytics-spec.md`) after scoping which sub-items are
code-doable without a third-party analytics vendor decision (GA4/Segment/PostHog/etc — deliberately
not integrated, see the spec). Backend done and verified; frontend instrumentation in progress.

- [x] Event tracking schema — in-house `AnalyticsEvent` model + `POST /metrics/event`, deliberately
      minimal (typed columns, no JSON blob). See `docs/decisions/0025-...`.
- [x] Funnel tracking (backend) — `GET /analytics/funnel`, distinct-session counts + conversion
      rates. Verified live against a real simulated 2-session funnel, exact numbers matched.
- [x] Country-level dashboards — `Order.countryId` (was missing entirely — only a free-text name in
      a JSON snapshot before this) + `GET /analytics/country-breakdown`. See `docs/decisions/0024-...`.
- [x] Product analytics — already existed (`topProducts` in the admin dashboard, via `totalSold`);
      confirmed adequate, no new work needed.
- [x] Marketing attribution (backend) — `Order.utmSource`/`utmMedium`/`utmCampaign` columns +
      `createOrder` wiring. See `docs/decisions/0025-...`.
- [ ] Frontend: event firing at the 5 funnel touch-points (page view, product view, add-to-cart,
      checkout started, order placed) + first-touch UTM capture — delegated, verification pending.
- [ ] **New**: no admin UI screen renders the funnel/country-breakdown data yet — both endpoints are
      real and correct; a dashboard chart is a natural, low-risk follow-up, not blocking.

## Phase 8 — Scale

- [ ] High-traffic readiness — mostly Phase 5 overlap (CDN, shared caching); both already
      identified as infrastructure decisions, not code (see `0022`), not revisited here.
- [ ] Large product/image volume handling — image pipeline already handles this (Phase 5 audit
      confirmed); indexes/pagination already solid.
- [x] Multi-warehouse support — **asked the user directly (2026-09-17)**: skip for now, current
      single-warehouse architecture stays as-is. Revisit only with a real second warehouse to
      support — building this speculatively risks guessing wrong about how inventory should split.
- [ ] Multiple payment/shipping providers — same open question as item 3 in "Open questions for the
      user" above; needs a real vendor decision, not resolved by this pass.
- [ ] Recommendation engine → ML-ready architecture — the real co-purchase engine built in Phase 4
      (`0020`) is a reasonable foundation; a full ML build-out would be premature with the current
      (test-only) order volume. Not attempted — would violate "don't design for hypothetical future
      requirements."

## Backlog / ad-hoc

- [x] `npm install` in `wood-vintage/backend` and `wood-vintage/frontend` (2026-09-09)
- [x] Recreate `.env` (backend) and `.env.local` (frontend) from their `.example` files (2026-09-09)
      — see `docs/decisions/0002-local-dev-environment-setup.md`. Real third-party keys
      (Razorpay/Cashfree/Google/Brevo/SMTP) are still placeholders.
- [x] Create local dev MySQL DB `wood_vintage`, run `prisma db push`, verify backend boots and seeds
      (2026-09-09)
- [x] Fix hardcoded frontend `API_URL` (was ignoring `NEXT_PUBLIC_API_URL`) + remove stray
      `console.log` — `wood-vintage/frontend` commit `97e502d` (2026-09-09)
- [x] Verify full stack end-to-end locally: backend :5000 + frontend :3030 talking to each other
      (2026-09-09)
- [ ] **Confirmed by the full E2E walkthrough (`0013`) as THE remaining blocker to a completable
      checkout**: real Razorpay and/or Cashfree credentials. Everything up to and including order
      creation, pricing, stock, and cancellation genuinely works (real browser, real clicks, real
      order in the DB) — the payment step 500s because `CASHFREE_APP_ID`/`CASHFREE_SECRET_KEY` (and
      Razorpay's equivalents) are still placeholders. This codebase's COD flow also requires a
      Cashfree-collected delivery deposit, so COD isn't a workaround either. **Needs real
      sandbox/live credentials from the user** — cannot be fabricated.
- [ ] Google OAuth, Brevo/SMTP keys — lower priority than payment (login/email work without them,
      just without those specific features), fill in when needed (`backend/.env` / `frontend/.env.local`).
- [x] Remote hosting configured and pushed — **done** (2026-09-10). New SSH identity `github-skm`
      → `shilpamaheshwari1210-cmd` GitHub account. `documentation` → `wood-vintage-documentation`;
      `backend` → `ud-server` (origin) + `wood-vintage-server` (`woodvintage` remote); `frontend` →
      `ud-client` (origin) + `wood-vintage-client` (`woodvintage` remote). See `docs/decisions/0014-...`.
      **Remember**: `git push` alone only updates `origin` (the `ud-*` repos) — push
      `woodvintage` explicitly too after commits in `backend`/`frontend` if both should stay in sync.
- [x] Commit author identity fixed — set `user.name`/`user.email` to
      `Shilpa Maheshwari <shilpamaheshwari1210-cmd@users.noreply.github.com>` **locally in each of
      the 3 repos** (not global — the machine's global identity is presumably intentional for other
      projects). Applies going forward only; history through this point stays authored as
      `Alexander The Great` (the pre-existing global identity), by the user's explicit choice not
      to rewrite/force-push. See `docs/decisions/0014-...`.
- [x] **Frontend security:** all 9 vulnerabilities fixed, `npm audit` now clean (2026-09-09,
      `wood-vintage/frontend` commit `d1ec1a0`). See `docs/decisions/0007-...`. Carousel hydration
      verification gap **closed** 2026-09-10 via local headless Chrome — see `docs/decisions/0012-...`.
- [x] **Backend security:** 17 → 2 vulnerabilities (both moderate, confirmed unreachable, left
      deliberately) — see `docs/claude/technical-debt.md` and `docs/decisions/0008-...` (2026-09-09,
      `wood-vintage/backend` commit `044b79d`).
- [ ] Rebrand seeded content (site name, categories, product copy currently still say "Unique
      Dressup"/fashion — cosmetic only, real work is Phase 2 Handicraft Domain)
- [x] Real-browser smoke test of `HeroSlider`/`TestimonialsSection` carousel interactivity
      post-Swiper-upgrade — **done 2026-09-10** via local headless Chrome (`google-chrome
      --headless=new --dump-dom`, not `claude-in-chrome` — see `skills/SKILLS.md`). Found
      `swiper-initialized`/`swiper-slide-active`/`swiper-pagination-bullet-active` in the post-JS
      DOM, proving real hydration, not just correct SSR markup. See `docs/decisions/0012-...`.
- [ ] **New**: full checkout shipping-display verification (`0011`) — headless Chrome confirmed
      `/checkout` renders without a JS crash on an empty cart, but the actual override calculation
      with a populated cart + overridden product still needs either real UI interaction or CDP
      scripting to seed cart state before navigating. Narrower gap than before, not fully closed.
- [x] Identify real URLs for the 5 Indian competitors named in MASTER-PROMPT §32 (2026-09-11) —
      `docs/competitor-research/indian-competitors-directory.md`. Found Sunrise International/The
      Timber Guy/Sunrise Art & Exports are the same company, not 3 separate competitors.
- [ ] **New**: the full §32 teardown (positioning, homepage, nav, pricing, SEO, trust, etc.) for
      each — this pass was identification only. Also: USA/UAE/Australia/Europe competitor research,
      not started at all.
- [x] **Phase 6 SEO spec implemented** (2026-09-17, `docs/architecture/phase-6-seo-spec.md`, 5
      commits in `wood-vintage/frontend`): fashion-era root/page metadata fallback rewritten for the
      furniture vertical (5 pages that had none — shop/search/categories/collections-index/contact —
      each got a sibling Server Component `layout.tsx`, since those pages are Client Components and
      can't export `generateMetadata` themselves); Footer's internal links now go through
      `withCountry()`; blog detail got `buildCountryAlternates()`, a real site-name fallback, a
      country-prefixed `openGraph.url`, and `Article` JSON-LD; product page's `priceCurrency`
      hardcoded `'INR'` and `brand.name` fallback `'LUXÉ'` fixed; sitewide `Organization`+`WebSite`
      JSON-LD added to the root layout; `BreadcrumbList` JSON-LD added to
      product/category/collection/artisans pages; new `/material/[slug]`, `/room/[slug]`,
      `/style/[slug]` landing pages (following `category/[slug]`'s pattern) plus sitemap additions
      for those three, collections, and artisans (all previously omitted). Verified against a real
      booted backend+frontend, not just code review.
- [ ] **New** (Phase 6 follow-up, deliberately out of scope per the spec's non-goals):
      `LocalBusiness` schema for the `Store` model — needs a lat/lng field added to `Store`
      (`backend/prisma/schema.prisma`) first, i.e. a real migration, before real (non-fake)
      `LocalBusiness` JSON-LD can be emitted.
- [ ] **New** (Phase 6 follow-up, out of scope per the spec's non-goals): editorial/content-strategy
      tooling (`targetKeyword` fields, content briefs) for the blog/CMS — useful once there's an
      actual content program, not worth building ahead of one.
- [ ] **Confirmed still open** (Phase 6 audit, 2026-09-17): the DB's `settings.site_name`/
      `site_description` still return "Unique Dressup" / "Trendy & affordable fashion for every
      occasion. Explore kurtas, co-ords, dresses, and more." from `GET /settings/public` — this is
      what Footer's own fallback copy references. Same root cause as the already-tracked "Rebrand
      seeded content" item above (categories/products), not new — but now confirmed live against the
      running DB rather than only suspected from code. Also noticed while verifying: seeded catalog
      still has fashion-only products/categories (e.g. `statement-canvas-tote`), and no
      Material/Room/Style FK is set on any seeded product, so the new `/material/[slug]`,
      `/room/[slug]`, `/style/[slug]` pages render correctly but empty until the catalog gets real
      handicraft taxonomy data.
