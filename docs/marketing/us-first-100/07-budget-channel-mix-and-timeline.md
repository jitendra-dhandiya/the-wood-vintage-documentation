# US 7. Budget and channel mix in USD, funnel math, timeline to 100 orders, cash flow

Part of [../us-first-100-orders-plan.md](../us-first-100-orders-plan.md). Date: 2026-09-25 (Fri; week 1 starts Mon 28 Sep 2026). Every conversion rate, cost per click and order count is an **ASSUMPTION or ESTIMATE** (inputs in [01](01-owner-input-sheet.md) sections C-F); ranges are labelled **low (bad) / base / high (good)**. The model is a Python script whose arithmetic is reproduced in the tables (formulas of the logistics doc, section 6); change an input and redo the row. No number here is a forecast of the owner's real sales.

## 1. Answer in ten lines
1. **Recommended: Scenario B "Base".** It is the only scenario that reaches 100 orders around **the week of 29 Mar 2027** (range 1 Mar to Aug 2027) without needing more cash than the owner can plausibly commit (peak about USD 18,800) and without exceeding workshop capacity.
2. **The binding constraint is stock arrival, not ad money:** first stock lands about **18 Jan 2027** (sea, LCL). Before that only made-to-order pre-orders (8 in the base case) are possible. Growth spending brings 100 orders forward by only about four weeks.
3. **Diwali 2026 (8 Nov) and Christmas 2026 are not served.** A Christmas air-freight pilot is evaluated in section 6 and **not recommended**.
4. **Cash:** about USD 10,500 of goods, freight and duty plus about USD 6,000 of set-up and marketing must be out before the first stock lands (about USD 17,000 cumulative by January 2027); the low point is about **-USD 18,800 in February 2027**, recovering to positive by April as sales and payouts arrive.
5. **Economics of the first 100:** average order about **USD 488**, contribution before acquisition cost about **USD 173** (35%), all-in acquisition and set-up about USD 15,200 (USD 152 an order) => the first 100 orders **just about pay for themselves** (about +USD 2,000), and the business is cash-negative by design because of inventory and payout lag.
6. **Break-even cost per order USD 173; kill line USD 147; scale target USD 86.** Blended base cost per order across all channels about USD 52 for paid media, USD 108 including creators, content and samples.
7. **Channel mix (base, steady state):** community/referral 30%, Etsy 20%, Amazon 18%, Meta paid 15%, Pinterest 7%, B2B 6%, other 4%.
8. **Weekly orders at steady state:** lean 5, base 12, growth 20 (low 3.5 / high 22 for base).
9. **The first USD 1,500 of paid social is a test**: USD 1,000 of Meta spend buys anywhere from 1 to 23 orders depending on the funnel (section 3).
10. Container 2 is booked at **order 25**, so stock lands about when container 1 runs out (around order 90); heroes may still stock out for 2-6 weeks and are then sold as made to order.

## 2. What one order is worth (the yardstick for every acquisition decision)

Order mix used for the plan (ASSUMPTION; per 100 orders): singles - mandir 2.5 ft 12, compact mandir 10, mirror 10, jaali 6, coffee table 8, side table 5, console 3, bench 2, bookshelf 2, pooja stool 3, kitchen set 7 (68); combos - C1 8, C2 4, C3 2, C4 6, C5 6, C6 2 (28); made-to-order custom pieces 4 (USD 1,050 average, contribution ASSUMED at 45% of price before acquisition cost). Units drawn from stock: 130, versus 118 in container 1.

