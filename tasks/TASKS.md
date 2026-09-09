# Task Tracker

Single source of truth for outstanding and completed work. Update this in place — check items off
(`[x]`) rather than deleting them, so the history of what was done stays visible. Add new tasks as
they come up rather than leaving them only in chat. Cross-reference `daily-log/` entries by date
and `docs/decisions/` records where a task involved a real decision.

Phases below follow `MASTER-PROMPT.md` §47.

## Phase 0 — Discovery

- [x] Locate and confirm existing `unique-dressup/backend` and `/frontend` repos and their remotes (2026-09-09)
- [x] Set up `wood-vintage/{backend,frontend,documentation}` as fresh repos, seeded from
      `unique-dressup` via file copy, no shared git history/remotes (2026-09-09)
- [x] Initiate `documentation` repo structure (2026-09-09)
- [ ] Verify `../backend/CLAUDE.md` is current against actual code (it's dated 2026-07-27 /
      backend `7b7531f`, frontend `69b123f` — check drift since)
- [ ] Produce/refresh the Phase 0 discovery deliverables from MASTER-PROMPT §47:
  - [ ] Architecture map
  - [ ] Dependency map
  - [ ] Database map
  - [ ] API map
  - [ ] Reusable modules inventory
  - [ ] Technical debt list → `docs/claude/technical-debt.md`
  - [ ] Migration risks
- [ ] Write the PROJECT DISCOVERY REPORT (MASTER-PROMPT §50, 25 sections) into `docs/architecture/`

## Phase 1 — Foundation

- [ ] Country architecture (config model per MASTER-PROMPT §7)
- [ ] Currency architecture
- [ ] Localization architecture
- [ ] CMS foundation (content inheritance: Global → Country → Language, §30)
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
- [ ] Country SEO / hreflang / URL strategy (§31 — decision needs to be documented before implementing)

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
- [ ] Recreate `.env` (backend) and `.env.local` (frontend) from their `.example` files with real values
- [ ] Decide remote host/naming for all three `wood-vintage` repos and push them
- [ ] **Frontend security:** fix 2 critical (`next` RCE, `swiper` prototype pollution) + 7 high npm
      vulnerabilities — see `docs/claude/technical-debt.md`. Needs testing, not a blind
      `npm audit fix --force` (major/breaking bumps).
- [ ] **Backend security:** triage 17 npm vulnerabilities (2 low, 8 moderate, 7 high) — see
      `docs/claude/technical-debt.md`.
