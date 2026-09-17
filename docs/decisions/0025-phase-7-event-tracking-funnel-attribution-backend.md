# 0025. Phase 7 (Analytics): event tracking, funnel report, UTM attribution — backend

Date: 2026-09-17

## Decision

Built the backend half of the remaining Phase 7 scope (event tracking, funnel tracking, marketing
attribution) per `docs/architecture/phase-7-analytics-spec.md`. Deliberately an in-house, minimal
implementation — no third-party analytics platform (GA4/Segment/PostHog/etc.) integrated, since that
is a vendor decision, not something to guess at in code; mirrors the same call already made for Core
Web Vitals in Phase 5 (`docs/decisions/0022-...`). `wood-vintage/backend` commit `9fe5593`. Pushed to
both remotes. Frontend instrumentation (event firing, UTM capture) is a separate, in-progress piece
— see the spec's §3/§4.

## What was built

1. **`AnalyticsEvent` model** — typed columns only (`name`, `sessionId`, `userId`, `path`,
   `productId`, `countryId`), deliberately no free-form JSON `meta` column, since the only current
   consumer (the funnel report) needs nothing beyond these. `sessionId` reuses the same id
   `lib/axios.ts` already generates and sends as `x-session-id` — no second identity mechanism.
2. **`POST /metrics/event`** (public, extends the `metrics` module from Phase 5) — validates `name`
   against a fixed 5-value allow-list (`PAGE_VIEW`/`PRODUCT_VIEW`/`ADD_TO_CART`/`CHECKOUT_STARTED`/
   `ORDER_PLACED`), same defensive posture as the existing `reportWebVitals` endpoint.
3. **`GET /analytics/funnel`** (admin) — counts **distinct sessions** reaching each stage (not raw
   event rows, which would double-count a shopper who viewed several products), plus a
   conversion-from-start percentage at each stage.
4. **`Order.utmSource`/`utmMedium`/`utmCampaign`** — typed columns (matching how every other order
   fact is modeled; the two JSON fields `Order` already has are deliberate whole-shape snapshots, not
   a place to bolt on 3 more scalars), threaded through `createOrder`. Purely informational — unlike
   `country`, an absent/unrecognised UTM value is never an error.

## Verification

- `npx tsc --noEmit` clean.
- Fired a real, deliberate 6-event sequence across 2 simulated sessions (session A: full funnel
  through to `ORDER_PLACED`; session B: `PAGE_VIEW` only) and confirmed `GET /analytics/funnel`
  reported the exact expected numbers — 2/1/1/1/1 sessions per stage, 100%/50%/50%/50%/50%
  conversion-from-start — not just that the endpoint returned `200`.
- Confirmed an invalid event name (`"BOGUS"`) is silently rejected: `200` response, but zero rows
  written (checked the DB directly, not just the HTTP status).
- Placed a real order with real UTM params (`google`/`cpc`/`furniture-launch`) and confirmed all
  three landed on the `Order` row correctly.
- Cleaned up afterward: cancelled the test order through the real `POST /orders/:id/cancel` flow
  (not a direct DB delete this time — deliberately, after the same class of mistake earlier this
  session with the country-breakdown order required a manual stock-drift correction), deleted the
  simulated `AnalyticsEvent` rows directly (no business-logic side effects on that table). DB
  confirmed clean: 0 orders, 0 events, product stock/totalSold at the correct 100/0 baseline.
- Backend dev server stopped cleanly before committing.

## Consequences

- Frontend instrumentation (firing these events at the right 5 UI touch-points, capturing UTM params
  on first landing) is the remaining piece — delegated separately, will get its own decision record
  once independently verified and pushed.
- No admin UI screen renders the funnel/country-breakdown data yet — both endpoints are real and
  correct; a dashboard chart consuming them is a natural, low-risk follow-up, not required to
  consider Phase 7's backend scope closed.
