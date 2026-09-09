# Phase 0 — Project Discovery Report

Per `MASTER-PROMPT.md` §50. Base facts (§1–17) are synthesized from `backend/CLAUDE.md` (the
inherited engineering reference, last full analysis 2026-07-27, backend `7b7531f` / frontend
`69b123f`) and spot-verified against the actual `wood-vintage` copy on 2026-09-09
(backend `ac5dca5`, frontend `97e502d`) by installing, booting, and exercising both apps end to
end. This is **not** a line-by-line re-audit of all ~50K lines — see "Verification method" below
for exactly what was and wasn't re-checked. Sections 18–25 are new analysis/recommendations for the
handicraft/global transformation, not inherited content.

## Verification method (what "spot-verified" means here)

Done on 2026-09-09: `npm install` (both apps, clean), `npm audit` (both), `tsc --noEmit` (frontend,
clean), fresh MySQL DB + `prisma db push` + first-boot seed (backend, succeeded), booted backend
and confirmed `/health` and `/api/v1/settings/public`, booted frontend and confirmed SSR homepage
render pulling from the local backend. Found and fixed one drift issue (hardcoded `API_URL`,
already documented in `CLAUDE.md` §25 #5 — see `docs/decisions/0002-...`). **Not done:** re-reading
every module's source against every claim in `CLAUDE.md`, re-testing the full QA checklist in §23
of that document, or independently re-deriving the "Known Issues" list in §25 — those are taken on
faith from the inherited document, flagged here as inherited-not-reverified.

---

## 1. Current stack

TypeScript throughout. Backend: Node 20, Express 4.18, Prisma 5.22, MySQL 8. Frontend: Next.js 15
(App Router), React 19, MUI 6, Redux Toolkit, React Query 5, Axios, Formik/Yup. PM2 for process
management, Docker multi-stage builds for both apps. No CI/CD configured. No automated tests in
either repo. Full detail: `backend/CLAUDE.md` §3–5.

## 2. Frontend architecture

Next.js App Router with route groups: `(store)` storefront, `(admin)` admin panel (same app, not a
separate deployment), `(account)` customer account, `(auth)` login/register. Server Components do
data fetching directly against the backend; Client Components go through
`services/api.service.ts` → `lib/axios.ts`. State: Redux Toolkit (auth/cart/gender slices) +
React Query (installed, under-used) + MUI theme. Design system: black-and-gold "luxury" fashion
palette (`themes/index.ts`) — **will need a full re-skin for a handicraft/wood brand**, this is not
a config toggle, it's a new theme. Full detail: `backend/CLAUDE.md` §2.2, §16, §21.

## 3. Backend architecture

Layered: routes → controllers (thin) → services (business rules, transactions) → Prisma. 20
feature modules under `src/modules/`. Middleware chain: helmet → CORS → rate-limit(prod) →
body-parser(+rawBody for Cashfree webhook) → cookie-parser → xss-clean → compression → morgan(dev).
Response envelope is mandatory (`sendSuccess`/`sendError`/`sendPaginated`). Full detail:
`backend/CLAUDE.md` §2.1, §4, §17.

## 4. Database architecture

MySQL 8 via Prisma, 34 models / 13 enums, all string UUID PKs. **No migration history** —
schema is applied with `prisma db push`, which can silently drop columns/tables to converge the
schema. This is the single biggest structural risk for the transformation ahead (see §17
Migration risks). Domain groups: users/auth, catalog, inventory, social proof, commerce, content,
platform. Soft delete via `deletedAt` on User/Category/Product/Blog. Money is `Decimal`. Full
detail: `backend/CLAUDE.md` §13.

**Nothing in the current schema represents "country" as a concept anywhere** — no country field on
Product, Order, User, or a Country/Pricing model. This confirms MASTER-PROMPT §7's premise: country
architecture is genuinely new work, not an extension of something that half-exists.

## 5. Authentication

Stateless JWT (access + refresh, distinct secrets), refresh rotation, single active session per
user, Google OAuth. `authenticate` re-reads the user from the DB on every request and authorization
uses `dbRole` (DB-fresh), never the JWT's `role` claim — deliberate and correct (immediate effect on
deactivation/role change). Not yet implemented: actual email delivery for password reset (token is
returned in the API response, not emailed — SMTP config exists, no mailer module). Full detail:
`backend/CLAUDE.md` §14.

## 6. Product system

