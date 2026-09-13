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
- [ ] **New**: `POST/PUT/DELETE` endpoints for `ProductCountryPricing`/`ProductCountryAvailability`
      (found by `0016` — only read-side resolution exists today, no way to set an override except
      direct SQL). Needed before the product-form "Country Pricing & Availability" section
      (deferred in `0016`) can be built.
- [x] Country pricing rules (§17) — `ProductCountryPricing`, done and verified (`0009`, `0013`).
- [x] Country content overrides — Global→Country CMS/homepage/banner resolution, done and verified
      (`0010`).
- [x] Country availability — `ProductCountryAvailability`, done (`0009`).
- [x] Country shipping rules (§18) — `CountryShippingRule`, done and verified (`0015`).
- [ ] Implement country SEO / hreflang / URL strategy — **decided** (`docs/decisions/0004-international-url-strategy.md`:
      subdirectory-per-country, `app/[country]/...`). User confirmed to proceed (2026-09-13). Own
      spec written (`phase-3-url-restructuring-spec.md`); implementation starting once the frontend
      repo is free of the concurrent Countries-admin-UI agent.

## Phase 4 — Experience

- [ ] New homepage structure (§12, validate sections against analytics — don't implement blindly)
- [ ] Category discovery / filters
- [ ] Product storytelling template (§33)
- [ ] Recommendations (rule-based first, §24)
- [ ] Search (typo tolerance, synonyms; future-ready for Elasticsearch/Algolia-style infra, §23)
- [ ] Wishlist / recently viewed / personalization

## Phase 5 — Performance

- [ ] CDN, image optimization, caching
- [ ] SSR/SSG usage audit
- [ ] API and DB performance pass
- [ ] Bundle size audit
- [ ] Core Web Vitals baseline + targets (§20, §35)

## Phase 6 — SEO

- [ ] Technical SEO (crawlability, sitemap, robots.txt, structured data, canonical URLs)
- [ ] Content SEO (buying guides, material guides, comparisons)
- [ ] International SEO (hreflang, localized URLs, country metadata)
- [ ] Programmatic SEO pages (material/room/style/country/use-case — real value only, §5)
- [ ] Landing page architecture

## Phase 7 — Analytics

- [ ] Event tracking schema (§26)
- [ ] Funnel tracking
- [ ] Country-level dashboards
- [ ] Product analytics
- [ ] Marketing attribution

## Phase 8 — Scale

- [ ] High-traffic readiness
- [ ] Large product/image volume handling
- [ ] Multi-warehouse support
- [ ] Multiple payment/shipping providers
- [ ] Recommendation engine → ML-ready architecture

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
