# US 3. Starter catalogue for the first LCL container (about 11 CBM, 118 units)

Part of [../us-first-100-orders-plan.md](../us-first-100-orders-plan.md). Date: 2026-09-25. Built on [../export-b2c-logistics-and-landed-cost.md](../export-b2c-logistics-and-landed-cost.md) (formulas reproduced exactly: our re-computation matches its tables 3 and 4 for the ten shared SKUs) and the comps in [../../competitor-research/us-b2c-price-benchmark.md](../../competitor-research/us-b2c-price-benchmark.md). **Every cost is an ASSUMPTION until the owner fills [01](01-owner-input-sheet.md) section B; all margins are model outputs.** Tags: VERIFIED / ESTIMATE / ASSUMPTION.

## 1. The eleven launch SKUs and the price ladder

Rule from the logistics doc, kept: one all-in price (free ground delivery, duties included), **at parity to about 8% under the median comparable US piece, never "30% cheaper"**, whole dollars (craft tier, as Urli Utsav and World Interiors), no compare-at price.

| SKU | US comp low - median - high (USD) | Our price | vs median | Tier / what carries the price |
|---|---|---|---|---|
| **S1 Carved mandir 2.5 ft** | 410 - 650 - 900 (Urli Utsav mango 410-570; Mandir Store 699-899; Mandir For Home 484-1,804; US-made custom 1,700+) | **599** | -8% | Solid carved wood between laminate units and US-made custom |
| **S2 Compact mandir 2 ft** (new) | 399 - 449 - 570 (Mandir Store 2 ft teak laminate 399; Urli mango 410-570) | **449** | 0% | Apartment entry piece; priced at, not under, because it is solid carved (comp is mostly laminate) |
| **S3 Carved mirror 60 x 90** | 104 - 300 - 1,172 (thin sample; Vintage Realm reclaimed 104-576; Urli 36 in mandala 320) | **279** | -7% | Photogenic; comp under-sampled at our size |
| **S4 Jaali wall panel 60 x 90** | 60 - 150 - 320 (ASSUMPTION; no US jaali panel found) | **219** | +46% | Premium carved only; **thin evidence, test on Etsy first** |
| **S5 Coffee table 90 x 50** | 217 - 500 - 1,399 (Wayfair Ahlanni 217-337; Timbergirl 449-600; World Interiors 824+) | **459** | -8% | Boutique tier, **not** Wayfair (we lose money below about USD 355) |
| **S6 Side table** | 149 - 330 - 685 | **309** | -6% | Sold single or as a pair ([04](04-combos.md)) |
| **S7 Console 120** | 345 - 600 - 1,734 | **559** | -7% | Entryway statement |
| **S8 Bench 120** | 200 - 400 - 978 | **369** | -8% | Thin if discounted: floor USD 292 |
| **S9 Bookshelf 5-tier 185 cm** | 633 - 800 - 1,609 (conservative low end) | **739** | -8% | Highest margin; classify with the broker (bookshelf vs cabinet, Section 232) |
| **S10 Carved pooja stool** | 138 - 180 - 530 (bajot/chowki 126-160 at Urli) | **189** | +5% | Add-on to a mandir; alone it is marginal |
| **S11 Kitchen gift set** (tray + board + spoon, personalised) | 25 - 60 - 180 (commodity 25-35; Etsy personalised 45-180) | **109** | +82% | Gift add-on only; shipping USD 12.95 if bought alone |

Evidence limits: Etsy, Amazon, Wayfair, Pottery Barn, CB2, Crate and Barrel and West Elm were blocked to our research tool (see the benchmark, section 1). **Owner/marketing: capture 10 Etsy and 10 Amazon listings per category with price, shipping and review count in a browser session before final prices** (FAST: re-check the week prices are set).

## 2. Margin at the defaults, per channel, and the price floors

Definitions (all USD): **landed delivered cost** = ex-factory + pack + 2 handling + LCL and customs admin (USD 300 per CBM) + duty (1.25 x cost x duty %) + 3PL (storage 3 months, receiving, pick) + ground last mile. **Own-site/quote path** contribution = price - 1.07 x landed - 5.5% payment fee - 0.30 - CAC allowance. **Etsy path** = same with 14.5% fees + 0.50. **Amazon FBA path** = price - 1.07 x (ex-factory + pack + 2 + LCL + duty + FBA storage 2 months + 6 inbound + FBA fee) - referral (15% up to 200, 10% above) - 15% ACoS - 1.5% disbursement. **Floor** = the lowest price that still leaves **10% contribution after the CAC allowance**; never discount below it. The CAC allowance is the logistics doc's (USD 15-70 by ticket), a blended figure across organic and paid: [07](07-budget-channel-mix-and-timeline.md) checks it against the budget.

