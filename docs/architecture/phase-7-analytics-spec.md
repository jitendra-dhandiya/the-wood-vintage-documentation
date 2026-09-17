# Phase 7 — Analytics: implementation spec

Date: 2026-09-17. Covers MASTER-PROMPT §47 Phase 7 (event tracking, funnel tracking, country
dashboards, product analytics, marketing attribution).

## Scope decision

A real third-party analytics platform (GA4/Segment/PostHog/Mixpanel/etc.) is a genuine vendor
choice — it needs an account, API keys, and a decision about data residency/cost, none of which are
mine to make. **This spec deliberately does not integrate one.** Instead it builds the minimum
in-house version of each Phase 7 sub-item using data this app already generates, mirroring the
approach already taken for Core Web Vitals in Phase 5 (`docs/decisions/0022-...`): real, useful,
zero new vendor dependency, and it doesn't foreclose adding a real platform later — the event log
this spec builds is exactly the kind of thing that later gets *piped into* GA4/Segment, not replaced
by it.

- **Country dashboards** and **product analytics** turned out to be already-mostly-there:
  `Order` had no real country FK (only a free-text name buried in a JSON address snapshot) — fixed
  directly, not part of this delegated spec, see `docs/decisions/0024-...` (`Order.countryId`
  migration + `GET /analytics/country-breakdown`, already built and verified). `topProducts` already
  existed in the dashboard using `totalSold`. This spec covers what's left: **event tracking**,
  **funnel tracking**, and **marketing attribution**.

## §1. Event tracking (backend)

New `AnalyticsEvent` model — deliberately minimal, no user-facing admin CRUD, just a write-heavy log
table:

```prisma
model AnalyticsEvent {
  id        String   @id @default(uuid())
  name      String   // PAGE_VIEW | PRODUCT_VIEW | ADD_TO_CART | CHECKOUT_STARTED | ORDER_PLACED
  sessionId String?  // same id already sent as the x-session-id header (lib/axios.ts) -- reuse it,
                      // don't invent a second identity mechanism
  userId    String?
  path      String?
  productId String?
  countryId String?
  createdAt DateTime @default(now())

  @@index([name, createdAt])
  @@index([sessionId])
  @@map("analytics_events")
}
```

No `meta`/free-form JSON field — every consumer of this table (the funnel report, §2) only needs the
typed columns above; a JSON blob nobody queries is exactly the kind of premature flexibility this
codebase's own conventions warn against.

