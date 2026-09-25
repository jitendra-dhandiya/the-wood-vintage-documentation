# 5. Coupon strategy (built on the coupon engine, decision 0035)

Part of [../first-100-orders-plan.md](../first-100-orders-plan.md). Date: 2026-09-25. Floors and headroom per SKU come from [03-starter-catalogue.md](03-starter-catalogue.md) (ASSUMPTIONS at the defaults in [01-owner-input-sheet.md](01-owner-input-sheet.md)); combos are in [04-combo-strategy.md](04-combo-strategy.md).

## 1. What the engine does (decision 0035, read 2026-09-25) and what we build on it

- Types: **PERCENTAGE**, **FIXED**, **FREE_SHIPPING**. Rules per coupon: minimum order (judged on the discountable amount), `maxDiscount` cap, `userLimit` per customer (default 1), global `usageLimit`, `firstOrderOnly`, start/end date, `productIds`/`categoryIds` scope, `excludeSaleItems`, `countryCodes`, `isPublic` (public coupons appear as "Available offers"), `isActive`. Codes are trimmed and upper-cased.
- **One coupon per order.** An unusable coupon at order time **rejects the order** (nothing charged) with a machine-readable code (`COUPON_MIN_ORDER`, `COUPON_EXHAUSTED`, `COUPON_FIRST_ORDER_ONLY`, ...).
- Ordering requires login, so `firstOrderOnly` and `userLimit` are enforced on the account; guests can only preview.
- Usage is race-safe (row lock) and reverted on cancel/return/refund via the `CouponUsage` ledger (`GET /coupons/:id/usages` gives a report).
- Combo lines count as sale lines; `excludeSaleItems` skips them and product/category-scoped coupons never see them: **every launch coupon below sets `excludeSaleItems = true`** so combos, coupons and manual concessions never stack.
- Money terms (`value`, `minOrderAmount`, `maxDiscount`) are INR; the coupon is limited to India via `countryCodes = IN`.
- Not supported: **BUY_X_GET_Y** (use combos, [04](04-combo-strategy.md) section 5); automatic referral rewards; auto-issued per-lead codes; wallet/store credit.
- **The engine only sees website checkout.** WhatsApp-closed orders, UPI advances and manual invoices never touch it. Until gate item B8 ([02](02-launch-readiness-gate.md)) lets an admin record a WhatsApp sale, WhatsApp discounts are written on the quote and tracked in the lead sheet.
- Known gap: abandoned online orders left PENDING keep their coupon redemption until cancelled (OPN-05); cancel PENDING orders older than 48 hours weekly.

## 2. Guardrails against the margin floor

1. **Price after every discount must be at or above the SKU's floor** ([03](03-starter-catalogue.md) section 3). Smallest headroom among coupon-eligible SKUs: study desk 8%, mandir/console/round mirror/mirror 12-13%. **No blanket coupon may exceed 6%**, and caps stop percentage coupons at INR 750-1,000.
2. **Seed coupon WELCOME10 (10%, public, first-order-only) must be deactivated or edited before launch:** 10% breaks the floor on the desk (8% headroom), the mirrors, the console and the 2.5 ft mandir at default costs. Also review **FREESHIP** and **HANDMADE500** (terms not documented in the decisions we read; check them in Admin > Coupons) and deactivate anything not in section 3.
3. **Total stack** (coupon, or manual WhatsApp concession, or trade discount) never takes a price below the floor; there is no stacking with combos.
4. **Liability cap per coupon** = `usageLimit` x `maxDiscount`; listed below so the owner knows the worst case.
5. **Coupon min order sits above the free-delivery threshold** (INR 4,999) plus the maximum discount, so applying a coupon can never drop a cart under the threshold and suddenly add a delivery charge. FIRST100 min INR 5,499 with a 5% coupon: 5,499 - 275 = 5,224, still above 4,999.
6. Coupons do not apply to T3 quote-only pieces (they are not sold at a button) and are not printed in ads for made-to-order furniture beyond the welcome offer.

## 3. The launch coupon set (8 codes)

All: `countryCodes = IN`, `excludeSaleItems = true`, `userLimit = 1` unless stated. Dates in IST. Tracking columns say how success is read (see section 6).

