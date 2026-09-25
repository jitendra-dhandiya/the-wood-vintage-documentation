# US 1. Owner input sheet (USD) - every number the US plan depends on

Part of [../us-first-100-orders-plan.md](../us-first-100-orders-plan.md). Date: 2026-09-25. Supersedes the India input sheet [../first-100/01-owner-input-sheet.md](../first-100/01-owner-input-sheet.md) for the export business.

**How to use.** Every value in "Default" is a placeholder so the plan can be computed; it is not a fact about your business. Write your real value in the last column; where a cell is blank the default stays. All money is **USD** unless the unit says INR; INR to USD = **88** (input C1). Tags: **VERIFIED** (source read 2026-09-25), **ESTIMATE** (third-party figure or our arithmetic on a verified base), **ASSUMPTION** (our placeholder), **OWNER-SET** (a choice). Priority: **P0** = the plan cannot be trusted without it; **P1** = needed before spending on ads; **P2** = refine after 20 orders. The arithmetic that turns these inputs into prices, margins and cash is in [03](03-starter-catalogue.md) and [07](07-budget-channel-mix-and-timeline.md).

## A. Capacity and time

| ID | Input | Unit | Default | Tag | Basis | Pri | Owner's value |
|---|---|---|---|---|---|---|---|
| A1 | Units the carpenter team can finish for the first container (about 118 units, 11 CBM) | units in 4 weeks | 118 | ASSUMPTION | No workshop data; equals 12 mandirs/week-equivalents of mixed work | P0 | |
| A2 | Steady monthly capacity after the first batch (all SKUs) | units/month | 70 | ASSUMPTION | Base scenario peaks at about 12 orders (about 16 units) a week | P0 | |
| A3 | Production lead time for a ready-stock batch | weeks | 4 | ASSUMPTION | Logistics doc: 3-4 weeks | P0 | |
| A4 | Made-to-order piece (single custom item, not batched) | weeks to pack-ready | 4-5 | ASSUMPTION | Used for the "10-12 weeks" promise in [08](08-customisation-offer.md) | P0 | |
| A5 | Jodhpur to Mundra/Nhava Sheva, consolidation, ocean, US devanning, 3PL receiving (LCL) | weeks door to shelf | 9 (range 7-12) | ESTIMATE | Logistics doc section 4 (7-10 days road/rail + 4-6 weeks ocean + 5-10 days US + 2-3 days receiving); peak-season congestion not modelled | P0 | |
| A6 | Air freight door to US 3PL (samples, seed batch, premium made-to-order) | weeks | 4-5 | ESTIMATE | Logistics doc route b-air | P1 | |
| A7 | Workshop closed dates (festivals, weddings, family) | dates | none | - | | P1 | |

## B. Cost sheet per SKU (replace every row with the workshop's real cost)

Ex-factory = timber + labour + carving + finish + hardware, **in the wood you will actually use** (default costs are at sheesham INR 1,500/cft; mango may be cheaper: enter the real figure). Pack = export carton, corner protectors, foam, desiccant, ISPM-15-stamped pallet share. Packed size assumes **knock-down (legs off, hardware bagged)**.

| SKU | Ex-factory INR | Pack INR | Gross kg | Packed cm (L x W x H) | Packed CBM | Duty % (MFN + Section 301) | Wood (default) | Tag | Owner's real values |
|---|---|---|---|---|---|---|---|---|---|
| S1 Carved mandir 2.5 ft | 6,820 | 700 | 32 | 80 x 55 x 45 | 0.198 | 10.0 | Mango | ASSUMPTION | |
| S2 Compact mandir 2 ft (NEW) | 4,100 | 450 | 16 | 60 x 45 x 40 | 0.108 | 10.0 | Mango | ASSUMPTION (scaled at 60% of S1) | |
| S3 Carved mirror 60 x 90 | 2,025 | 350 | 8.5 | 100 x 70 x 10 | 0.070 | 13.9 | Sheesham or mango | ASSUMPTION (HTS 7009.92 3.9% unverified) | |
| S4 Jaali wall panel 60 x 90 | 2,330 | 300 | 9 | 95 x 65 x 8 | 0.049 | 13.2 | Sheesham or mango | ASSUMPTION | |
| S5 Coffee table 90 x 50 (KD) | 4,700 | 450 | 26 | 95 x 55 x 22 | 0.115 | 10.0 | Mango | ASSUMPTION | |
| S6 Side table (KD) | 2,760 | 350 | 15 | 60 x 45 x 32 | 0.086 | 10.0 | Mango | ASSUMPTION | |
| S7 Console 120 (KD) | 6,500 | 550 | 30 | 118 x 42 x 28 | 0.139 | 10.0 | Mango | ASSUMPTION | |
| S8 Bench 120 (KD) | 4,700 | 450 | 22 | 118 x 42 x 20 | 0.099 | 10.0 | Mango | ASSUMPTION | |
| S9 Bookshelf 5-tier 185 cm | 7,200 | 600 | 38 | 185 x 40 x 25 | 0.185 | 10.0 (broker: may be argued as cabinet, Section 232 25%) | Mango | ASSUMPTION | |
| S10 Carved pooja stool | 1,650 | 200 | 6 | 45 x 35 x 35 | 0.055 | 10.0 | Mango | ASSUMPTION | |
| S11 Kitchen gift set (tray + board + spoon) | 1,100 | 120 | 3.5 | 40 x 30 x 12 | 0.014 | 15.0 | Mango/acacia | ASSUMPTION (food-contact finish declaration needed) | |