| Measure | Value | How |
|---|---|---|
| Revenue for 100 orders | about USD 48,750 | Singles and combos at list and combo prices, custom at 1,050 |
| **Average order value** | **USD 488** | |
| Promotions and coupons | 4% of revenue (USD 1,950) | [05](05-coupons-and-promotions.md) |
| Landed delivered cost of goods | USD 23,680 | [03](03-starter-catalogue.md) |
| Damage/replacement allowance 7% of landed | USD 1,660 | [01](01-owner-input-sheet.md) F1 |
| Payment/platform fees (5.5% own-site basis; Etsy +9 points and Amazon referral +6.5 points on their shares of orders) | about USD 4,130 | |
| **Contribution before acquisition cost (CM1)** | **about USD 17,300 = USD 173 an order (35.5%)** | |
| **Break-even cost per order** | USD 173 | CM1 = the most we can spend on one order |
| **Kill line** (85% of CM1) | USD 147 | above it, stop the channel |
| **Scale target** (50% of CM1) | USD 86 | ROAS about 5.7 |
| Break-even ROAS | 2.8 | 488 / 173 |
| Cost per order, base funnel: paid Meta | about USD 167 | [section 3](#3-funnel-math-by-channel-lowbasehigh) |

## 3. Funnel math by channel (low / base / high; ESTIMATE, ASSUMPTION inputs)

**Cost per paid Meta order** = CPM / 1,000 / link CTR / click-to-order rate. Inputs: CPM low 22 / base 16 / high 11.6 (Q4 +15-40%, BFCM up to 2x; USD 14.19 median, USD 11.62 average, makometrics.com and digitalapplied.com 2026, ESTIMATE); CTR 0.8 / 1.2 / 1.8%; click-to-order 0.3 / 0.8 / 1.5% (furniture average 1.3-1.4%; we discount for a new cross-border brand with no reviews).

| Channel | Mechanism | Base weekly spend | Cost per order low / base / high | Orders per USD 1,000 low / base / high | Steady-state orders per week low / base / high |
|---|---|---|---|---|---|
| Meta paid (Instagram + Facebook) to WhatsApp/quote, Etsy and Amazon links | as above | 300 | 917 / 167 / 43 | 1.1 / 6.0 / 23 | 0.3 / 1.8 / 6 |
| Pinterest (organic pins plus paid) | CPC 0.80 / 0.65 / 0.50, click-to-order 0.2 / 0.5 / 1.0% (trackbee.ai, stackmatix.com 2026, ESTIMATE) | 105 | 400 / 130 / 50 | 2.5 / 7.7 / 20 | 0.2 / 0.8 / 1.5 |
| Amazon FBA (organic + Sponsored Products), from about 1 Feb 2027 | ACoS 35 / 20 / 12% of about USD 420 | 185 | 147 / 84 / 50 | | 0.5 / 2.2 / 3.5 |
| Etsy (search, Etsy Ads, Instagram to Etsy) | 20 listings; Ads USD 5 a day; fees 14.5% are separate | 35 | 70 / 15 / 8 | | 0.5 / 2.4 / 4 |
| Community, WhatsApp, temples, Facebook groups, referral (owner's US network, input E9) | credit USD 40 give/get on a share of orders | about 0 cash (about USD 10 an order in referral credits) | | | 1 / 3.6 / 5.5 |
| B2B (designers, stagers, hosts, studios) | 30 messages + trade programme | 0 | | | 0.5 / 0.7 / 1 |
| Google (free Merchant listings, own-site quote) | after Gate C | 0 | | | 0.5 / 0.5 / 0.5 |
| **Total** | | **about 625** | blended paid about 52 | | **3.5 / 12 / 22** |

Reading: **the range is the message.** A bad Meta funnel spends USD 917 per order (the campaign is a loss and must be stopped at USD 40-60 per ad set); a good one costs USD 43. The plan therefore spends **USD 300 a week, not more, until 8 orders prove the base rate.** Community and referral (input E8/E9) is the least evidenced number and the cheapest source: if the owner's real US network is small, orders per week fall towards the low column.

### Scenario weekly figures (steady state, after a six-week ramp from landing)
| Scenario | Channel split of the base case (orders per week) | Weekly paid spend |
|---|---|---|
| A Lean | community 2.0, Etsy 1.2, Amazon 0.6, Meta 0.5, Pinterest 0.3, B2B 0.3, other 0.1 = 5.0 | about 215 |
| B Base | community 3.6, Etsy 2.4, Amazon 2.2, Meta 1.8, Pinterest 0.8, B2B 0.7, other 0.5 = 12.0 | about 625 |
| C Growth | community 5.0, Etsy 4.0, Amazon 4.0, Meta 3.5, Pinterest 1.5, B2B 1.5, other 0.5 = 20.0 | about 1,310 |

## 4. Three scenarios (totals through the 100th order, base case)

| Line (USD) | **A. Lean** | **B. Base (recommended)** | **C. Growth** |
|---|---|---|---|
| First container | 5.4 CBM, 61 units (7 SKUs' core) | **11.2 CBM, 118 units (11 SKUs)** | 14.8 CBM, 154 units |
| Inventory: production + freight + customs + duty + bond/broker/insurance | 5,600 | **10,500** | 13,500 |
| Paid media (Meta, Pinterest, Amazon Ads, Etsy Ads) through the 100th order | 4,400 | **5,850** | 6,400 |
| Creators and seeding (cash fees; product cost extra) | 0 (barter only) | **1,500** | 4,000 |
| Content: photography, video, US lifestyle shoot | 500 | **1,450** | 2,950 |
| Samples (DHL Express to creators/designers; about USD 150 each incl. admin) | 400 | **900** | 900 |
| Tools, Amazon Professional plan, Etsy fees | 540 | **1,090** | 1,090 |
| Legal, insurance, trademark, CPA (one-off, [02](02-launch-readiness-gate.md)) | 2,400 | **4,400** | 5,900 |
| Air seed batch (Christmas pilot, optional) | - | - | 2,500 |
| **Total spend before per-order shipping** | **about 13,800** | **about 25,700** | **about 37,250** |
| Steady-state orders per week (base case) | 5 | **12** | 20 (exceeds default capacity of about 16 units a week, input A2) |
| **100th order** (base / low / high funnel) | week of 14 Jun 2027 / Jan 2028 / 19 Apr 2027 | **week of 29 Mar 2027 / Aug 2027 / 1 Mar 2027** | week of 1 Mar 2027 / 10 May 2027 / 22 Feb 2027 |
| **Peak cash needed (cumulative low, including container 2 booked at order 25 and 30 in lean)** | **about 8,900 (Jan 2027)** | **about 18,800 (Feb 2027)** | **about 32,800 (Feb 2027)** |
| Marketing and set-up cost per order (excluding goods and per-order shipping) | about 82 | **about 152** | about 237 |

Notes: per-order last mile, pick/pack and allowances (about USD 133 an order, USD 13,300-14,600 for 100 orders) are paid when orders ship and are already inside the "landed" cost used for margins; they are shown in the cash flow, not double counted in the table above. Lean's cost per order looks low only because it takes about 38 weeks; **the Lean scenario also pays a higher per-CBM freight rate for a 5.4 CBM lot (not modelled)**. **Growth is not recommended** for the first 100 orders: the cost per order is higher, the stock lands on the same day, and the workshop would be stretched.

Why Base and not Lean: Lean reaches 100 orders about eleven weeks later, misses the spring window (Mother's Day, weddings, Ugadi), and leaves the brand with very little review history when Amazon promotions matter. **If the owner cannot commit USD 17-19k, run Lean and accept June 2027.**

## 5. Timeline to 100 orders (base scenario) and the Q1 2027 window

### 5.1 Critical path
| Week (Mon date) | Milestone |
|---|---|
| W1 (28 Sep) - W2 (5 Oct) | Owner decisions: cost sheet, species (mango), cash; forwarder/3PL/broker quotes; Etsy shop application; Amazon documents; trademark knockout search |
| W2 (9 Oct) | **Gate 0 closes; production order placed** |
| W3 (12 Oct) - W6 (2 Nov) | Production of 118 units (4 weeks); Jodhpur photo/video days; Amazon seller account, Etsy shop live with made-to-order listings (target 20 Nov) |
| W7 (9 Nov) | **Container closed and handed to the forwarder (Gate A)**; ISF filed; Diwali (8 Nov) passes |
| W8-W13 (16 Nov - 27 Dec) | Ocean transit (28-42 days port to port); pre-orders (made to order, dated) accumulate; Pinterest boards and Instagram content build the list; Thanksgiving/BFCM (27 and 30 Nov) and Christmas pass without stock |
| W14-W16 (28 Dec - 17 Jan) | US port, customs entry (broker), duty paid, delivery to the 3PL |
| **W17 (18 Jan 2027)** | **Stock received at the 3PL; sales open; first FBA shipment (30 units, 3 SKUs) prepared** |
| W19 (1 Feb) | Amazon check-in (about 1-2 weeks, ASSUMPTION), Amazon listings live; launch coupon |
| W19-W22 | Order ramp (6 weeks): 4, 6, 8, 10, 12/week |
| **W20 (8 Feb, about order 25)** | **Book container 2** (production Feb-Mar, ship about 5 Mar, lands early to mid May) |
| W22 (22 Feb) | Checkpoint 1: at least 45 orders (base: 50) |
| W26 (22 Mar, Holi) | Checkpoint 2: at least 74 orders (base: 98) |
| **W27 (29 Mar-4 Apr)** | **100th order** (Easter Sunday is 28 Mar 2027) |

### 5.2 Weekly base orders (cumulative), ESTIMATE
Pre-landing made-to-order orders: about 0.8 a week from W7 (8 by W16). Then: W17 2, W18 4, W19 6, W20 8, W21 10, W22 12 and 12 a week after. Cumulative: W16 8, W17 10, W18 14, W19 20, W20 28, W21 38, W22 50, W23 62, W24 74, W25 86, W26 98, W27 110. (If the owner's community is weak, use the low column: 100 orders in August 2027.)

### 5.3 What the "first sales window" really is
- **Before landing (W7-W16):** made-to-order and pre-orders with a stated ship date (Etsy, quote form, WhatsApp) at the price and deposit in [08](08-customisation-offer.md). These are worth having (deposits, reviews-to-be, list building) but small: 8 in the base case.
- **After landing:** 18 Jan to end of March is the base window: housewarming and wedding season, Ugadi (about 7 Apr), Mother's Day (9 May). Nothing here depends on Diwali.
- **Diwali 2027 (Friday 29 Oct 2027)** is the first festival we can properly serve: container 3 must leave Jodhpur by about 1 Aug 2027.

## 6. The Christmas 2026 air-freight pilot: evaluated honestly (recommendation: no)
| Question | Answer |
|---|---|
| What would go by air? | Only light SKUs: about 12 mirrors and 12 jaali panels (about 210 kg; chargeable weight higher for the flat cartons) at USD 6/kg door to 3PL (ASSUMPTION) |
| Timing | Production 12 Oct-6 Nov, depart about 9 Nov, land about 7-14 Dec (4-5 weeks), 3PL receiving 2-3 days, ground 3-7 days: **last realistic Christmas order date about 14-16 Dec**, so the selling window is about one week |
| Prerequisites that must be closed by mid-November | Etsy shop and listings live (target 20 Nov), a 3PL contract, broker and bond, policies, trademark, photos: all of Gate A and B in five weeks; **Amazon FBA check-in in Q4 is too slow** |
| Economics (logistics doc table 6, our arithmetic) | Air landed cost mirror USD 161, jaali USD 138 versus list 279 and 219: margin about 15% and 9% before acquisition cost; a full sell-out of 24 units gives about USD 700 of profit after CAC on USD 2,300 of cash at risk (USD 2,500 in the Growth column) |
| Demand | New shop, 0 reviews, 0 followers, one week: **3-8 orders would be a good result (ASSUMPTION)** |
| Value | 3-8 reviews and real customer photos before January |
| **Verdict** | **Do not do it as a commercial pilot.** If the owner still wants early reviews: a **seed batch of at most USD 1,500** (6-8 pieces by DHL Express DDP as samples to five creators and five friendly Indian-American families) is cheaper, needs no 3PL and produces content and reviews without a selling deadline |
| Sea for Christmas? | Impossible: goods would have to leave Jodhpur by about 20 Oct and the gates are not closed |

## 7. Cash-flow table, base scenario (USD, ESTIMATE; container 2 booked at order 25; payout lag 2 weeks)

| Month | Production | Freight, customs, duty, bond, insurance | Set-up (legal, content, samples, tools) | Ads and creators | Per-order shipping and allowances | **Cash in (net of fees and promos)** | Net | **Cumulative** |
|---|---|---|---|---|---|---|---|---|
| Oct 2026 | 5,320 | 0 | 2,050 | 0 | 0 | 0 | -7,370 | **-7,370** |
| Nov 2026 | 0 | 2,600 | 2,890 | 180 | 425 | 680 | -5,410 | -12,780 |
| Dec 2026 | 0 | 0 | 1,000 | 240 | 425 | 1,370 | -300 | -13,080 |
| Jan 2027 | 0 | 2,580 | 1,200 | 430 | 1,010 | 1,370 | -3,850 | -16,930 |
| **Feb 2027** | 2,660 (container 2) | 0 | 100 | 2,875 | 4,780 | 8,540 | -1,880 | **-18,810 (low point)** |
| Mar 2027 | 2,660 | 2,250 | 200 | 3,625 | 7,970 | 24,770 | +8,060 | -10,750 |
| Apr 2027 | 0 | 2,510 | 100 | 1,250 | 3,190 | 20,500 | +13,450 | +2,700 |
Read: containers 1 and 2 plus set-up are financed from savings until about April 2027; **Amazon and Etsy payouts lag** (Amazon about every 14 days plus reserve; Etsy via Payoneer), so a 2-4 week additional buffer of about USD 2,000-3,000 is prudent (ASSUMPTION). The table stops at the 100th order; container 2's US-side costs (about USD 2,500) and later orders fall after it. **Without container 2 the cumulative low is about -USD 16,900 in January 2027.** Recommended committed cash: **USD 20,000** (base).

## 8. When to stop and when to scale (rules to write into the weekly review)
| Signal | Rule |
|---|---|
| Any Meta ad set | Kill after **USD 40 of spend with no lead**; kill an ad set with cost per order above **USD 147** after 8 orders |
| Meta/Pinterest in aggregate | Base spend continues while blended paid cost per order is below USD 147; **scale +25% only if the 4-week cost per order is at or below USD 86 and stock cover is at least 6 weeks** |
| Amazon Sponsored Products | Pause a keyword at 100 clicks with no order; cut ACoS above 35% after 4 weeks; raise bids only at ACoS below 15% |
| Etsy Ads | Continue only on listings with a favourite-to-order rate above about 3% and 20+ views a day |
| Stock | **Book container 2 at order 25**, or earlier when any hero has less than 6 weeks of stock cover; do not book if the last four weeks averaged fewer than 3 orders |
| Damage and quality | If claims exceed **10% of orders in any month**, stop selling the affected SKU until packing is redesigned |
| Checkpoints | **W22: fewer than 25 orders => switch to the Lean run-rate** (paid media to USD 215/week, no container 2 until 40 orders); W26: fewer than 45 => stop all paid social, keep Amazon/Etsy/community |
| Response SLA | If first replies exceed the SLA on 3 days in a week, pause new ad spend (the funnel is leaking) |
| Owner hard stop | If cumulative cash reaches -USD 22,000 before 60 orders, pause container 2 and paid media |