`Product` → images (with per-colour tagging) → variants (size/colour/material) → tags/badges/FAQs →
related products, plus a full image-derivative pipeline (AVIF/WebP, responsive widths, blur
placeholders, background re-encode queue). This pipeline is generic and reusable as-is for
furniture/handicraft product photography. What's missing for the handicraft domain: materials,
styles, room, dimensions/weight beyond generic fields, assembly info, manufacturing time,
customization, country pricing/availability — none of this exists on `Product` today (MASTER-PROMPT
§15–16). Full detail: `backend/CLAUDE.md` §11.4, §19 (image pipeline), §34.

## 7. Cart/order system

Guest (via `x-session-id` header) + authenticated carts. Orders are fully transactional (stock
check → totals → coupon → create → decrement stock). **Known critical issue, inherited, not
re-verified but structurally still present in the copied code:** order totals are computed from
client-supplied prices, not re-derived server-side (`CLAUDE.md` §25 #1) — this must be fixed as
part of, not after, introducing country pricing, since a multi-currency/multi-country pricing
model makes trusting client-sent prices even more exploitable. Full detail: `backend/CLAUDE.md`
§18 (Data Flow), §25 #1–3.

## 8. Payment system

Razorpay fully wired end-to-end (backend + frontend). Cashfree backend-complete
(order creation, COD deposits, webhook with HMAC verification, idempotent terminal-state handling)
but **zero frontend integration** — checkout only offers COD and Razorpay. For international
expansion (UAE/USA/Australia/UK/EU), **neither current gateway covers most target markets** —
Razorpay and Cashfree are India-focused. This is a real gap for Phase 3 (Internationalization):
a payment-provider strategy per country/region needs to be decided, it isn't a "reuse what
exists" situation. Full detail: `backend/CLAUDE.md` §18 (Payments), §25 #10.

## 9. Admin system

Same Next.js app under `/admin` (route group, not a separate deployment). Client-side route
protection only (`useEffect` redirect) — server-side authorization (`isAdmin`/`isAdminOrSubAdmin`)
is what actually matters and is correctly enforced; the client-side gap is a UX/flash issue, not an
auth bypass (`CLAUDE.md` §25 #16). Covers dashboard analytics, product/variant CRUD, categories,
collections, orders, customers, banners, homepage builder, coupons, reviews, media library, SEO,
settings. This is a strong foundation to extend with country-scoped content management
(MASTER-PROMPT §10).

## 10. Image/media system

A genuinely sophisticated derivative pipeline already exists (`backend/CLAUDE.md` §19): AVIF
primary/WebP fallback, responsive width ladder, blur-up placeholders, background re-encode queue,
resolution-floor enforcement on upload, EXIF-aware admin-side cropping per surface. This is
directly reusable for handicraft product photography with no changes — MASTER-PROMPT §19's image
requirements are already met by this system.

## 11. SEO system

Present: `robots.ts`, dynamic `sitemap.ts` (products/categories/blogs), per-product JSON-LD
`Product` schema, per-page `SeoMeta`. **Broken:** CMS pages 404 — frontend calls `/cms/:slug`, the
actual route is `/seo/cms/:slug`, and these slugs are still listed in the sitemap (`CLAUDE.md` §25
#7). No international SEO exists at all yet (no hreflang, no localized URLs, no country-specific
metadata) — this is 100% new work for Phase 3/6, not an extension.

## 12. Current performance

No baseline measurements exist (no Lighthouse/CWV data captured in either repo or this discovery
pass — would require a running production-equivalent environment, out of scope for a local dev spot
check). The image pipeline is performance-conscious by design. Known perf-relevant gaps: two stray
`console.log`s existed in the frontend (one fixed 2026-09-09, see `docs/decisions/0002-...`), no
ESLint/bundle-size tooling configured, React Query is under-used relative to what's installed.
**Recommendation:** establish a real CWV baseline (MASTER-PROMPT §35) before Phase 5, not now — a
baseline against fashion-store content is not representative of the eventual handicraft site.

## 13. Security assessment

Inherited `CLAUDE.md` §21/§25 lists a real, specific set of issues — not re-derived independently
here, but the highest-severity ones (client-trusted order totals, plaintext-password logging on
failed auth) are structural code patterns, not one-off bugs, and were spot-checked present in the
copied code. Additionally found during this setup (2026-09-09): frontend has 2 critical + 7 high
npm vulnerabilities (`next` — including unauthenticated RCE — and `swiper`), backend has 17
non-critical. See `docs/claude/technical-debt.md` for both sets. **None of the inherited security
issues have been fixed yet in `wood-vintage`** — they were deliberately left as-is pending
prioritization, except the two already fixed as part of getting local dev working (hardcoded
API_URL, stray console.log — cosmetic/config, not the auth/pricing issues).

## 14. Reusable modules

High confidence, reuse as-is: JWT auth flow, image derivative pipeline, response envelope
(`sendSuccess`/`sendError`/`sendPaginated`), upload/multer infrastructure, admin panel shell and
CRUD patterns, Razorpay integration (for India), the CMS/homepage-section-builder pattern (needs
country-scoping added, not rebuilding), the reorder/drag-and-drop admin UX pattern
(`SortableImageGrid`, banners, homepage sections).

## 15. Modules requiring refactoring

Order pricing (move to server-authoritative, MASTER-PROMPT §29's flat pricing-array pattern extends
naturally here for country pricing). Shipping calculation (currently two disagreeing hardcoded
values between frontend and backend — needs to become the country-configurable system MASTER-PROMPT
§18 describes, replacing both). Product schema (needs new fields/relations for materials, styles,
room, dimensions, customization — additive, not a rewrite of what exists). CMS page routing (fix the
`/cms` vs `/seo/cms` mismatch as part of building out real CMS-driven content per §11).

## 16. Modules requiring replacement

Payment gateway strategy for non-India markets (Razorpay/Cashfree don't meaningfully cover UAE,
USA, Australia, UK, or the EU — needs new provider(s), not a config change). The fashion-specific
UI/theme (`themes/index.ex` black-and-gold palette, all storefront copy, category taxonomy assuming
size/colour/gender) — component *architecture* is reusable, the actual design system and content
are not. Seeded demo data (`seedGenderDemo.ts` and the first-boot seed in `server.ts`) is
fashion-specific and will need a handicraft-domain equivalent.

## 17. Migration risks

**Highest risk: no Prisma migration history.** `db push` can drop data to converge schema — every
schema change from here forward (adding country/pricing/material/style models, product fields)
needs a `mysqldump` backup first and a reviewed `db push --dry-run`-equivalent check (there isn't
one built in; review the printed plan manually) until `prisma migrate` is adopted (already tracked
as a P1 improvement in the inherited `CLAUDE.md` §26 — worth doing **before**, not after, the
Phase 1 schema changes, given how much new schema Phase 1–2 add). Second risk: existing
`unique-dressup` production data (real customers, real orders) is fashion-specific — MASTER-PROMPT
§45 applies directly: determine what's generic vs fashion-specific before any shared-infrastructure
migration, and this discovery pass has not inventoried the *production* `unique-dressup` database
(only the schema, via Prisma) — a further data-shape audit is needed before any decision to migrate
real customer/order data into a handicraft platform, if that's ever intended. **Open question for
the user:** is `wood-vintage` meant to eventually replace `unique-dressup` in production with its
existing customers, or launch as a genuinely separate platform/customer base? This changes whether
§45/§46 (data migration, legacy compatibility) apply at all. Not assumed either way here.

---

## 18. Recommended architecture

Extend, don't replace, the existing layered backend (routes/controllers/services/Prisma) and the
Next.js App Router frontend. The two structural additions that touch almost everything else:

1. **A `Country` model as a first-class Prisma entity** (MASTER-PROMPT §7's shape), referenced by a
   new country-scoped pricing table (not columns-per-country, §29), a country-availability join on
   Product, and country-scoped content overrides (Global → Country → Language inheritance, §30).
2. **A `CountryContext`** resolved once per request (frontend: from IP/edge detection with
   cookie/localStorage/locale fallback per §8, never GPS; backend: read from a header/cookie set by
   the frontend, or independently resolved for server-to-server calls) that threads through
   pricing, availability, shipping, SEO, and content resolution — mirroring how `ud_gender` already
   works today via a cookie for SSR-safe rendering (`CLAUDE.md` §19's gender-cookie note is a very
   close precedent for exactly this pattern).

Both of these are additive to the current schema/architecture, consistent with MASTER-PROMPT §2–3's
"reuse, don't rebuild" principle — this is genuinely more foundation-laying than replacement.

## 19. Country architecture

Concretely, on top of §18: `Country` (code, name, currency, locale, timezone, language, enabled
flag), `CountryPricingRule` (productId, countryId, price, currency — replacing any temptation
toward `priceUSA`/`priceIndia` columns per §29), `ProductCountryAvailability` (productId, countryId,
available), `CountryShippingRule` (countryId, method, cost, freeThreshold, estimatedDelivery,
oversized-item handling), and country scoping added to `HomepageSection`/`Banner`/`CmsPage`
(these three already have an `isActive`/`sortOrder` pattern to extend with a nullable `countryId`
— global when null, override when set, matching §30's inheritance model without new tables per
content type). Admin UI: extend the existing homepage/banner/CMS builders with a country selector
rather than building parallel admin surfaces per country (§10).

## 20. CMS architecture

The current `HomepageSection`/`Banner`/`CmsPage`/`SeoMeta` models already form a real CMS
foundation — MASTER-PROMPT §11's requirement is largely "extend what exists with country/language
scoping," not "build a CMS." Fix the CMS page routing bug (§11/§15 above) as part of this work,
since broken CMS pages block any country-content override work from being visible at all.

## 21. International SEO architecture

**Undecided — flagged, not chosen**, per MASTER-PROMPT §31's explicit instruction not to pick this
arbitrarily. Candidate: subdirectory-per-country (`/in/`, `/us/`, `/ae/`, ...), which fits Next.js
App Router's route-group/dynamic-segment model cleanly and keeps a single domain (simpler
canonicalization, one sitemap strategy, easier analytics attribution) versus subdomains or
ccTLDs. This needs a dedicated decision record in `docs/decisions/` evaluating SEO/maintainability/
localization/canonicalization/hreflang/analytics/scalability before Phase 3/6 implementation
starts — not decided here, this discovery pass is flagging it as the next real decision needed.

## 22. CDN architecture

The existing image-derivative pipeline (§10/§14) is CDN-ready in shape (cacheable derivatives,
content-hashed by mtime+size) but currently serves directly from the Express app (`/uploads`,
`/img`), not from an actual CDN. Recommendation: front `/img` and `/uploads` with a CDN
(Cloudflare or equivalent) once traffic from additional countries makes latency-from-a-single-region
material — this is Phase 5/8 work, not foundational, since the pipeline itself doesn't need to
change, only what fronts it.

## 23. Analytics architecture

Nothing exists today beyond `viewCount` on Product and a basic revenue/dashboard query
(`$queryRaw`-based). MASTER-PROMPT §26's event-driven model (`eventName`/`userId`/`sessionId`/
`country`/`timestamp`/`metadata`) is entirely new work — recommend a dedicated `Event` table (or an
external analytics pipeline, e.g. writing to a queue/warehouse instead of MySQL directly, if event
volume is expected to be high) rather than bolting event storage onto existing transactional tables.
Decide this before Phase 7, since retrofitting event tracking onto already-shipped Phase 1–6 work is
more expensive than building it in from Phase 1.

## 24. Recommended implementation roadmap

Follow `tasks/TASKS.md`'s phase breakdown (mirrors MASTER-PROMPT §47) with one adjustment: pull the
**Prisma migration history adoption** (§17 above) and **server-authoritative pricing fix** (§7/§15
above) into Phase 1, ahead of the country/currency work — both become substantially more expensive
to retrofit once country pricing tables exist on top of them. Sequence:

```
Phase 1: migration history + server-authoritative pricing/shipping FIRST,
         then Country model + CountryContext + CMS country-scoping
Phase 2: handicraft product schema (materials/styles/room/customization)
Phase 3: country pricing/shipping/availability + the URL-strategy decision (§21)
Phase 4: new homepage/storefront experience for the handicraft brand
Phase 5: performance baseline + CDN
Phase 6: SEO (blocked on §21's decision)
Phase 7: analytics (Event model designed before this phase starts, not during it)
Phase 8: scale
```

## 25. Estimated complexity by module

Rough, directional (no story-pointing exercise run) — meant to inform sequencing risk, not a
committed estimate:

| Module | Complexity | Why |
|---|---|---|
| Prisma migration history adoption | Medium | Mechanical but must be done carefully against a live-ish schema; no code logic changes |
| Server-authoritative pricing/shipping | Medium-High | Touches order creation, checkout UI, and every shipping-cost display; needs careful QA (no test suite exists) |
| Country model + CountryContext | High | New cross-cutting concept touching pricing, content, SEO, shipping, admin — the foundational unlock for everything else |
| Handicraft product schema (materials/styles/room/customization) | Medium | Additive schema + admin UI + storefront filters; well-understood shape from MASTER-PROMPT §15–16 |
| Payment provider expansion (non-India) | High | New vendor integration(s), compliance/KYC per country, genuinely new code paths |
| New storefront design/homepage | High | Full re-theme + new content, not a config change; largest design-and-content effort, not just engineering |
| International SEO/URL strategy | Medium-High | Contingent on the §21 decision; once decided, mechanically significant but well-scoped |
| Analytics event system | Medium | New table/pipeline + instrumentation across existing flows; straightforward once the schema is decided |
| CDN fronting | Low-Medium | Existing pipeline barely changes; mostly infra/DNS work |

---

*This report should be re-verified (not assumed still accurate) before major Phase 1 work begins,
since it was produced without a full independent line-by-line audit — see "Verification method."*
