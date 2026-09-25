# 1. Owner input sheet - every number the plan depends on

> **SUPERSEDED BY THE US EDITION (2026-09-25).** Owner direction: B2C export, first 100 orders from consumers outside India, USA first, India domestic out of scope. For the export business use [../us-first-100-orders-plan.md](../us-first-100-orders-plan.md) and its files under [../us-first-100/](../us-first-100/). This India D2C document is kept for history and for its India method (decision 0040 is superseded by [0041](../../decisions/0041-us-first-b2c-export-plan.md)).

Part of [../first-100-orders-plan.md](../first-100-orders-plan.md). Date: 2026-09-25.

**How to use.** Every value in the "Default" column is an **ASSUMPTION** unless tagged otherwise: it is our placeholder so the plan can be computed, not a fact about your business. Write your real value in the last column; where a cell is blank the default stays in force. Anything you change moves the margins in [03-starter-catalogue.md](03-starter-catalogue.md), [04-combo-strategy.md](04-combo-strategy.md), [05-coupon-strategy.md](05-coupon-strategy.md) and the funnel in [07-channel-mix-and-budget.md](07-channel-mix-and-budget.md). The margin arithmetic is the one in [../unit-economics-model.md](../unit-economics-model.md) section 2 (formula block in its section 7 can be pasted into a spreadsheet).

Tags: VERIFIED (source read), ESTIMATE (third-party figure, not verified), ASSUMPTION (our placeholder), OWNER-SET (a choice, not a fact). Priority: **P0** = the plan cannot be trusted until you answer; **P1** = answer before spending on ads; **P2** = refine after 20+ orders.

## A. Capacity, time and people

| ID | Input | Unit | Default | Tag | Basis | Priority | Owner's real value |
|---|---|---|---|---|---|---|---|
| A1 | Orders the workshop can produce per month, décor and small pieces (mandir, jaali, mirrors, kitchen wood) | orders/month | 40 | ASSUMPTION | No workshop data. Chosen so 100 orders in 4 months (about 25/month average, peaks of 40-45) is feasible | P0 | |
| A2 | Orders per month, furniture-class pieces (coffee table, console, bookshelf, desk, dining, bed) | orders/month | 10 | ASSUMPTION | Same; furniture uses the same carpenters and is 3-6x the labour per order | P0 | |
| A3 | Lead time, ready-stock standard items (pre-built, shipped from shelf) | working days to dispatch | 3 | ASSUMPTION | Requires you to pre-build stock (see A9) | P0 | |
| A4 | Lead time, made-to-order décor with a size/finish/carving change | working days from advance to dispatch | 12-18 | ASSUMPTION | Competitors: Woodsala 18-30 days by policy, reviews say 4-6+ weeks (VERIFIED, [india-market-price-benchmark.md](../../competitor-research/india-market-price-benchmark.md) section 6). Aim to beat them and keep the date | P0 | |
| A5 | Lead time, made-to-order furniture | working days to dispatch | 21-30 | ASSUMPTION | Same source | P0 | |
| A6 | Transit time, Jodhpur to metro | days | 4-7 | ASSUMPTION | Owner to confirm with courier/transport quote (D6) | P1 | |
| A7 | People who answer WhatsApp/DMs and send quotes | headcount / hours per day | 2 people, 3 h/day each in business hours 10:00-20:00 IST, 7 days | ASSUMPTION | SLA in [../social/07-community-and-sales.md](../social/07-community-and-sales.md) 7.1 (first reply within 15 min in hours). The Base scenario produces about 50 WhatsApp conversations/day at steady state (07 file), which a single person cannot serve | P0 | |
| A8 | Hours per week the owner/marketer can give to content + community | hours/week | 12-16 | ASSUMPTION | [../social-media-playbook.md](../social-media-playbook.md) cadence | P1 | |
| A9 | Ready stock you are willing to pre-build for Diwali (units by SKU) | units / rupee value | 10 mandirs (2 ft), 10 jaali panels, 15 kitchen-wood sets, 10 mirrors | ASSUMPTION | Diwali is 8 Nov 2026, 6 weeks away; made-to-order lead times cannot meet it (see [09-roadmap-and-operations.md](09-roadmap-and-operations.md) section 3). Cash at risk = about INR 1.1 lakh at default ex-factory costs (10 x 3,960 + 10 x 2,330 + 15 x 1,656 + 10 x 2,025), before packaging | P0 | |
| A10 | Last order dates for Diwali (8 Nov 2026) delivery | date | Ready stock: 28 Oct. Made-to-order décor: 16 Oct. Made-to-order furniture: no Diwali promise | ASSUMPTION | Lead time + transit + 5 days buffer; recompute with A3-A6 | P0 | |
| A11 | Blackout dates (workshop closed, festivals, family) | dates | none assumed | - | | P1 | |

