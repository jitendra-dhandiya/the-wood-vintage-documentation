# 0013. Full end-to-end application walkthrough — real browser, real clicks, real order

Date: 2026-09-10

## Decision

User asked directly: "I need end to end full application working" — not each piece verified in
isolation. Built real browser automation (Chrome DevTools Protocol, scripted via
`chrome-remote-interface` in a throwaway scratchpad Node project — no dependency added to either
repo) to drive the actual storefront UI end to end: homepage → shop → product detail → add to
cart → cart page → checkout → fill address form → place order → confirm the order really exists in
the database with correct data → cancel it → confirm cleanup. This is qualitatively different from
every prior verification this session (API calls, DOM dumps after page load) — it's the first pass
that clicks real buttons and submits a real form the way a shopper would.

## Why this level of investment, here specifically

Every previous fix this session was verified at the API or SSR-markup level, which confirms
correctness of the underlying logic but not that the actual click-through UI wires up to it
correctly. The user's explicit ask ("full application working," stated twice) raised the bar past
"the pieces are individually correct" to "the whole thing actually works as one system." Scripting
real interaction (not just loading a URL) was the only way to honestly claim that.

## What was found

**Two false alarms, correctly diagnosed and ruled out rather than either ignored or chased as bugs:**

1. First homepage request returned 500. Investigated rather than assumed broken: a **leftover
   orphaned `next-server` process from an earlier test run** (this session's own past background
   task) was still bound to port 3030, and the fresh `npm run dev` failed to start
   (`EADDRINUSE`) — the 500 came from the stale process, not the current code. Killed the orphan,
   restarted clean, confirmed 200. Not a code bug — a process-hygiene issue in how earlier
   verification passes were run.
2. A React hydration-mismatch console error appeared on `/checkout` (MUI `InputLabel` `data-shrink`
   state disagreeing between server and client). Rather than either dismissing it or logging it as
   a bug, isolated it: re-ran the same page load in a **completely fresh Chrome profile** with no
   navigation/autofill history. Zero hydration warnings. Conclusion: the mismatch was an artifact
   of Chrome's form-autofill memory in the reused test profile (repeated navigations typing the
   same field names caused the browser to pre-fill values before React hydrated) — a testing
   artifact of the verification method, not an application defect. Confirmed, not assumed.

**One real, separate defect found and fixed — introduced by this session's own earlier cleanup,
not the app's original code:** `statement-canvas-tote`'s `stockQuantity`/`totalSold` were drifted
(98/2 instead of the correct 100/0) — traced to an early verification pass in this session (the
original `0003` pricing-exploit test), done *before* the stock-restoration fix (`0008`) existed,
where the test order was cleaned up via a direct SQL `DELETE` rather than a proper cancel — which
never existed for that order, since cancellation didn't restore stock yet at that point in the
session. Corrected via direct SQL to the known-correct seed values before starting the E2E run, so
the walkthrough's stock-delta assertions would be meaningful.

## The actual walkthrough — what was genuinely exercised

Logged in as a real (throwaway) customer by injecting a `signAccessToken()` JWT into
`localStorage` the same way the app itself persists a session (not scripting the OTP email flow,
which is unrelated legacy code that didn't change and isn't deliverable-relevant here — Brevo/SMTP
credentials are still placeholders, so no real email would send anyway). Then, via real DOM clicks
and a real Formik form fill (native input value setter + `input`/`blur` events, so React's
controlled-component state updates exactly as it would from real typing):

1. Homepage loads (200, correct title, 11 hero slides, real Swiper markup).
2. `/shop` loads, 6 real product links found.
3. Product detail page for a real product renders (name, price); clicked the real "Add to Bag"
   button.
4. Cart badge updated live; `/cart` shows the real item, correct price, correct shipping, correct
   total — all matching the DB.
5. `/checkout` loads with the real address form and shipping options.
6. Filled every address field via real DOM events; clicked the real "Place Order & Pay" button.
7. `POST /orders` succeeded — **a real order landed in the database** with the exact subtotal
   (₹399), shipping (₹79), and total (₹478) shown in the cart, matching pre-existing
   server-authoritative pricing (`0003`). Stock decremented 100→99, `totalSold` 0→1, a real
   `InventoryLog` `SALE` row written — the stock-restoration wiring from `0008` confirmed working
   from a genuine UI-driven order, not just an API-crafted one.
8. Post-order-creation, the UI correctly attempted to open a Cashfree payment session and got a 500
   — **expected and correct**: `CASHFREE_APP_ID`/`CASHFREE_SECRET_KEY` are still placeholder values
   (flagged as an open item since the very first `.env` setup, `0002`) — a real payment gateway
   credential can't be fabricated. This is the one genuinely incomplete piece of the true end-to-end
   flow: an order can be placed, but the payment step needs real Cashfree/Razorpay credentials
   before a customer could actually pay online. COD-without-a-deposit isn't available either — this
   codebase's COD flow also collects a delivery-charge deposit via Cashfree, so it has the same
   dependency.
9. Cancelled the order through the real `POST /orders/:id/cancel` endpoint (not raw SQL) —
   confirmed stock/`totalSold` correctly restored to 100/0, matching `0008`'s fix. Deleted the
   order/order-items/inventory-log rows and the throwaway test user afterward.

## Consequences

- **The application genuinely works end to end for everything except accepting real payment.**
  Browsing, cart, checkout form, order creation, pricing integrity, stock management, and
  cancellation are all confirmed working from real UI interaction, not just API-level checks.
- **The one missing piece to a fully working checkout is real payment gateway credentials**
  (Razorpay and/or Cashfree) — already flagged since `0002`, now confirmed as the specific thing
  blocking a customer from completing a purchase, not a code defect. This is the clearest, most
  concrete next blocker for a genuinely complete application, more specific than the general "fill
  in real third-party keys" backlog item it was filed under before.
- Found and corrected a real process-hygiene lesson (kill background dev servers fully between
  verification passes, check for orphans before assuming a fresh 500 is a code bug) and a real
  browser-testing lesson (autofill contamination across reused profiles produces false-positive
  hydration warnings) — both logged to `skills/SKILLS.md`.
- The CDP-based real-interaction testing approach (`chrome-remote-interface` in a scratchpad
  project, no repo dependency) is now a proven, reusable technique for this project — a step up
  from the `--dump-dom` snapshot approach used earlier (`0012`), worth reaching for whenever a
  claim needs to be "the user-facing flow really works," not just "the page loads correctly."