| SKU | Price | Landed delivered | Own/quote contribution (after CAC) | Etsy | Amazon FBA | Floor own | Floor Etsy | Floor Amazon | **Promo headroom (lowest channel)** |
|---|---|---|---|---|---|---|---|---|---|
| S1 Mandir 2.5 ft | 599 | 316 | 157 (26%) | 103 (17%) | 185 (31%) | 484 | 542 | 402 | **10%** (Etsy) |
| S2 Compact mandir | 449 | 178 | 179 (40%) | 138 (31%) | 167 (37%) | 291 | 326 | 256 | 27% |
| S3 Mirror | 279 | 116 | 90 (32%) | 64 (23%) | 101 (36%) | 206 | 231 | 160 | 17% |
| S4 Jaali panel | 219 | 101 | 58 (27%) | 38 (17%) | 64 (29%) | 176 | 197 | 149 | 10% (Etsy) |
| S5 Coffee table | 459 | 224 | 134 (29%) | 92 (20%) | 151 (33%) | 355 | 398 | 294 | 13% (Etsy) |
| S6 Side table | 309 | 141 | 95 (31%) | 67 (22%) | 105 (34%) | 233 | 261 | 192 | 16% |
| S7 Console | 559 | 266 | 183 (33%) | 132 (24%) | 188 (34%) | 409 | 458 | 351 | 18% |
| S8 Bench | 369 | 184 | 102 (28%) | 69 (19%) | 108 (29%) | 292 | 327 | 258 | 11% (Etsy) |
| S9 Bookshelf | 739 | 312 | 294 (40%) | 228 (31%) | 278 (38%) | 478 | 535 | 418 | 28% |
| S10 Pooja stool | 189 | 95 | 47 (25%) | 29 (16%) | 52 (28%) | 156 | 175 | 132 | 7% (Etsy) |
| S11 Kitchen set | 109 | 55 | 29 (26%) | 19 (17%) | 34 (31%) | 88 | 99 | 70 | 9% (Etsy) |

Reading: **Etsy is the thinnest channel** (its 14.5% fee stack sits on top of our own last mile), **Amazon FBA is the best on paper only because the FBA fee column is a placeholder** (input C19); if the real FBA fee is 30-40% higher, Amazon and Etsy converge. **Promo headroom means a coupon or sale on that channel may not exceed this % without breaching the floor.** In practice: mandir, jaali, coffee table, bench, stool and kitchen set take at most 5-8% on Etsy.

**Stress case (last mile +30%, INR cost +20%, LCL USD 360 per CBM, all at once), own-site path, after CAC:** mandir 12%, compact mandir 29%, mirror 21%, jaali 15%, coffee table 16%, side table 19%, console 20%, bench 15%, bookshelf 28%, stool 11%, kitchen set 14%. **Nothing goes negative; the stool, mandir and kitchen set approach the floor.** The two inputs to firm up first: the ground last-mile rate (3PL quote for 20 sample cartons to five ZIP codes) and the ex-factory cost.

## 3. The first container: what to fill it with (11.2 CBM, 118 units)

Sized to the demand mix in [07](07-budget-channel-mix-and-timeline.md) section 2 (heroes first: mandirs are 22 of 118 units).

| SKU | Units | CBM | Ex-factory + pack USD | Landed at the 3PL (freight + duty + admin) USD | List | Retail value USD | Contribution after CAC USD |
|---|---|---|---|---|---|---|---|
| S1 Carved mandir 2.5 ft | 16 | 3.17 | 1,367 | 2,521 | 599 | 9,584 | 2,516 |
| S2 Compact mandir 2 ft | 12 | 1.30 | 620 | 1,111 | 449 | 5,388 | 2,144 |
| S3 Carved mirror | 14 | 0.98 | 378 | 765 | 279 | 3,906 | 1,256 |
| S4 Jaali panel | 12 | 0.59 | 359 | 620 | 219 | 2,628 | 698 |
| S5 Coffee table | 10 | 1.15 | 585 | 1,023 | 459 | 4,590 | 1,338 |
| S6 Side table | 14 | 1.21 | 495 | 947 | 309 | 4,326 | 1,336 |
| S7 Console | 6 | 0.83 | 481 | 803 | 559 | 3,354 | 1,097 |
| S8 Bench | 4 | 0.40 | 234 | 390 | 369 | 1,476 | 408 |
| S9 Bookshelf | 4 | 0.74 | 355 | 629 | 739 | 2,956 | 1,177 |
| S10 Pooja stool | 12 | 0.66 | 252 | 506 | 189 | 2,268 | 560 |
| S11 Kitchen gift set | 14 | 0.20 | 194 | 319 | 109 | 1,526 | 401 |
| **Total** | **118** | **11.23** | **5,320** | **9,634** | | **42,002** | **12,931 (31%)** |

