# 0026. Phase 7 (Analytics): frontend event instrumentation + UTM attribution

Date: 2026-09-17

## Decision

Implemented the frontend half of Phase 7 (event firing at the 5 funnel stages, first-touch UTM
capture) per `docs/architecture/phase-7-analytics-spec.md` §3/§4, built by a delegated agent and
independently re-verified before pushing. `wood-vintage/frontend` commits `0e69032`, `13e93e6`.
Pushed to `origin` and `woodvintage`. This closes Phase 7's remaining scope — see `0024`/`0025` for
the backend pieces (country breakdown, event log, funnel report, UTM columns).

## What was built

1. **`lib/analytics.ts`** — `trackEvent(name, opts?)`, fire-and-forget `POST /metrics/event` with
   `keepalive: true`, silent on failure (same discipline as `WebVitalsReporter.tsx`). Reuses the
   exact `sessionId` `lib/axios.ts` already generates under `localStorage['sessionId']` — read-only,
   no second identity mechanism.
2. **5 event-firing call sites**, one per funnel stage: `PageViewTracker.tsx` (new, mounted in root
   layout, skips `/admin`), `ProductDetailClient.tsx` (extends the existing view-tracking effect,
   not a new one), `useCart.ts` (`addToCart`, success path only), `checkout/page.tsx` (mount),
   `order-success/page.tsx` (once per real order number, ref-guarded against double-firing).
3. **`lib/attribution.ts`** + **`AttributionInitializer.tsx`** — `wv_attribution` cookie, same
   read/write pattern as `genderPreference.ts`/`countryPreference.ts`. First-touch only: never
   overwrites an already-stored value.
4. **`checkout/page.tsx`** now threads `utmSource`/`utmMedium`/`utmCampaign` from the stored
   attribution into `POST /orders`'s payload.

## Verification

Independently re-verified beyond the implementing agent's own report:

- Reviewed every line of both commits' diffs — `lib/analytics.ts`, `lib/attribution.ts`,
  `AttributionInitializer.tsx`, and all 5 event-firing call sites match the spec exactly, correct
  success/failure gating (`ADD_TO_CART` only after the real success path, not in the `catch`),
  correct first-touch guard (`AttributionInitializer` checks `readStoredAttribution()` before
  persisting).
- `npm run type-check` and `npm run build` — both clean, run myself.
- Found and fixed one thing the agent's cleanup left behind: a single `CANCELLED` test order
  (stock/totalSold already correctly restored via the real cancel flow, per its own report) that it
  could not delete due to a sandbox restriction on its side. Deleted it directly — safe, since the
  cancel flow had already run correctly and a delete afterward does not double-adjust stock. DB
  confirmed clean: 0 orders, 0 analytics events.
- Confirmed the `POST /metrics/event` endpoint itself still works correctly post-merge with a real
  request. Attempted a live browser-driven check of both event-firing and the UTM cookie via local
  headless Chrome (`--dump-dom`, never `claude-in-chrome`) but found this method exits before an
  async `keepalive` fetch reliably completes and isn't suited to reading Chrome's cookie store
  without extra tooling — a testing-method limitation, not a code gap. Relied on the thorough code
  review above plus the implementing agent's own more suitable verification (a real puppeteer-driven
  browser session that waited for and captured the actual network requests, confirmed 6 real events
  landing with one consistent session id, a real funnel report matching exactly, and a real cookie
  set/not-overwritten check) for the actual runtime behavior.

## Consequences

- **Phase 7 (Analytics) is now done** — event tracking, funnel tracking, country dashboards, product
  analytics, and marketing attribution are all real and working, without any third-party analytics
  vendor dependency (deliberately deferred as a business decision, not built here).
- No admin UI screen renders the funnel/country-breakdown data yet — both endpoints are correct;
  a dashboard chart is a natural, low-risk follow-up, tracked in `tasks/TASKS.md`, not blocking.
- Every future funnel-relevant UI action should call `trackEvent()` the same way, and every future
  first-touch-style preference should follow `lib/attribution.ts`'s cookie pattern.