## B. Cost inputs

| ID | Input | Unit | Default | Tag | Basis | Priority | Owner's real value |
|---|---|---|---|---|---|---|---|
| B1 | Timber (sheesham) purchase price | INR per cubic foot | 1,500 (scenarios 900 / 2,200) | ESTIMATE | IndiaMART/TradeIndia listings quoted INR 600-2,500/cft in 2026 ([unit-economics-model.md](../unit-economics-model.md) section 3). The biggest single driver of every margin | P0 | |
| B2 | Wood species per SKU | text | sheesham; mango on request | OWNER-SET | | P0 | |
| B3 | Wastage on finished volume | % | 40 | ASSUMPTION | | P1 | |
| B4 | Finished-wood volume, labour, carving, polish and hardware per SKU | INR + cft | table in [03-starter-catalogue.md](03-starter-catalogue.md) section 2 | ASSUMPTION | Volumes back-derived from typical dimensions. New SKUs (end table, console, bookshelf, desk, bench, mandir 2 ft, jaali 90x120, round mirror, cutting board, masala dabba, wall shelf set) have costs invented by this team for the calculation only | P0 | |
| B5 | Packaging per SKU (corner guards, foam, carton, crate) | INR | 60-900, see 03 | ASSUMPTION | | P1 | |
| B6 | Freight, Jodhpur to Delhi NCR / Mumbai / Bengaluru / Hyderabad / Pune / Ahmedabad / Jaipur | INR per consignment at 7, 25, 70, 110 kg | 20-25 INR/kg bulky, 60 INR/kg for a 1-2 kg parcel, minimums INR 110-1,800 | ESTIMATE | Freight blogs INR 50-150/kg or INR 1,700-4,300 per palletised furniture shipment; Shiprocket Cargo from INR 6/kg ([unit-economics-model.md](../unit-economics-model.md) section 3). **Get two written quotes** | P0 | |
| B7 | GST rate per product family | % | 18 (furniture, HSN 9403) applied to all rows | ESTIMATE | Wooden décor HSN 4420 quoted 5% and 12%; kitchenware 4419 5% by different sites; the CA must confirm. Décor at 12% raises net revenue by about 5% of price | P1 | |
| B8 | Payment gateway fee | % of prepaid order | 2.36 (2% + 18% GST) | VERIFIED (Razorpay published pricing, [unit-economics-model.md](../unit-economics-model.md)) | Your contract may differ | P1 | |
| B9 | COD handling fee | INR per COD order | 60 | ASSUMPTION | Ask the courier | P1 | |
| B10 | Damage allowance | % of (factory cost + freight) | 3 | ASSUMPTION | Blogs cite about 7.6% of furniture pieces arriving scuffed (ESTIMATE, in.md) - our packaging spend is meant to beat it | P1 | |
| B11 | Warranty/repair allowance | % of net revenue | 1.5 | ASSUMPTION | 12-month workshop warranty | P1 | |
| B12 | Monthly fixed costs to cover after contribution (rent, wages beyond the factory, software, your time) | INR/month | 60,000 | ASSUMPTION | Only used to judge break-even volume in 07; replace | P1 | |

