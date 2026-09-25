# 4. Combo strategy (built on the combo engine, decision 0037)

> **SUPERSEDED BY THE US EDITION (2026-09-25).** Owner direction: B2C export, first 100 orders from consumers outside India, USA first, India domestic out of scope. For the export business use [../us-first-100-orders-plan.md](../us-first-100-orders-plan.md) and its files under [../us-first-100/](../us-first-100/). This India D2C document is kept for history and for its India method (decision 0040 is superseded by [0041](../../decisions/0041-us-first-b2c-export-plan.md)).

Part of [../first-100-orders-plan.md](../first-100-orders-plan.md). Date: 2026-09-25. SKU codes S1-S16 are defined in [03-starter-catalogue.md](03-starter-catalogue.md); costs and floors are ASSUMPTIONS at the defaults in [01-owner-input-sheet.md](01-owner-input-sheet.md).

## 1. What the engine can and cannot do (decision 0037, read on 2026-09-25)

- A combo is a named set of products (optional variant, quantity each), at least 2 units, sold as **one atomic bundle**; the shopper cannot edit items inside it. Pricing modes: **FIXED_PRICE** (the set costs X), **PERCENT_OFF**, **AMOUNT_OFF**. Money figures are the default-market (India, INR) figure; each combo needs an enabled `ComboCountryPricing` row for a market to sell it.
- A combo sells only if its price is strictly below the separate total, so the "saving" shown is real (it is computed from the actual product prices): this is the one honest anchor the site can display, and it answers AWR-04 (the fake "Save X%" chip).
- Coupon interaction: a whole-cart coupon applies to the post-combo subtotal; but combo lines count as **sale lines**, so any coupon with `excludeSaleItems` skips them, and product- or category-scoped coupons never touch combo lines. **Design consequence: every launch coupon in [05-coupon-strategy.md](05-coupon-strategy.md) sets `excludeSaleItems = true`, so combos never stack with a coupon.** Combo margins below therefore carry no coupon allowance.
- Each combo item names one variant (one size + finish). A combo therefore sells a **standard specification**. A customised version of a combo (different sizes, finish or carving) goes through the quote flow and is priced by hand at or above the combo floor.
- Stock is checked per product (not per variant). For ready-stock items set the stock number to the pre-built count; for made-to-order items set a number you can honour and show the lead time from [01](01-owner-input-sheet.md) A4/A5.
- Free-delivery threshold (INR 4,999) uses the post-combo, post-coupon subtotal, so a combo priced at INR 4,999 or above clears it. Whether the check is `>=` or `>` is not verified: price the Cook's Gift Set at INR 4,999 and test it, or price at INR 5,099.
- Not supported: BUY_X_GET_Y (see workarounds in section 4). No combo-specific analytics events: use ADD_TO_CART events plus the combo "sets sold and revenue" column in the admin list, and the coupon/UTM fields on the order.
- The seed combos (Kitchen Starter Set, Living Room Accent Set, Gifting Trio) contain demo products: deactivate them at launch ([02](02-launch-readiness-gate.md) A5).

## 2. The nine combos

Costing rules: shared packing at 70% of the sum of fixed packing, one consignment freight, one CAC chosen by price band (under INR 5,000: 700; 5,000-12,000: 1,500; 12,000-25,000: 2,200; over 25,000: 2,800; ASSUMPTION), no coupon allowance, same RTO/damage/warranty rules. "Floor" = E1 (25% before CAC) and E2 (10% after blended 40% paid / 60% organic CAC), same method as the catalogue file.

