# 0040. Marketing go-to-market plan: India-first, WhatsApp-led, gated paid ads, honest positioning

Date: 2026-09-25

## Decision
Adopt the plan in `docs/marketing/first-100-orders-plan.md` (detail in `docs/marketing/first-100/*.md`) and the
synthesis in `docs/marketing/master-growth-plan.md` as the go-to-market for the first 100 paid orders:

1. **Market:** India (domestic D2C) only for the first 100 orders. USA = small-décor hybrid pilot (marketplace/B2B) after order 30-50;
   UAE = research only; no EU/AU/CA (see `docs/countries/market-selection.md`).
2. **Positioning:** "value-premium, made to order": made to your room, one honest price, a delivery date we keep, wood named and proven,
   repair-first 12-month warranty. **Never claim "30% cheaper"**: the discount is real only against brand-tier selling prices (not MRP)
   and only about level with Woodsala.
3. **Launch readiness gate before any ad spend** (Gate A, config and content only, target 16 Oct 2026): real WhatsApp/phone/email,
   fake testimonials/artisans/blog/photos removed, real photographed products only, made-to-order policies replacing the parcel-shop ones.
   Gate B (payment keys, confirmation email, pincode estimate, advance path, pixel) before website-sales ads.
4. **Catalogue:** 16 launch SKUs (carved mandirs, jaali panels, mirrors, coffee/end tables, console, bookshelf, desk, bench, kitchen wood)
   plus 4 quote-only pieces (dining, bed, TV unit, bedside). Each has a price and a **"do not go below" floor** (contribution before CAC at least 25% and after
   blended CAC at least 10%). Margin-negative SKUs (beds, TV units, bedside tables, wardrobes, sofas) are never discounted or bundled.
5. **Combos** (decision 0037): nine, FIXED_PRICE, each above its floor. **Coupons** (decision 0035): eight codes, one per order, all with `excludeSaleItems`
   so they never stack with combos; seed WELCOME10/FREESHIP/HANDMADE500 deactivated. BUY_X_GET_Y is unsupported; combos are the workaround.
6. **Budget:** Scenario C "Base" (INR 1.25 lakh per 4 weeks at steady state, released in stages by stop/scale rules; about INR 3.6 lakh over 16 weeks) as the
   recommendation; Lean (INR 40k) if cash is tight. Base case: about 96 orders by week 16 (range 59-132). Diwali (8 Nov 2026) is a ready-stock and gifting festival,
   not a made-to-order one.

## Why
The owner needs the first 100 orders from a brand with 0 followers, no reviews, placeholder contact details and fabricated demo content on the live site, in a market
where the price floor is set by marketplace factory sellers and the closest Jodhpur peer prices at a similar level. Earlier research (market selection, benchmark,
unit economics, USP, social, SEO, gap tracker) showed that (a) price alone will not win, (b) several natural products are margin-negative at plausible costs,
(c) paid CAC is roughly equal to the average contribution of a first order, and (d) the largest conversion risks are trust and response speed, not reach. The plan
turns those findings into one sequence with numbers the owner can edit.

## Alternatives considered
- **Export-first (USA):** highest demand, but payments/tax/tariffs/CITES and express freight make single-piece consumer sales lose money; deferred.
- **Marketplace-first (Amazon.in/Flipkart):** not researched in depth (blocked pages); brand-building and margin control weaker; not part of the first 100.
- **Discount-led launch (10%+ welcome, "30% off" claims):** breaks floors on several SKUs, contradicts the honest-price USP, invites the same MRP theatre we criticise.
- **Growth scenario (INR 4 lakh per 4 weeks):** exceeds default workshop capacity and gives about INR 6,000 all-in cost per order; rejected for the first 16 weeks.
- **Organic-only:** cheapest (about INR 1,600 per order) but about 30 orders in 16 weeks and 100 orders only after about 9 months; kept as the floor scenario.
- **Ads before the gate:** rejected: a broken funnel (placeholder WhatsApp, fake reviews, contradictory policies) turns spend into distrust.

## Chosen approach
Ten supporting files under `docs/marketing/first-100/` (owner input sheet, gate, catalogue, combos, coupons, audience, channel mix and budget, customisation offer,
roadmap and operations, risks). All costs and conversion rates are ASSUMPTIONS with an owner-editable input table; the model uses the formulas of
`docs/marketing/unit-economics-model.md`. The KPI dashboard, 30/60/90 plan, 12 open owner decisions and the "not doing yet" list are in the master plan.
No code changes; no push.

## Consequences
- Owner must supply real timber cost, ex-factory cost per SKU, capacity, lead times, advance %, and approve policy and warranty wording before Gate A can close.
- Paid ads start no earlier than 16 Oct 2026 (Gate A), likely 19 Oct; Diwali order cut-offs (28 Oct ready stock) are owner inputs.
- The plan is cash-negative by about INR 2.4 lakh over 16 weeks at default fixed costs (Base), plus about INR 1.1 lakh of ready stock, by design.
- WhatsApp-closed orders are invisible to the site's coupon/UTM reports until an admin manual-order path exists; the lead sheet is the interim source of truth.
- Gate B items and several SEO/UX items need the development hold lifted; owner decides which and when (decision 10 in the master plan).
- Combos sell standard specifications only; customised sets are quoted by hand.
- Revisit after order 20 (replace assumptions with data), order 30 (unlock quote-only pieces and the US B2B sample discussion) and order 100.

## Date
2026-09-25


## Update 2026-09-25 (later the same day): owner direction supersedes India-only
The owner set the business as B2C with the first 100 orders from customers **outside India**, the USA first, India domestic out of scope and the UAE B2B only. The India-first plan above is therefore superseded for the export business; the export analysis is in `docs/marketing/export-b2c-logistics-and-landed-cost.md`, `docs/countries/market-selection.md` (Revision 2026-09-25) and `docs/countries/us.md`. No code changed.

## Update 2026-09-25 (US edition): superseded for the export business
Decision [0041](0041-us-first-b2c-export-plan.md) replaces the India-only first-100 plan with the US-first B2C plan (`docs/marketing/us-first-100-orders-plan.md`). The India files carry a "superseded by the US edition" banner and are kept for history and method.