## C. Commercial terms

| ID | Input | Unit | Default | Tag | Basis | Priority | Owner's real value |
|---|---|---|---|---|---|---|---|
| C1 | Launch price per SKU | INR incl. GST | table in 03 section 3 | ASSUMPTION | Bands from [india-market-price-benchmark.md](../../competitor-research/india-market-price-benchmark.md) section 5.2 (VERIFIED prices, our bands) | P0 | |
| C2 | Advance on made-to-order | % | 50 for orders of INR 15,000 or more; 100% prepaid for orders under INR 5,000; 40% between | OWNER-SET | Typical for custom work; owner and legal to confirm ([08-customisation-offer.md](08-customisation-offer.md) section 4) | P0 | |
| C3 | COD allowed? | yes/no + rule | No COD on made-to-order. COD only on ready-stock parcels under INR 5,000, with INR 300 prepaid deposit | ASSUMPTION | ~60% of Indian e-commerce is COD, COD return rate ~26% vs prepaid <2% (ESTIMATE, [in.md](../../countries/in.md)). The site already has a delivery-charge deposit path (decision 0027) | P0 | |
| C4 | Prepaid share of orders | % | 70 | ASSUMPTION | Follows C2/C3 | P1 | |
| C5 | Return / RTO rate | % of orders | 5 (stress 15) | ASSUMPTION | Made-to-order with advance; furniture RTO 15-20% in the market (ESTIMATE) | P1 | |
| C6 | Average order value, mix of the launch catalogue | INR incl. GST | 12,600 (skewed up by a few large combos; expect most orders INR 4,000-16,000) | ASSUMPTION | Computed from the order mix in 07 section 2; check against your first 20 orders | P1 | |
| C7 | Coupon/discount allowance built into every margin row | % of price | 5 for single SKUs, 0 for combos (combo lines are excluded from coupons, see 05) | ASSUMPTION | | P1 | |
| C8 | Free-delivery threshold | INR | 4,999 (existing site setting `free_shipping_threshold`, decision 0028) | VERIFIED (seed) | Furniture uses per-product shipping rules (decision 0015). Confirm whether the comparison is `>=` or `>` (not verified) | P1 | |
| C9 | Warranty term | months | 12, repair-first | OWNER-SET | [../positioning-and-usp.md](../positioning-and-usp.md) USP 5 | P0 | |
| C10 | Minimum order value for a customised piece | INR | 4,999 (décor), 9,999 (custom furniture) | OWNER-SET | | P1 | |

## D. Marketing and funnel inputs (conversion assumptions, low / base / high)

No furniture-specific Indian Meta or Google benchmarks were found by any team (gap recorded in [../unit-economics-model.md](../unit-economics-model.md) section 9). These are our reasoned ranges; **the first Rs 10,000 of ads replaces them.**