| # | Combo (audience) | Items (variants fixed) | Separate total | **Combo price (FIXED_PRICE)** | Saving | Contribution before CAC | After paid CAC | After organic CAC | **Floor** | Launch |
|---|---|---|---|---|---|---|---|---|---|---|
| C1 | **Housewarming Living Set** (first-time homeowners/renters) | S7 coffee table + 2 x S8 end table + S5 mirror | 27,496 | **24,999** | 2,497 (9.1%) | 7,977 (37.7%) | 27.3% | 35.3% | 20,600 | Week 4 |
| C2 | **Mandir Corner** (families, housewarming, Navratri/Diwali) | S1 mandir 2.5 ft + S3 jaali panel (backdrop) + S13 tray (puja thali) | 24,597 | **21,999** | 2,598 (10.6%) | 6,189 (33.2%) | 21.4% | 30.5% | 19,500 | Week 4 |
| C3 | **Cook's Gift Set** (gifts, new kitchens; free-delivery threshold) | S13 tray + S14 board + S15 masala dabba | 5,297 | **4,999** | 298 (5.6%) | 1,861 (43.9%) | 27.4% | 32.1% | 3,850 | Week 4 |
| C4 | **Diwali Gifting Trio** (corporate/family gifting; organic only) | 3 x S15 masala dabba (engrave names, INR 0 at launch, owner to price if costly) | 6,597 | **5,999** | 598 (9.1%) | 1,731 (34.0%) | **4.5%** | 24.2% | 5,600 | Week 3-4, window closes 28 Oct |
| C5 | **Newlywed Home Gift** (wedding season, gift-givers, NRI gifting back home) | S2 compact mandir + S13 tray + S15 dabba | 13,797 | **11,999** | 1,798 (13.0%) | 3,236 (31.8%) | 17.1% | 26.9% | 10,900 | Week 8 (before 20 Nov) |
| C6 | **Study Nook** (WFH, students, home offices) | S11 desk + S10 bookshelf | 30,998 | **27,999** | 2,999 (9.7%) | 7,269 (30.6%) | 18.8% | 28.5% | 25,800 | Week 9 |
| C7 | **Entryway Set** (designers, new homes) | S9 console + S5 mirror + S12 bench | 32,497 | **28,999** | 3,498 (10.8%) | 7,745 (31.5%) | 20.1% | 29.5% | 26,400 | Week 9, designer channel |
| C8 | **Apartment-in-a-Box** (movers, landlords furnishing, designers) | S7 coffee + 2 x S8 end + S9 console + S5 mirror + S4 jaali 90x120 + S12 bench (101 kg, one consignment) | 64,493 | **57,999** | 6,494 (10.1%) | 17,344 (35.3%) | 29.6% | 34.3% | 49,700 | Quote-only until order 30 |
| C9 | **Cafe / Homestay Starter Kit** (B2B) | 4 x S8 end table + 2 x S12 bench + 6 x S13 tray + 2 x S4 jaali 90x120 | 69,586 | **62,999** | 6,587 (9.5%) | 21,612 (40.5%) | 35.2% | 39.5% | 49,400 | B2B quote-only (shown as a landing page), GST invoice |

**Why the bigger combos show better margins than singles:** one CAC, one consignment and shared packing spread over a larger ticket. That is the arithmetic reason to lead ads with C1/C2 rather than a single bedside table.

C4 is the one combo that fails the 10%-after-paid-CAC test (4.5%): it is **tagged organic-only** (WhatsApp broadcast/status, Instagram, personal network, corporate gifting enquiries, retargeting of existing engagers) and gets **no cold paid budget**. If the real cost of the masala dabba (S15) is lower than the placeholder, this changes.

## 3. Combo rules (guardrails)

1. **Never bundle a margin-negative anchor.** Beds, TV units, bedside tables, wardrobes, sofas (Q2-Q4 and anything not in the launch list) may not appear in any combo, not even as a free add-on. A combo may lift a thin product only when the whole set clears the tests below.
2. **Minimum combo margin:** contribution before CAC at least 25% of net revenue, and at least 10% after CAC at the paid CAC for its price band, **or** it carries the organic-only tag with at least 20% after organic CAC.
3. **Saving cap:** the saving is at most 13% of the separate total and price is never below the floor; small-kitchen combos save 5-9%.
4. **Real saving only:** the anchor is the sum of real product prices; never inflate a product price to make the saving look larger, and never show a saving on a product that was never sold at the higher price.
5. **No stacking:** combos and coupons do not stack (`excludeSaleItems`, section 1). Manual WhatsApp concessions on a combo are allowed only down to the floor.
6. **Price by formula:** combo price = the higher of (floor + a 5-point cushion) and (separate total x 0.87-0.95). Recompute when the owner's costs change ([01](01-owner-input-sheet.md) B1-B6).
7. **Delivery honesty:** multi-piece sets ship as one consignment; the lead time is the longest item's. Advertise the date, not "fast".
8. **Review after 20 sets or 6 weeks:** keep, re-price or retire a combo by sets sold, real margin from the sheet, returns and damage.

## 4. Psychology, seasonality, channel per combo