Add: bond/ISF/broker set-up about USD 500, cargo insurance about USD 350, 3PL onboarding USD 250. **Cash at risk in the container about USD 10,700 before any marketing** (matches the logistics doc's USD 11-12k). A container is billed per CBM or per 1,000 kg, whichever is greater; ours is about 2.1 t, so volume rules (ESTIMATE). Minimum viable LCL is 8-12 CBM; the Lean container (5.4 CBM, 61 units) pays a higher per-CBM rate (ASSUMPTION: +USD 20-40 per CBM), which the lean scenario ignores.

**What sells out first (and what to do):** with the demand mix in [07](07-budget-channel-mix-and-timeline.md), mandirs and the pooja stool run out around order 70; container 2 is booked at order 25 so that it lands roughly when stock ends. Stock-outs are converted into **"made to order, next batch ships in about 10 weeks"** rather than lost sales (FTC ship-date rule applies).

## 4. Photographs to take (real workshop photos)
Priority order for the shoot days in Jodhpur (before the container closes): S1 mandir, S2 mandir, S3 mirror, S5 coffee table, S4 jaali, S6 side table, S7 console, S10 stool, S8 bench, S9 bookshelf, S11 kitchen set. For each: 6 images (see [02](02-launch-readiness-gate.md) B4) plus the workshop, carving, packing and assembly videos, and finish swatch cards for both woods. Photograph **the actual batch** with a batch number on a card in one frame (proof that it is the real workshop and real stock). No stock images, no fictional artisans, artisan names only with consent.

## 5. Wood species decision: sheesham vs mango vs teak (given CITES and Lacey)

| Question | Answer |
|---|---|
| What does the law require? | **Lacey Act:** genus/species and country of harvest on every entry for furniture and wood articles (all species). **CITES:** *Dalbergia sissoo* (sheesham) is under Appendix II through the genus listing with Annotation #15; items over 10 kg net timber weight need a permit or Vriksh certificate, items under 10 kg none (market-selection.md 4.1). The exact annotation wording for finished goods and any CoP20 change **could not be verified** (us-legal-requirements.md) |
| Which of our SKUs exceed 10 kg net timber (gross kg minus about 2 kg packing)? | S1 (30), S2 (14), S5 (24), S6 (13), S7 (28), S8 (20), S9 (35): **seven of eleven**. Under 10 kg: S3 mirror, S4 jaali, S10 stool, S11 kitchen set |
| **Recommendation for container 1** | **All mango wood (*Mangifera indica*) or acacia, no Dalbergia.** It removes the CITES permit, the per-shipment paperwork (DHL charge INR 4,500 or USD 28 plus certificate cost) and the biggest seizure risk, and "solid mango wood" is a mainstream US search term (World Market, Timbergirl, Pottery Barn carved mango). Cost: mango is usually cheaper than sheesham (owner's real figure decides); trade-offs to state honestly: lighter and softer (dents more easily), colour varies |
| Sheesham later | Only after (a) the India CITES Management Authority/EPCH confirms in writing how Annotation #15 applies to finished handicrafts and (b) the four under-10 kg SKUs (S3, S4, S10, S11) are proven to stay under 10 kg net per item; mixed-species containers add paperwork per line |
| Teak | Higher timber cost and not in our cost sheet; teak buyers (mandirs) are a quote-only niche: **do not stock teak in container 1**. Never call mango or sheesham "teak" |
| How to name it | "Solid mango wood (*Mangifera indica*)"; "sheesham (Indian rosewood, *Dalbergia sissoo*)" only for that species; never "rosewood" alone (buyers may assume protected Brazilian rosewood); "solid wood" only if no veneer/ply |
| Proof file | Timber supplier invoice and species statement per batch, kept 5 years (Lacey record-keeping); publish a compliance summary only once the documents exist |

## 6. What to leave out of container 1 and why
| Leave out | Reason |
|---|---|
| Storage trunk 90x45, plant stand/planter | Not viable at market price (0.24 CBM and 104 lb billable weight, last mile USD 157; planter comp USD 45) |
| Beds, dining tables, wardrobes, sideboards, cabinets, vanities | Over 110 lb/oversize freight, LTL, Section 232 cabinet risk (25%, 50% from 1 Jan 2027), CITES if sheesham |
| Upholstered wooden seating | Section 232 25% (30% from 1 Jan 2027) |
| Glass table tops, mirrors over 30 in | Breakage claims |
| Mandirs with lights, bells with electrics, lamps | UL/NRTL listing (USD 3-10k, 8-12 weeks) |
| Wooden toys, Channapatna toys | CPSIA/ASTM F963/CPC testing and tracking labels |
| Standalone trays/utensils under USD 50 | Parcel fixed cost of USD 26 last mile exceeds margin; commodity at USD 25-35 |
| Laminate/engineered mandirs | Contradicts the solid-wood story; competes with USD 399 units |
| Large mandirs 3-4 ft and custom sizes | **Made to order only** ([08](08-customisation-offer.md)) |

## 7. Wave 2 (after about order 30-50, container 2)
Bookshelf volume, 3-4 ft custom mandirs as regular made-to-order, larger jaali panels, a second finish (walnut/honey/natural on each wood), sheesham light items if the CITES answer is in writing, a pair of stools/chowki, and any SKU that sold out. Drop or reprice anything with fewer than 2 sales in 10 weeks.