| # | Code | Purpose | Type / value | Cap | Min order | Scope | Limits | Start - expiry | Public? | Worst-case cost | Tracking |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | **FIRST100** | Welcome / first order ("founding customers": the 100 is real: `usageLimit` 100) | PERCENTAGE 5% | INR 1,000 | INR 5,499 | All launch singles (not T3 unless quoted on site) | usage 100, `firstOrderOnly` | Go-live - 31 Jan 2027 | Yes | 100 x 1,000 = INR 1.0 lakh at most; at an average of INR 700 about INR 70k if all 100 are redeemed; expected far fewer because WhatsApp-closed orders will not redeem it | Usage report; order `couponCode`; share of orders using it; first-order AOV vs non-coupon |
| 2 | **DIWALI26** | Festival, ready-stock and made-to-order décor | PERCENTAGE 5% | INR 750 | INR 5,499 | Categories: wall art, mandir/temple, mirrors, lamps (T1/T2 décor SKUs; not furniture) | usage 40 | 12 Oct - 28 Oct 2026 (last ready-stock order date, [01](01-owner-input-sheet.md) A10) | Yes | 40 x 750 = INR 30,000 | Usage report; UTM campaign `in-diwali-202610` |
| 3 | **SHAADI26** | Wedding-season gifting: free delivery on a gift basket | FREE_SHIPPING | n/a (waives the remaining delivery charge, roughly INR 79-249 on small parcels, snapshotted on the order) | INR 3,999 | Category gifting/kitchen-wood/spice boxes/serving ware | usage 80 | 20 Nov 2026 - 28 Feb 2027 | Yes | 80 x about 150 = INR 12,000 (delivery charge waived is an ESTIMATE) | Usage report (amount = shipping waived); UTM `in-wedding-202611` |
| 4a | **REF-<FRIEND>** (friend code, "give") | Referral: friend gets INR 500 off | FIXED INR 500 | n/a | INR 6,000 | All launch singles | usage 5 per code (one referrer), `firstOrderOnly`, expires after 90 days | Created on demand | No (never posted) | 500 per referred order | Code name = referrer; usage report per code; lead-sheet `REF-name` |
| 4b | **THANKS-<REFERRER>** ("get") | Referrer gets INR 500 off their next order, issued only after the friend's order is delivered and the friend confirms | FIXED INR 500 | n/a | INR 6,000 | All launch singles | usage 1, expires after 6 months | Created after delivery | No | 500 per referral; a referred order therefore costs INR 1,000, well below the base paid CAC (INR 2,650) and the mix-weighted contribution (INR 3,570) | Sheet: referrer ledger, max 5 rewards per person per year |
| 5 | **CLOSE-<LEADID>** (WhatsApp quote-closing incentive) | Lift quote to order when the customer is close (only for quotes of INR 12,000 or more) | FIXED INR 500 (INR 1,000 for quotes of INR 25,000 or more) | n/a | quote value | The quoted items | usage 1, expires 72 hours after the quote | Created per quote | No | INR 500-1,000 per closed quote, only when the result stays at or above the floor | Lead sheet: `Incentive used` column. If the sale is closed off-site, write the net price on the quote instead (no code) |
| 6 | **NUDGE-OCT / NUDGE-NOV / NUDGE-DEC** (abandoned-quote nudge, monthly rotation) | Sent at follow-up D+7 (after D+1 and D+3 were ignored) | FIXED INR 300 | n/a | INR 5,499 | All launch singles | usage 30 each, expires 7 days after use date is issued (monthly end date as a backstop) | 1st of month - month end | No | 30 x 300 = INR 9,000 per month | Lead sheet: follow-up outcome; usage report |
| 7 | **CREATOR-<HANDLE>** (e.g. `CREATOR-ANITA`) | Influencer/creator attribution | PERCENTAGE 5% | INR 750 | INR 3,999 | T1 décor categories only | usage 30, expires 60 days after posting | Set at brief | No (published only by that creator) | 30 x 750 = INR 22,500 per creator at most, plus creator fee ([07](07-channel-mix-and-budget.md)) | Usage report per code; UTM `utm_medium=creator&utm_campaign=in-<handle>-yyyymm`; ASCI disclosure check |
| 8 | **TRADE-<FIRM>** (designer/architect/contractor) | Trade programme: same code for the firm's clients | PERCENTAGE 10% | INR 5,000 | INR 10,000 | T1/T2 SKUs except S11 desk and small kitchen | usage 12 per year per firm, `userLimit` = 1 per client | 12 months | No | 12 x 5,000 = INR 60,000 per firm at most (real use far lower) | Usage report per firm; firm sheet; **either** 10% trade discount **or** 6% commission after delivery, never both on the same order |

Sanity check of the floors, at default costs: FIRST100/DIWALI26/CREATOR 5% and NUDGE 300 never take S1 (14,050 floor), S3, S5, S7, S8, S9, S10, S11 (14,700) or S12 below the floor; TRADE 10% is safe on S7 (11,999 - 1,200 = 10,799 vs 9,950), S9 (16,999 - 1,700 = 15,299 vs 15,000) but not on the desk (15,999 - 1,600 = 14,399 vs 14,700), hence the exclusion. Small kitchen items never qualify because minimums exceed their prices.