New public `POST /metrics/event` (extend the existing `metrics` module from Phase 5, same file
pattern as `reportWebVitals`): validates `name` against a fixed allow-list (the 5 values above —
reject/no-op anything else, same defensive posture as the web-vitals endpoint, since this is a
public, unauthenticated endpoint fed by every visitor's browser), resolves `countryId` from an
optional `?country=`/body `country` code the same way other public endpoints do
(`resolveCountryIdForBrowsing`, `utils/countryPricing.ts` — reuse it, don't reinvent), writes one row.

## §2. Funnel tracking (backend)

New `GET /analytics/funnel` (admin, extend `analytics.controller.ts`/`analytics.routes.ts`, same
module Phase 7's country-breakdown endpoint already extended): counts **distinct sessions** reaching
each of the 5 stages within an optional date range (`startDate`/`endDate` query params, same
convention as `getRevenueReport`), in the fixed funnel order, plus the conversion rate from each
stage to the next. Distinct sessions, not raw event counts — a shopper who views 5 products should
count once in `PRODUCT_VIEW`, not 5 times, or the funnel percentages are meaningless.

## §3. Frontend event firing

Add a small `lib/analytics.ts` helper — `trackEvent(name, { path?, productId? })` — fire-and-forget
`POST` to `/metrics/event` with `keepalive: true`, reusing the same `sessionId` `lib/axios.ts`
already generates (read it the same way: `localStorage.getItem('sessionId')`, falling back to
generating one the same way if absent — do not change `lib/axios.ts`'s own logic, just read the same
key). Wire it at exactly these points, matching the funnel's 5 stages:

- `PAGE_VIEW` — once per real storefront navigation. The cheapest correct place is a small client
  component mounted in `app/layout.tsx` (near `WebVitalsReporter`/`NavigationProgress`) that fires on
  pathname change via `usePathname()` — same pattern `WebVitalsReporter.tsx` already uses. Scope to
  `(store)`/`(account)` routes only (skip `(admin)` — admin activity isn't a shopper funnel signal).
- `PRODUCT_VIEW` — `ProductDetailClient.tsx`, alongside the existing recently-viewed/view-count
  side effects (same `useEffect`, same trigger — don't add a second effect for this).
- `ADD_TO_CART` — `hooks/useCart.ts`'s `addToCart`, after a successful call.
- `CHECKOUT_STARTED` — `checkout/page.tsx`, once on mount.
- `ORDER_PLACED` — `order-success/page.tsx` (or wherever the checkout flow lands after a successful
  order), once on mount, include the resolved `productId`s is not needed here (the order itself has
  them) — just the funnel stage.

Every call site's tracking call must be **best-effort and silent** — never block, never throw, never
show the shopper an error for a failed analytics beacon (same discipline as
`WebVitalsReporter.tsx`'s `.catch(() => {})`).

## §4. Marketing attribution (basic UTM capture)

Add `utmSource`/`utmMedium`/`utmCampaign` (all nullable `String`) to `Order` — explicit, queryable
columns, not a JSON blob, matching how `Order` already models everything else as typed columns
rather than free-form JSON (the two JSON fields it has, `shippingAddress`/`billingAddress`, are
deliberate snapshots of a whole external shape, not a place to bolt on 3 more fields).

Frontend: on first landing (root layout or a small client init component, same tier as
`GenderInitializer`), read `utm_source`/`utm_medium`/`utm_campaign` from `useSearchParams()` if
present, and persist them in a cookie (`wv_attribution`, JSON-encoded, similar to `ud_gender`/
`wv_country`'s pattern) — **only if none is already stored** (first-touch attribution: the campaign
that brought the shopper in the first time is the one that matters, not whichever link they clicked
on a later visit). Thread the stored values into `POST /orders`'s payload (`utmSource`/`utmMedium`/
`utmCampaign`, all optional) at checkout, alongside the existing `country`/`shippingAddress` fields.

## Non-goals (explicitly out of scope)

- Any real third-party analytics/attribution platform integration — a vendor decision, not code.
- Session replay, heatmaps, A/B testing infrastructure — not asked for, not implied by "event
  tracking, funnel tracking, country dashboards, product analytics, marketing attribution."
- Retroactively backfilling `AnalyticsEvent`/`Order.countryId`/UTM columns for historical data — none
  exists to backfill (this DB's orders are all test data that gets cleaned up after verification).
- An admin UI screen to *view* the funnel/country-breakdown reports — the endpoints are real and
  correct; a dashboard chart consuming them is a natural follow-up, not required to close this phase
  (the existing admin analytics dashboard already has a precedent for adding a chart once an
  endpoint exists — follow that pattern later, not blocking here).

## Rollout / commit plan

1. Backend: `AnalyticsEvent` model + migration, `POST /metrics/event`, `GET /analytics/funnel`,
   `Order.utmSource/utmMedium/utmCampaign` columns + migration (can combine into one migration).
2. Frontend: `lib/analytics.ts` helper + the 5 event-firing call sites (one commit).
3. Frontend: UTM capture + threading into order creation (separate commit — independently
   revertible from event tracking, since it touches `checkout/page.tsx`'s order payload, a
   higher-stakes file than the event-firing call sites).

## Verification checklist

- Real `POST /metrics/event` calls for each of the 5 event names land in `analytics_events`;
  an invalid `name` is silently rejected (no row, no crash), same posture as web-vitals.
- `GET /analytics/funnel` with real seeded events shows correct distinct-session counts and
  conversion rates at each stage — verify by firing a real, deliberate sequence of events for one
  session and checking the numbers, not just that the endpoint returns `200`.
- A real order placed through the checkout flow with `?utm_source=...&utm_medium=...` in the landing
  URL results in an `Order` row with those columns populated; a second visit with different UTM
  params (simulating first-touch) does not overwrite an already-stored attribution cookie.
- `npm run type-check` / `npm run build` (frontend) and `npx tsc --noEmit` (backend) clean.
- DB confirmed clean (test events/orders removed) after verification, matching this session's
  standing discipline.
