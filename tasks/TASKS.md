# Task Tracker

Single source of truth for outstanding and completed work. Update this in place — check items off
(`[x]`) rather than deleting them, so the history of what was done stays visible. Add new tasks as
they come up rather than leaving them only in chat. Cross-reference `daily-log/` entries by date
and `docs/decisions/` records where a task involved a real decision.

Phases below follow `MASTER-PROMPT.md` §47.

## Open questions for the user (not blocking current work, but need real answers eventually)

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
- [~] Stock-not-restored-on-cancel (`CLAUDE.md` §25 #3, 🔴 critical) — in progress, delegated to a
      background agent working directly in `wood-vintage/backend` (started 2026-09-09, also
      covering the npm vulnerability triage below). Not yet confirmed complete.
- [ ] Shipping-display gap for products with a per-product override (lower severity, found while
      fixing pricing above) — see `docs/claude/technical-debt.md`.
- [x] Country architecture — **spec written**, not implemented: `docs/architecture/country-architecture-spec.md`
      (2026-09-09). Implementation queued until the backend repo is free of the in-flight agent work above.
- [x] Currency architecture — covered by the same spec (`currency`/`currencySymbol` on `Country`).
      Reference data for the 8 launch markets: `docs/countries/launch-markets-reference.md` (2026-09-09).
- [~] Localization architecture — **scoped, not fully decided**: locale-aware formatting for all 8
      markets is decided (Phase 1); full UI/content translation into German/French/Dutch is an
      **open question for the user**, not decided here — see `docs/countries/launch-markets-reference.md`
      "Localization scope."
- [ ] CMS foundation (content inheritance: Global → Country → Language, §30) — data model covered
      by the country architecture spec (nullable `countryId` on `HomepageSection`/`Banner`/`CmsPage`);
      admin UI and resolution logic not yet implemented.
- [ ] Product architecture updates for handicraft domain
- [ ] Media/CDN architecture (§19)
- [ ] SEO foundation

## Phase 2 — Handicraft Domain

- [ ] Categories, materials, styles, room taxonomy (§16)
- [ ] Product attributes (admin-configurable, no code changes to add new ones)
- [ ] Customization / made-to-order support
- [ ] Furniture-specific product detail fields (dimensions, weight, finish, assembly, manufacturing time)
- [ ] Artisan/craft storytelling content model (§33)

## Phase 3 — Internationalization

- [ ] Country configuration (admin-manageable, §10)
- [ ] Country pricing rules (§17)
- [ ] Country content overrides
- [ ] Country availability
- [ ] Country shipping rules (§18)
- [ ] Implement country SEO / hreflang / URL strategy — **decided** (`docs/decisions/0004-international-url-strategy.md`:
      subdirectory-per-country, `app/[country]/...`), not yet implemented. Real restructuring of the
      route tree, scope as its own task, not a side effect of something else.

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
- [ ] Fill in real third-party keys as each feature is needed: Razorpay, Google OAuth, Brevo/SMTP
      (none currently set — see `backend/.env` / `frontend/.env.local`)
- [ ] Decide remote host/naming for all three `wood-vintage` repos and push them
- [ ] **Frontend security:** fix 2 critical (`next` RCE, `swiper` prototype pollution) + 7 high npm
      vulnerabilities — see `docs/claude/technical-debt.md`. Needs testing, not a blind
      `npm audit fix --force` (major/breaking bumps).
- [ ] **Backend security:** triage 17 npm vulnerabilities (2 low, 8 moderate, 7 high) — see
      `docs/claude/technical-debt.md`.
- [ ] Rebrand seeded content (site name, categories, product copy currently still say "Unique
      Dressup"/fashion — cosmetic only, real work is Phase 2 Handicraft Domain)