## 4. Stacking, abuse prevention and rules

**Stacking.** One coupon per order (engine rule). Combos are excluded from every coupon (`excludeSaleItems`). A WhatsApp concession replaces a coupon (no both). A trade or creator code cannot be combined with FIRST100.

**Abuse prevention (engine features plus hygiene).**
1. Non-guessable private codes (`REF-`/`THANKS-`/`CLOSE-` with a name or ID; never reuse a word people can guess).
2. `usageLimit` on every code, `userLimit = 1`, `firstOrderOnly` on welcome/referral codes; expiry on every code.
3. Ordering requires login (OTP), which slows multi-account abuse but does not stop a second phone; review any FIRST100 order whose delivery address or phone repeats.
4. Do not list private codes on coupon-aggregator sites or in public posts; use the `isPublic` offers list only for FIRST100, DIWALI26 and SHAADI26.
5. Deactivate a code at 80% of its limit; weekly cancel of PENDING orders older than 48 hours (OPN-05).
6. Keep a weekly ledger of the usage report (code, order, amount, city, source) in the KPI sheet.
7. Never condition a coupon on a review (platform rules on incentivised reviews vary; the referral reward is for a friend's order, not for a review). The review request is separate ([../social/07-community-and-sales.md](../social/07-community-and-sales.md) 7.3 `/review`).

**Free-delivery threshold (INR 4,999, setting `free_shipping_threshold`).** It uses the post-combo, post-coupon subtotal. Furniture ships under per-product rules (decision 0015). Design consequences: the Cook's Gift Set is priced at 4,999 so it ships free; coupon minimums are 5,499 or more; test whether the comparison is `>=` or `>` on production before printing "free delivery on orders above INR 4,999". Recommended (owner decision): keep 4,999 for the launch, revisit after 30 orders using the actual delivery cost per parcel from [01](01-owner-input-sheet.md) B6.

## 5. Coupon calendar

| Window | Live codes |
|---|---|
| Go-live - 11 Oct | FIRST100, REF-*, CLOSE-*, NUDGE-OCT, CREATOR-* (as creators post), TRADE-* |
| 12 - 28 Oct (Navratri to last ready-stock order) | + DIWALI26 |
| 29 Oct - 19 Nov (Dhanteras 6 Nov and Diwali 8 Nov are festival content, not discounts; delivery dates cannot meet them) | FIRST100 and the private codes only; a "Diwali greetings" post without a coupon; 20 Nov+ wedding-season landing |
| 20 Nov - 28 Feb | + SHAADI26; NUDGE-NOV/DEC/JAN |
| 1 Feb onward | FIRST100 expires 31 Jan; decide a new welcome code only after the first 100 orders' margin data |

Dhanteras is deliberately without a coupon: an order taken on or after 29 October cannot reach the customer by 6 November in the default lead times, and a coupon would advertise a date we cannot keep.

## 6. How each is tracked

| Signal | Where | Cadence |
|---|---|---|
| Redemptions, discount given, shipping waived, per code | Admin > Coupons > usage report (`GET /coupons/:id/usages`), order `couponCode`/`couponDiscount` | Weekly |
| Site orders by UTM/source | Orders' `utmSource/utmMedium/utmCampaign` (first-touch) | Weekly |
| WhatsApp/quote concessions and incentive used | Lead sheet columns: `incentive`, `discount INR`, `net price`, `follow-up D+n outcome` | Daily update, weekly review |
| Creator / designer / referrer ledger | KPI sheet tab "Codes": code, owner, orders, revenue, discount given, fee/commission due, paid date | Weekly |
| Margin check | For every redeemed code: price paid vs floor ([03](03-starter-catalogue.md)); flag any order below floor | Weekly |
| Gaps | Coupons cannot be attributed to a creator when a WhatsApp order is closed off-site; cookie is first-touch only; no per-line discount allocation for partial returns (OPN-16) | - |

## 7. Owner decisions for this file
1. Keep FIRST100 at 5% / INR 1,000 cap, or make it fixed INR 500 (simpler to explain)? Default: 5%.
2. Deactivate WELCOME10, FREESHIP, HANDMADE500 (recommended) and confirm what the last two do.
3. Referral: INR 500 give / INR 500 get, minimum INR 6,000 (default), or a non-cash gift (a finish-care kit) for the referrer.
4. Designer trade: 10% discount or 6% commission (default: commission after delivery, discount only where the designer asks for pass-through).