Source of the ten non-new rows: [../export-b2c-logistics-and-landed-cost.md](../export-b2c-logistics-and-landed-cost.md) table 1 (which derived them from the India unit-economics model). S2 is new (2 ft compact mandir for apartments; entry price against Urli Utsav and The Mandir Store) and is our scaling, not a workshop cost. **P0: replace all rows; the coffee table's margin moves about 3 points for every 10% change in the INR cost.**

## C. Freight, customs, warehouse

| ID | Input | Unit | Default | Tag | Basis | Pri | Owner's value |
|---|---|---|---|---|---|---|---|
| C1 | FX | INR per USD | 88 | ASSUMPTION | | P0 | |
| C2 | LCL all-in, Jodhpur/ICD to a US 3PL door (origin CFS + ocean + US devanning + inland delivery) | USD per CBM | 260 (range 200-400) | ASSUMPTION | Market quotes USD 70-150 base "often landing at USD 140-200 all-in" (Suaid Global 2026); DHL Global Forwarding rate not published | P0 | |
| C3 | Customs admin (broker, ISF, MPF, HMF, bond share) | USD per CBM | 40 | ASSUMPTION | Logistics doc section 4 | P0 | |
| C4 | Size of first container | CBM | 11.2 (5.4 lean, 14.8 growth) | OWNER-SET | [03](03-starter-catalogue.md) | P0 | |
| C5 | Container 2 trigger | orders sold | order 25 | OWNER-SET | Sells 118 units in about 8 weeks at base pace; lead time 9 weeks | P0 | |
| C6 | FCL 20 ft switch point | CBM per lot | 12-15 | ESTIMATE | Logistics doc | P2 | |
| C7 | Air freight door to 3PL | USD per kg | 6 | ASSUMPTION | | P1 | |
| C8 | DHL Express account discount versus rack (samples, replacement parts only) | % of rack | 50 | ESTIMATE | Reseller rates 45-55% of rack | P1 | |
| C9 | DHL Global Forwarding written quote (LCL per CBM, FCL 20 ft, air per kg, transit) and a second forwarder | USD | not yet obtained | gap | | **P0** | |
| C10 | Customs broker per entry | USD | 250 (range 100-800) | ESTIMATE | broker guides 2026 | P0 | |
| C11 | Continuous bond (annual) or single-entry bond | USD | 400-800 / 75-275 per entry | ESTIMATE | [../../countries/us-legal/03-us-import-mechanics.md](../../countries/us-legal/03-us-import-mechanics.md) | P0 | |
| C12 | ISF filing | USD | 50 | ESTIMATE | | P0 | |
| C13 | Ocean cargo insurance | % of invoice | 0.4 | ASSUMPTION | | P1 | |
| C14 | Customs value of own-stock imports (transfer price) | x ex-factory cost | 1.25 | ASSUMPTION | Broker/customs counsel must set; if CBP rejects, add about USD 25-40 duty per hero unit | P0 | |
| C15 | 3PL storage | USD per CBM per month | 18 (about USD 15-25 per pallet-equivalent) | ASSUMPTION | survey USD 8-25 per pallet | P0 | |
| C16 | 3PL receiving + onboarding | USD | 2 per unit; 250 once | ASSUMPTION | | P1 | |
| C17 | 3PL pick and pack | USD per order | 4 (under 10 kg) / 8 | ASSUMPTION | survey USD 2-3.20 for standard parcels; bulky higher | P0 | |
| C18 | Ground last mile | function | (0.55 x (13 + 1.6 x billable lb) + 6.5) x 1.255, +25 additional handling if a side is over 48 in, second side over 30 in, volume over 10,368 cu in or weight over 50 lb | ESTIMATE (fitted to two published UPS Ground points; 45% contract discount assumed) | Logistics doc section 6 | **P0** | |
| C19 | Amazon FBA fulfilment fee per unit | USD | S1 58, S2 40, S3 24, S4 22, S5 52, S6 28, S7 54, S8 36, S9 68, S10 22, S11 9 | **ASSUMPTION** | Only "large bulky from about USD 9.35 plus per-pound charge, dimensional weight = cu in / 139" is sourced; run the Seller Central revenue calculator per ASIN | **P0** | |
| C20 | Amazon FBA storage | USD per cu ft per month | 0.56 (Jan-Sep), 1.40 (Oct-Dec) | ESTIMATE (search summary) | | P1 | |
| C21 | 3PL to FBA inbound (LTL pallets, prep, labels) | USD per unit | 6 | ASSUMPTION | | P1 | |

