# US 4. Combos in USD (built on the combo engine, decision 0037)

Part of [../us-first-100-orders-plan.md](../us-first-100-orders-plan.md). Date: 2026-09-25. Costs and margins from [03](03-starter-catalogue.md); all numbers are model outputs on ASSUMPTION inputs. Combos raise order value and count the acquisition cost once, but **in the US a multi-item combo does not save shipping**: every carton is a separate ground shipment (the model sums last mile per carton).

## 1. What the engine does (decision 0037) and what it means for the US
- Modes: FIXED_PRICE, PERCENT_OFF, AMOUNT_OFF. **Money figures are in the DEFAULT market's currency (INR); another market needs its own `ComboCountryPricing.value` in its own currency and an `isEnabled` row (opt-in), otherwise the combo is not sellable there.** So every US combo below needs a **USD FIXED_PRICE row** and every constituent product must be switched on for the US (decision 0032) with a USD price.
- The combo must be **strictly below the separate total** at that market's prices or it becomes unavailable. Combos are >= 2 units; no duplicate product+variant line (the "side-table pair" C6 therefore needs the pair as one line with quantity 2, or two variants/finishes).
- One atomic bundle line in the cart; **coupons apply to the post-combo subtotal, combo lines count as sale lines, `excludeSaleItems` skips them and product/category-scoped coupons never see them** (0037). Our US coupons therefore all set `excludeSaleItems = true` ([05](05-coupons-and-promotions.md)); no stacking.
- **The engine only sees website checkout.** The site has no US checkout until after about order 50 (Gate C, [02](02-launch-readiness-gate.md)); until then combos are shown on the site as a "Get a quote for this set" and closed by WhatsApp/quote at the combo price, and are sold on Amazon/Etsy as set listings (section 4).

## 2. The six US combos

Price rule: about **8% below the sum of the parts** (7.5-8.9%), whole dollars, sold at the same price on every channel. "Reference" is the sum of our own single prices, which are prices we really charge (no invented compare-at). Contribution includes one CAC allowance (the highest of the parts).

| # | Combo | Contents | Sum of parts | **Combo price** | Saving | Landed | Contribution after CAC | Floor (10%) | Headroom | Season and buyer | Best channel |
|---|---|---|---|---|---|---|---|---|---|---|---|
| C1 | **Pooja corner set** | S1 mandir 2.5 ft + S10 pooja stool | 788 | **729** | 7.5% (59) | 411 | 178 (24%) | 604 | 17% | Housewarming, Diwali 2027, new-home Indian-American households | Amazon set listing, own-site quote |
| C2 | **Living-room accent trio** | S5 coffee table + S6 side table + S3 carved mirror | 1,047 | **959** | 8.4% (88) | 481 | 331 (35%) | 680 | 29% | Mainstream design buyers, spring refresh, staging | Etsy set, own site |
| C3 | **Entryway set** | S7 console + S8 bench + S3 carved mirror | 1,207 | **1,099** | 8.9% (108) | 566 | 373 (34%) | 788 | 28% | New homes, Airbnb hosts and stagers (B2B-ish) | Own-site quote, Etsy custom |
| C4 | **Gift pair** | S4 jaali panel + S11 personalised kitchen set | 328 | **299** | 8.8% (29) | 157 | 75 (25%) | 246 | 18% | Housewarming, Diwali/Christmas gifting, weddings | Etsy, own site |
| C5 | **Compact pooja starter** | S2 mandir 2 ft + S10 pooja stool | 638 | **589** | 7.7% (49) | 273 | 209 (36%) | 411 | 30% | Apartment dwellers, first mandir | Amazon, Etsy |
| C6 | **Side-table pair** | S6 side table x 2 | 618 | **569** | 7.9% (49) | 283 | 190 (33%) | 412 | 28% | Sofa flanks, bedside; the "pair" is the entry to C2 | Etsy, Amazon |

Rule of thumb built into the table: the combos carry more contribution in dollars (75-373) than the single hero orders (47-294) because the CAC is spent once. **Expected share in the base mix: 28 of 100 orders** ([07](07-budget-channel-mix-and-timeline.md) section 2).

## 3. Guardrails
1. **Never below the floor, per channel:** on Etsy the effective floor is higher because of the 14.5% fee stack. C1 (17%) and C4 (18%) have the least headroom: **no coupon, sale or Lightning Deal on C1 or C4.**
2. **No stacking:** a combo is a sale line; no coupon, no trade or referral discount on top. The combo IS the discount.
3. **No combo of a stock hero with a made-to-order piece:** two dates in one order breaks the FTC ship-date statement; sell them as separate orders or set the ship date of the whole order to the later one.
4. **Multi-carton expectation:** the confirmation says "ships in 2-3 cartons; they may arrive on different days". Stock is reserved for the whole set; a set is only shown when all parts are in stock (the engine also refuses out-of-stock combos, `COMBO_OUT_OF_STOCK`).
5. **Shipping-included price** everywhere; no "free shipping over" threshold on combos (the price already includes it).
6. **Damage on one carton** is handled per carton (repair or replace that piece); the combo price is not refunded for the rest.
7. **Check the classification:** C3 and C2 contain two furniture HTS lines and a mirror line (HTS 7009.92 unverified); the invoice lists each unit separately (broker).
8. **Do not add** the bookshelf, kitchen sets alone, or anything under the floor into combos to "use up" stock.

## 4. Marketplace bundle equivalents
| Marketplace | How to sell the set | Notes (ASSUMPTIONS to verify) |
|---|---|---|
| **Amazon** | Create a **set listing** with its own ASIN/SKU ("Pooja Corner Set: mandir and stool"), sold from FBA as one unit (the 3PL prepares it as a multi-carton set with a set ID, or as separate shipments linked by the product page). "Frequently bought together" appears automatically; **Virtual Bundles** and multi-buy promotions exist but may need Brand Registry and eligibility | Multi-carton items need care at FBA check-in; start with **C1, C5, C6 only** (two cartons) |
| **Etsy** | A **"Set" listing with variations** (single, set) and/or a shop **discounted bundle/sale** on selected listings; Etsy also supports promo codes, targeted offers (to favouriting/cart-abandoning buyers, one per 30 days per buyer, expire 7 days after creation, single use) | Etsy's help centre lists sales, promo codes, discounted bundles and targeted offers ([help.etsy.com](https://help.etsy.com/hc/en-us/articles/115014260108-How-to-Set-Up-Sales-and-Discounts-for-Your-Shop)); details via a secondary summary, verify in Shop Manager |
| **Own site** | Combo module (FIXED_PRICE USD) once checkout exists; until then the quote form pre-fills the set | Site checkout is a Gate C dev item |
| **B2B (stagers, designers, Airbnb hosts)** | Quote at the combo price, plus a trade discount **instead of** the combo saving, not on top ([05](05-coupons-and-promotions.md) TRADE) | |

## 5. What NOT to make a combo
The bookshelf (already the highest margin), the storage trunk (not stocked), any set that includes the kitchen gift set alone at under USD 150 without a hero, and any "Diwali gift box" containing non-stocked items. A US "Diwali gift" is the Gift pair (C4) or a mandir-plus-stool set, sold for **Diwali 2027** (29 Oct 2027); for Diwali 2026 (8 Nov) nothing is in the US in time ([05](05-coupons-and-promotions.md) section 5).