| ID | Input | Low | Base | High | Tag | Basis | Owner's real value |
|---|---|---|---|---|---|---|---|
| D1 | Meta CPM, India | 260 | 200 | 150 | ESTIMATE | India CPM about USD 1.36-2.60 = INR 120-230 (lebesgue.io); Reels INR 45-140 vs feed 150-350 (upgrowth.in), both from [../social/06-paid-social.md](../social/06-paid-social.md) | |
| D2 | Link click-through rate (CTWA/traffic) | 0.6% | 0.9% | 1.4% | ASSUMPTION | | |
| D3 | Click to WhatsApp conversation started (CTWA) | 30% | 40% | 50% | ASSUMPTION | | |
| D4 | Conversation to qualified (city + room/size + budget + date given) | 30% | 35% | 45% | ASSUMPTION | | |
| D5 | Qualified to quote sent | 70% | 75% | 80% | ASSUMPTION | | |
| D6 | Quote to paid order, cold paid leads | 4% | 8% | 14% | ASSUMPTION | High-ticket custom items convert low from cold; 0.5-1% site conversion is the range used in the unit-economics doc | |
| D7 | Quote to paid order, warm leads (network, referral, designer, retargeted) | 12% | 20% | 30% | ASSUMPTION | | |
| D8 | Site session to quote-form lead | 1.5% | 3% | 5% | ASSUMPTION | Vendor furniture conversion benchmark 3.77% (ESTIMATE, 06-paid-social.md) is for purchases, so a lead rate of 3% is deliberately moderate | |
| D9 | Paid CAC used in SKU margin rows | see 03 | see 03 | see 03 | ASSUMPTION | 450 (tray) to 3,000 (bed) from the unit-economics model; new SKUs banded by price | |
| D10 | Blended CAC from base funnel | 17,200 | 2,650 | 425 | derived | D1-D6 arithmetic. The low case shows the funnel is broken (stop rule), the high case is not to be planned on | |
| D11 | CAC ceiling (kill line) and CAC target | 3,000 / 2,000 | | | OWNER-SET | Kill line about 85% of mix-weighted contribution before CAC (INR 3,570); target about 55% | |
| D12 | Organic + WhatsApp + referral + B2B orders in 16 weeks | 21 | 35 | 46 | ASSUMPTION | Breakdown in 07 section 3. This is the number that is least evidenced and most sensitive | |
| D13 | Creator cost | nano barter + INR 0-3,000; nano cash INR 3,000-8,000; micro INR 10,000-25,000 | | | ESTIMATE | [../social/05-growth-plan.md](../social/05-growth-plan.md) 5.7 (upgrowth.in, dazzlerr.com) | |
| D14 | Designer/architect trade commission or trade rate | 6% commission after delivery + 10% trade discount on the coupon (not both on the same SKU unless margin allows, see 05) | | | ASSUMPTION | 8-12% is the range in 05-growth-plan.md | |
| D15 | Followers by week 16 (secondary KPI) | 2,000 | 4,000 | 6,000 | ASSUMPTION | playbook 3-7K by week 12 is itself unproven | |

## E. Margin floors (the guardrails used everywhere)

| ID | Rule | Default | Tag | Owner's real value |
|---|---|---|---|---|
| E1 | Contribution before CAC (net of GST, coupon, freight, gateway, RTO, damage, warranty) | at least 25% of net revenue | OWNER-SET | |
| E2 | Contribution after blended CAC (40% paid at the SKU's paid CAC, 60% organic at INR 500) | at least 10% of net revenue | OWNER-SET | |
| E3 | **"Do not go below" price** for a SKU or combo | the lower of the prices that satisfy E1 and E2, rounded up to the next INR 50 (computed in 03 and 04) | derived | |
| E4 | Total discount stack (combo + coupon + manual concession) | never lets price fall below E3 | OWNER-SET | |
| E5 | Overhead cushion needed after CAC | 10-15 points | ASSUMPTION ([../unit-economics-model.md](../unit-economics-model.md) section 2) | |

## F. Calendar inputs

| ID | Input | Default | Tag | Owner's real value |
|---|---|---|---|---|
| F1 | Navratri | Sun 11 Oct 2026 | given by the owner brief | |
| F2 | Dhanteras | Fri 6 Nov 2026 | given | |
| F3 | Diwali | Sun 8 Nov 2026 | given | |
| F4 | Wedding season restarts | after 20 Nov 2026 | given | |
| F5 | Launch gate closes (paid ads may start) | Fri 16 Oct 2026 (end of week 3) | ASSUMPTION - depends on photography and P0 fixes | |
| F6 | Plan start | Mon 28 Sep 2026 (week 1) | our convention | |

## G. Decisions only you can make (also in the master plan's decision log)

Advance %, COD rule, warranty wording, cancellation and change-order terms ([08](08-customisation-offer.md)); which SKUs you will really make at these prices; ready-stock cash for Diwali (A9); whether to keep or deactivate seed coupons WELCOME10 / FREESHIP / HANDMADE500 ([05](05-coupon-strategy.md)); Rs budget scenario ([07](07-channel-mix-and-budget.md)).