## D. Marketplace, payment and platform fees

| ID | Input | Default | Tag | Basis | Owner's value |
|---|---|---|---|---|---|
| D1 | Amazon referral fee, furniture | 15% up to USD 200 of price, 10% above (effective 12.2% at USD 459) | VERIFIED (sell.amazon.com/pricing, via [../../countries/us.md](../../countries/us.md); repeated in 2026 fee sheets) | | |
| D2 | Amazon Professional plan | USD 39.99 per month | VERIFIED | | |
| D3 | Amazon Overmax surcharge (extra-large over 96 in longest side) | USD 17-25 per unit from 15 Jan 2026; none of our cartons (longest 185 cm = 73 in) | ESTIMATE (amzprep.com/amazon-fba-fees) | | |
| D4 | Amazon coupon fee, Lightning/Best Deal fees | USD 500 (Prime Exclusive Lightning Deal), USD 1,000 (Best Deal) in 2026; coupon per-redemption fee not confirmed | ESTIMATE (estorefactory.com 2026-03-24) | | |
| D5 | Etsy: listing USD 0.20; transaction 6.5%; payment processing 5% + INR 25 (India); currency conversion 2.5% if shop currency differs from payout; Offsite Ads 15% (12% and mandatory above USD 10k trailing 12-month revenue) | modelled as 14.5% all-in plus USD 0.50 per order | VERIFIED via help.etsy.com/Craftybase summary (see [../../countries/us.md](../../countries/us.md)); the 14.5% blend is ours | | |
| D6 | Own-site card fee | 5.5% modelled (Stripe India invite-only 4.3% + 2% conversion = 6.3%; PayPal similar; Razorpay International about 3% unverified) | ESTIMATE | | |
| D7 | Payment route for the own site | not chosen | OWNER-SET | Stripe invite / PayPal / Razorpay International | |
| D8 | Etsy payouts via Payoneer; Amazon disbursement | Payoneer fee/withdrawal not modelled; Amazon pays about every 14 days | ESTIMATE | | |

## E. Demand and marketing (all ASSUMPTION unless tagged; ranges are low / base / high)

