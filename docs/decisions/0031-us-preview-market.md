# 0031. United States enabled as a preview market (sample USD prices)

Date: 2026-09-21

## Decision
Enabled `US` and priced all 46 active products in USD via `backend/src/scripts/seedUsPreview.ts`
(idempotent). USD = INR / 83 × 1.25 margin, rounded to an "x9" price point — SAMPLE numbers for the
client demo, not real pricing. Added preview shipping rules (Standard $39, free over $500, 10–16 days;
Express $79) with a customs/duties message. Verified: `/countries` lists IN+US, `/products?country=US`
returns USD prices, `/us/shop` renders `$` prices with the country selector showing "US · $".

## Still open before a real US launch
- Payments: online payment stays blocked for non-INR orders (decision 0027); Stripe/PayPal not built.
- Carrier integration, US sales tax, US legal pages, real USD prices, shipping-origin decision.
- Cosmetic on `/us/*`: announcement bar text (`announcement_text` setting) and the shop price-range
  slider (`FilterPanel.tsx`, `PRICE_RANGE`) are still INR-denominated.
- The frontend caches the enabled-country list for 5 minutes, so a newly enabled country can redirect
  to `/in` until the cache expires (restart the dev server to clear it).