| Combo | Psychology used (honest versions only) | Season / occasion | Primary channel | Secondary |
|---|---|---|---|---|
| C1 Housewarming Living Set | Bundling removes decision fatigue ("one room, one order"); anchoring on the sum of separate prices; completeness - matched wood and finish across four pieces; "griha pravesh" gift-worthiness | Year-round; peaks with housewarming and post-Diwali move-ins | Meta CTWA (reel: room transformation) | Pinterest, designer referrals |
| C2 Mandir Corner | Ritual completeness: mandir + backdrop + thali; loss aversion avoided by showing a real spec and photo of the exact set; heritage + Jodhpur carving story | Navratri 11 Oct, Diwali 8 Nov, housewarming | CTWA + Instagram reels of carving | Family WhatsApp groups, Google search "wooden temple for home" |
| C3 Cook's Gift Set | Gift-ready price point INR 4,999 (crosses the free-delivery threshold: reward framing); low risk, first purchase from a new brand ("trial size" of the brand) | Diwali, housewarming, Karwa Chauth/anniversary, wedding return gifts | Instagram + WhatsApp broadcast/status | Google Shopping free listings, creators |
| C4 Diwali Gifting Trio | Gift multiples (three families); personalisation = effort signal; scarcity only if real (a true ready-stock count) | Order by 28 Oct for Diwali (ready stock) | Own network, WhatsApp status, corporate gifting DMs | Instagram Broadcast Channel |
| C5 Newlywed Home Gift | Milestone gifting; couple-centric ritual (mandir) + kitchen; bundle removes "what to gift" anxiety | Wedding season from 20 Nov 2026 | Wedding-planner and creator collabs | NRI gifting back to India (WhatsApp quote) |
| C6 Study Nook | Problem-solution framing (WFH back pain? no medical claims - say "made to your desk size"); custom size is the hook | Jan (new year, exam season), all year | Meta CTWA to metro 25-40 | Google "study table for home solid wood" (Hard: only for ads) |
| C7 Entryway Set | Aspiration + "first impression"; designers buy sets | Housewarming, festival decorating | Designer/architect trade programme | Pinterest, Instagram |
| C8 Apartment-in-a-Box | Time saving for movers and landlords; volume anchor of a large ticket makes each piece look small | Lease season, new-flat handovers | Designers, contractors, builder networks (WhatsApp quote) | LinkedIn (organic) |
| C9 Cafe/Homestay Kit | B2B: GST invoice, repeatable spec, "match my brand" custom finish | Peak tourist season (Oct-Mar) for Rajasthan homestays | Direct outreach to Jodhpur/Jaipur/Udaipur cafes and homestays; Instagram DMs | Google Business Profile leads, referrals |

## 5. BUY_X_GET_Y is not supported: workarounds

The coupon engine refuses BUY_X_GET_Y (decision 0035; enum kept, no data model). Use combos instead:
- **"Buy 2 end tables, get the mirror at the set price"** = combo of 2 x S8 + 1 x S5 at a FIXED_PRICE (this is C1 in miniature).
- **"3 for the price of 2" on trays/dabbas** = one combo of 3 x S13 with AMOUNT_OFF equal to one tray, only if the 3-set clears the combo margin test (a set of 3 trays at 2 x 1,599 = 3,198 vs cost 3 x 454 + packing/freight: check in the sheet; C4 shows 3 x dabba at a 9% saving is already only 4.5% after paid CAC, so "3 for 2" is not affordable on trays at default costs).
- **"Free item with a big order"** = a combo containing the free item at price 1 unit lower, only for items whose marginal cost is small (e.g., a finish-care kit costs about INR 150 to make; owner to cost).
- **Gift with purchase (no discount)** = a physical care card/kit packed in the box (cost is paid from the "samples/gifting" budget, [07](07-channel-mix-and-budget.md)), not in the engine.

## 6. Launch order and set-up checklist (config only)

1. Create combos C1, C2, C3, C4 first (week 4, after gate A5 has real photos), C5 in week 8, C6/C7 in week 9; C8/C9 exist as landing/quote pages, not buy buttons, until order 30.
2. For each: name, slug, description that states wood, finish, sizes, lead time and what is customisable, badge text (for example "Set of 4 - one finish, one invoice"), FIXED_PRICE, enabled India row, `showOnHome` for C1-C3 only, real photo of the assembled set.
3. Test: add to bag on a phone, apply the welcome coupon (must be refused for combo lines with a clear message), confirm the free-delivery line, place a test order, cancel it, confirm stock is restored, delete the test order data as the ops runbook requires.
4. Weekly: sets sold and revenue per combo in the admin list; log in the KPI sheet ([../master-growth-plan.md](../master-growth-plan.md) section 4).