| ID | Input | Low (bad) | Base | High (good) | Tag | Basis | Pri | Owner's value |
|---|---|---|---|---|---|---|---|---|
| E1 | Meta CPM, US | 22 (Q4 +15-40%, BFCM up to 2x) | 16 | 11.6 | ESTIMATE | makometrics.com (USD 11.62 average, USD 1.14 CPC), digitalapplied.com (median CPM 14.19; USD 0.60 CPC traffic, USD 1.80 lead), 2026-09-25 | P1 | |
| E2 | Meta link click-through rate | 0.8% | 1.2% | 1.8% | ASSUMPTION | Home decor page CTR 2.92% (lebesgue.io, all clicks); link CTR is lower | P1 | |
| E3 | Click to order rate (cold traffic, new brand, no reviews) | 0.3% | 0.8% | 1.5% | ASSUMPTION | Furniture average 1.3-1.4%, 3.8% on paid Facebook (Lebesgue/Mako, ESTIMATE); we cut it for a new cross-border brand | **P0** | |
| E4 | Resulting cost per paid Meta order | about 917 | about 167 | about 43 | ESTIMATE | = CPM / 1000 / CTR / conversion | | |
| E5 | Pinterest CPC (home decor); click to order | CPC 0.80 / 0.2% | 0.65 / 0.5% | 0.50 / 1.0% | ESTIMATE | trackbee.ai, stackmatix.com 2026 (CPC USD 0.50-0.80; CPM USD 2-5; 21-30 day purchase window) | P1 | |
| E6 | Amazon ad cost of sales (ACoS) on a new listing | 35% | 20% | 12% | ASSUMPTION | | P1 | |
| E7 | Etsy organic orders per week at steady state (20 listings, 0 history at start) | 0.5 | 2.4 | 5 | ASSUMPTION | | P1 | |
| E8 | Community/referral orders per week (owner's US network, temples, WhatsApp, Facebook groups) | 1 | 3.6 | 8 | ASSUMPTION | **the least-evidenced number; needs the owner's real US contacts (E9)** | **P0** | |
| E9 | Owner's real US reach: number of personal contacts in the US who could buy or refer, temple/community group memberships | not known | | | - | | **P0** | |
| E10 | Creator fees | nano (1k-10k): USD 25-150 static, 50-300 Reel; micro (10k-100k): USD 150-1,500 static, 250-2,500 Reel | ESTIMATE | influencermarketinghub.com, influee.co 2026 | P1 | |
| E11 | Steady-state orders per week (all channels) | 3.5 | 12 | 22 | ESTIMATE | sum of the channel rows in [07](07-budget-channel-mix-and-timeline.md) | | |

## F. Returns, damage, allowances

| ID | Input | Default | Tag | Basis | Owner's value |
|---|---|---|---|---|---|
| F1 | Damage/replacement/refund allowance | 7% of landed cost | ASSUMPTION | Furniture damage 5-10% (industry blog) | |
| F2 | Effective return rate of stock orders | 3-4% (policy: damage = fix; stock return at buyer's cost + 15% restocking) | ASSUMPTION | Industry furniture returns 19-23% (ClaimLane/Eightx, ESTIMATE): our policy is deliberately harsher | |
| F3 | Repair parts kept in the US 3PL (spare drawers/legs/hardware kits) | 5% of units | ASSUMPTION | | |
| F4 | Chargeback rate | 0.5% | ASSUMPTION | | |

## G. Money and policy choices

| ID | Input | Default | Tag | Owner's value | Pri |
|---|---|---|---|---|---|
| G1 | **Cash you can put in before the first sale (all-in)** | need USD 17,000 (base), 9,000 (lean), 25,000+ (growth) | model output | | **P0** |
| G2 | Maximum cash at risk in container 1 (production + freight + duty + set-up) | about USD 10,700 inventory and freight, about USD 6,000 set-up and marketing before stock lands | model output | | **P0** |
| G3 | Deposit on made-to-order pieces | 40% at order, 60% before shipping | OWNER-SET | | P0 |
| G4 | Cancellation window after the deposit | 48 hours free; after design approval: deposit forfeited to cover materials | OWNER-SET | | P0 |
| G5 | Coupon budget | at most 4% of revenue; single coupon 5%, capped | OWNER-SET | | P1 |
| G6 | One shelf price across Amazon, Etsy, own site (price parity) | yes | OWNER-SET | | P1 |
| G7 | Free delivery in the continental US; exclude AK, HI, PR at launch | yes | OWNER-SET | | P1 |
| G8 | Warranty | 12-month workmanship; repair-first ([08](08-customisation-offer.md)) | OWNER-SET | | P1 |
| G9 | Wood policy for container 1 | all mango/acacia (no Dalbergia) unless EPCH/CITES MA confirms in writing | OWNER-SET | | **P0** |

## H. People and time zones

| ID | Input | Default | Tag | Owner's value |
|---|---|---|---|---|
| H1 | Customer-service coverage (see [09](09-roadmap-and-operations.md)) | 2 people in two windows: IST 19:00-23:00 (= 08:30-12:30 US East / 05:30-09:30 US West in winter, the US morning) and IST 07:30-11:30 (= 21:00-01:00 US East / 18:00-22:00 US West the evening before). US evenings are when buyers browse and message. | ASSUMPTION | |
| H2 | First-reply SLA | 15 minutes inside the staffed window, next-morning by 09:00 IST otherwise, 24 hours on marketplaces (Amazon requires reply within 24 h) | ASSUMPTION | |
| H3 | A US-based helper (friend/relative/part-time) for photos, returns inspection, samples | none | gap | |
| H4 | Hours per week for content and community | 14 | ASSUMPTION | |

## I. Compliance costs (one-off, USD; ESTIMATE from [../../countries/us-legal/08-checklist-timeline-risks.md](../../countries/us-legal/08-checklist-timeline-risks.md))

| ID | Item | Default | Owner's value |
|---|---|---|---|
| I1 | Attorney-reviewed policy pack | 1,200 (500-2,500) | |
| I2 | Product liability insurance (USD 1M per occurrence) | 1,000 per year (500-2,500) | |
| I3 | USPTO trademark: knockout search + two classes (20 furniture, 35 retail) + US attorney | 1,700 (USD 350 per class + USD 500-1,500) | |
| I4 | Sales-tax/CPA setup (nexus tracker, registration when 3PL state chosen) | 500-1,000 | |
| I5 | Coating lead test per finish | 100-300 each (3 finishes) | |
| I6 | HTS classification by the broker | 0-500 | |
| I7 | Species/CITES written stance, EPCH membership | 1,000-10,000 INR | |

## What to fill first (order)
1. **C9 and B**: the DHL Global Forwarding quote and the real cost sheet (P0). 2. **G1/G9**: cash and the wood policy. 3. **E8/E9**: how many US people you can actually reach. 4. **C19**: the Amazon revenue calculator per SKU. Once these four are in, re-run [03](03-starter-catalogue.md); nothing else moves the plan as much.
