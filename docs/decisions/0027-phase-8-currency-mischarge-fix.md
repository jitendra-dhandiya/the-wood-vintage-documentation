# 0027. Phase 8 (Scale): fixed a real currency-mischarging bug in payment processing

Date: 2026-09-17

## Decision

Audited Phase 8 (Scale: high traffic, high product count, large image volumes, international
orders, multiple warehouses, multiple payment providers, multiple shipping providers,
recommendation engine, AI-assisted merchandising) against the real codebase. Multi-warehouse was
already explicitly deferred by the user (2026-09-17). Most of the remaining scope is genuinely
blocked on business/vendor decisions (payment/shipping providers, AI merchandising, per-country tax
rates — see below). One item was a real, live correctness bug, independent of any vendor
decision — fixed it directly. `wood-vintage/backend` commit `fd084de`. Pushed to both remotes.

## The bug

`payment.controller.ts`'s Razorpay and Cashfree integrations both hardcoded `currency: 'INR'` /
`order_currency: 'INR'` while charging `order.total` — which, for any order placed under a non-India
country, is already denominated in that country's own currency (`Country.currency`, e.g. `AED`) via
`ProductCountryPricing`. A UAE customer's AED-denominated total would have been submitted to the
gateway labeled as INR: charged roughly 22x too little (the AED:INR exchange rate), silently, with
no error anywhere in the flow. This was live and would have fired the moment any non-India country
was enabled with online payment available — not a hypothetical future gap.

## Fix

Resolve the order's real currency (`order.countryId` → `Country.currency`, defaulting to `INR` for
orders with no resolved country, matching existing default behavior) and **refuse online payment**
when it isn't `INR`, rather than attempting an unverified pass-through. Neither gateway's configured
merchant account has been confirmed — or even chosen, per the existing open "payment providers for
non-India markets" question in `tasks/TASKS.md` — to actually settle a non-INR charge, so silently
trying is exactly the class of bug being fixed; failing clearly and immediately is strictly safer
than guessing. COD is unaffected. The COD delivery-charge-deposit path (which also hit this bug)
gets a different, non-confusing message, since that shopper already chose COD.

## Verification

- `npx tsc --noEmit` clean.
- Temporarily enabled the seeded `AE` (AED) market, placed a real order under it, confirmed both
  `POST /payments/razorpay/create` and `POST /payments/cashfree/create` now reject it with a clear
  `400` **before ever constructing a gateway API call** — not just that the eventual charge would
  have been wrong, but that it's now impossible to reach the gateway with it.
- Placed a real India/INR order and confirmed it **passes** the new guard and reaches the actual
  Razorpay SDK call — failing only on the pre-existing placeholder-key issue (a separate, already-
  tracked blocker, unrelated to this fix, unaffected by it).
- Cleaned up afterward: both test orders cancelled through the real flow (stock restored correctly),
  then deleted; `AE` disabled again; DB confirmed at 0 orders.

## What's left in Phase 8, and why it's not built here

- **High-product-count search performance**: current product search (`getProducts`/
  `searchProducts`) uses `contains` (`LIKE '%...%'`), which can't use a B-tree index and degrades
  non-linearly at real scale. Real gap, **not built** — the catalogue is currently near-empty, so
  there is no measured problem to fix, and a `MATCH...AGAINST` full-text rewrite touches the
  highest-traffic query in the app with real behavioral differences (stopwords, minimum word length,
  relevance ranking) worth doing carefully when it's actually needed, not speculatively now. Logged
  in `docs/claude/technical-debt.md`.
- **High-traffic horizontal scaling**: rate limiting uses `express-rate-limit`'s default in-memory
  store (per-PM2-worker, not shared) and file uploads write to local disk — both fine for the
  current single-machine PM2 cluster deployment target, both would need a shared store (Redis) or
  object storage (S3-compatible) respectively the moment the app runs on more than one machine.
  Same class of decision as Phase 5's CDN/caching deferral (`0022`) — an infrastructure choice, not
  something to build ahead of an actual multi-machine deployment. Logged in `technical-debt.md`.
- **International orders — tax rates**: `Product.taxPercent` is a single global, India-GST-shaped
  field; VAT/sales-tax/GST-equivalent rates differ by market and aren't modeled per-country. The
  schema change itself would be straightforward, but needs real rates from whoever owns
  finance/legal compliance for each target market first — building it with placeholder numbers would
  be actively wrong, not merely incomplete.
- **Multiple payment providers, multiple shipping providers, AI-assisted merchandising**: all
  confirmed genuinely missing/single-provider and all blocked on real vendor/business decisions
  (which provider, budget, commercial terms) — `multiple shipping providers` in particular turned out
  to be a single hardcoded `DELHIVERY` enum value with no real carrier API integration of any kind,
  not a partial multi-carrier system. None built.
- **Recommendation engine**: already real (Phase 4, `0020`) and confirmed to already have clean,
  structured interaction data available for future ML use (`AnalyticsEvent`, `RecentlyViewed`,
  `OrderItem`) — the actual blocker to anything ML-based being meaningful is real order volume, not
  missing infrastructure. Nothing to build.

## Consequences

- This is the one Phase 8 item that was a genuine bug rather than a scale-readiness gap — fixed
  regardless of the broader vendor-decision questions still open.
- Every future non-India payment integration (whichever provider gets chosen) must resolve and pass
  the order's real currency, not assume INR — this fix's `resolveOrderCurrency()` helper is the
  pattern to extend, not bypass.
