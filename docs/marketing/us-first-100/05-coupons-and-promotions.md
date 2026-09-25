# US 5. Coupons and promotions in USD (own-site/quote path on the coupon engine, plus marketplace equivalents)

Part of [../us-first-100-orders-plan.md](../us-first-100-orders-plan.md). Date: 2026-09-25. Floors and promo headroom per SKU: [03](03-starter-catalogue.md) section 2; combos: [04](04-combos.md). Tags: VERIFIED / ESTIMATE / ASSUMPTION. Nothing here is legal advice.

## 1. What the coupon engine does (decision 0035) and what it means for a US launch
- Types: **PERCENTAGE, FIXED, FREE_SHIPPING**; rules: minimum order (judged on the discountable amount), `maxDiscount` cap, `userLimit` (default 1), `usageLimit`, `firstOrderOnly`, start/end, `productIds`/`categoryIds`, `excludeSaleItems`, `countryCodes`, `isPublic`. **One coupon per order**; an unusable coupon at order time **rejects the order**. Ordering requires login. Usage is race-safe and reverted on cancel/return/refund.
- **Currency rule:** the base columns (`value`, `minOrderAmount`, `maxDiscount`) are INR (the default market). **A US coupon needs `countryCodes = US` and `countryTerms` in USD** (min order and cap in USD); a PERCENTAGE coupon with no money rules is currency-free, but ours always carry a min and a cap, so they need `countryTerms`. Otherwise the engine refuses the coupon in the US (`COUPON_WRONG_COUNTRY`). Enter a harmless INR equivalent in the base columns (verify in the Admin > Coupons form).
- Combo lines count as sale lines: **every code below sets `excludeSaleItems = true`**, so coupons never stack with combos ([04](04-combos.md)). Seed coupons WELCOME10, FREESHIP, HANDMADE500 stay deactivated for the US (they are rupee coupons).
- Not supported: **BUY_X_GET_Y** (use combos), automatic referral rewards, per-lead auto codes, store credit.
- **The engine only sees website checkout.** The US site has no checkout until after about order 50 (Gate C in [02](02-launch-readiness-gate.md)), and WhatsApp/quote-closed orders never touch it. **Until then the US coupon set is a set of quote concessions, written on the quote, logged in the lead sheet (column "Incentive used") and configured in Admin > Coupons in advance so they are ready when checkout exists.** Marketplace promotions (section 3) are the real discount tools for the first 100 orders.
- Known gap (OPN-05): abandoned online orders left PENDING keep their coupon redemption until cancelled: cancel PENDING orders older than 48 hours weekly.

## 2. Guardrails
1. **Price after every discount stays at or above the floor** ([03](03-starter-catalogue.md)). Own-site headroom is 17-40% by SKU; the binding channel is Etsy (7-28%). **No blanket coupon above 6%**, and caps stop percentage coupons at USD 40-60.
2. Coupon minimum sits above the cheapest single so that a code cannot be used to buy the kitchen set at a loss: **minimum USD 200-300.**
3. Total stack: a code, a manual quote concession, a trade discount or a referral credit **never combine**; no stacking with combos.
4. **Liability per code = `usageLimit` x `maxDiscount`** (last column, worst case).
5. **No fake urgency and no invented "was" prices** (FTC): an expiry date is only shown if it is real; a "sale" price is only shown if the higher price was really charged.
6. Not used on made-to-order pieces beyond the welcome offer (their margin is set in [08](08-customisation-offer.md)).

## 3. The launch coupon set for the own site/quote path (8 codes)
All: `countryCodes = US`, `excludeSaleItems = true`, `userLimit = 1` unless stated; dates Pacific time.

| # | Code | Purpose | Type / value | Cap | Min order | Scope | Limits | Start - end | Public? | Worst-case cost | Tracking |
|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | **FIRSTUS** | Welcome / first order | PERCENTAGE 5% | USD 40 | USD 250 | all launch singles | usage 100, `firstOrderOnly` | site checkout live - 30 Jun 2027 | Yes | 100 x 40 = USD 4,000 (expected: a few redemptions, because most orders are marketplace) | usage report; `couponCode` on order |
| 2 | **REF-<FRIEND>** (referral "give") | Friend gets USD 40 off | FIXED USD 40 | n/a | USD 300 | all launch singles | usage 5 per code, `firstOrderOnly`, 90 days | on demand | No | 40 per referred order | usage report per code; lead sheet `REF-name` |
| 3 | **THANKS-<REFERRER>** (referral "get") | Referrer gets USD 40 off their next order, issued only after the friend's order is delivered and confirmed | FIXED USD 40 | n/a | USD 300 | all launch singles | usage 1, expires 6 months | after delivery | No | 40 per referral: a referred order costs USD 80, below the base paid Meta cost per order (about USD 167) | sheet: referrer ledger, max 5 rewards a person a year |
| 4 | **CLOSE-<LEADID>** | Quote closing incentive, only when the quote is USD 500+ (USD 50 for quotes of USD 1,000+) | FIXED USD 25 / 50 | n/a | quote value | the quoted items | usage 1, 72 hours | per quote | No | 25-50 per closed quote, only if the result stays at or above the floor | lead sheet |
| 5 | **NUDGE-<MONTH>** (abandoned-quote nudge, monthly rotation) | Sent on day 7 after days 1 and 3 were ignored | FIXED USD 20 | n/a | USD 250 | all launch singles | usage 30 per month | 1st - last of month | No | 30 x 20 = USD 600 a month | lead sheet |
| 6 | **CREATOR-<HANDLE>** | Creator attribution | PERCENTAGE 5% | USD 40 | USD 200 | mirrors, jaali, stool, kitchen set, mandirs | usage 30, 60 days after posting | at brief | No (only that creator) | 30 x 40 = USD 1,200 per creator at most, plus the fee ([07](07-budget-channel-mix-and-timeline.md)) | usage report; UTM `utm_medium=creator`; disclosure check ([../social/11-us-diaspora-and-mainstream-playbook.md](../social/11-us-diaspora-and-mainstream-playbook.md)) |
| 7 | **TRADE-<FIRM>** (stagers, designers, Airbnb hosts, studios) | Trade programme for repeat B2B-ish buyers | PERCENTAGE 10% | USD 150 | USD 500 | S3-S9 (not combos, not kitchen set) | usage 12 a year per firm, `userLimit` 1 per client | 12 months | No | 12 x 150 = USD 1,800 per firm at most | firm sheet; **either** 10% trade **or** a 6% commission after delivery, never both on the same order; needs a resale certificate/business proof (ASSUMPTION) |
| 8 | **SPRING27** | Spring refresh and Mother's Day (Sunday 9 May 2027, second Sunday of May) | PERCENTAGE 5% | USD 40 | USD 250 | mirrors, jaali, consoles, benches, side tables, stools | usage 80 | 15 Mar - 9 May 2027 (ship-by for Mother's Day 30 Apr) | Yes | 80 x 40 = USD 3,200 | UTM `us-spring-202703` |

**Worst-case exposure of the set if every limit were used: about USD 12,000 (never realistic); expected redemptions in the first 100 orders: 8-15 codes, about USD 400-600.** The plan's average coupon allowance is 4% of revenue (about USD 1,950 on USD 48,750): this covers marketplace promotions too.

## 4. Seasonal codes for 2027 (create when needed; same rules as above)
| Code | Event and date | Type | Cap / min | Window |
|---|---|---|---|---|
| DIWALI27 | **Diwali Friday 29 Oct 2027** (festival about 27 Oct-1 Nov) | PERCENTAGE 5% | USD 50 / USD 300; mandirs, jaali, mirrors, stools | 1 - 24 Oct 2027 (last ready-stock order date for pre-Diwali delivery: 22 Oct) |
| BFCM27 | Black Friday 26 Nov and Cyber Monday 29 Nov 2027 (Thanksgiving 25 Nov 2027; 2026 dates are 27 and 30 Nov) | PERCENTAGE 6% | USD 60 / USD 300; all singles except C1, C4 | 24 - 29 Nov 2027; Q4 ad CPMs run 15-40% above average and up to 2x in BFCM week, so ads for it are a poor use of a small budget |
| GIFT27 | Christmas gifting | FIXED USD 20 | min USD 150; gift pair, jaali, kitchen set | 1 - 12 Dec 2027 (ground delivery cut-off) |
| WEDDING27 | Wedding and housewarming gifts | PERCENTAGE 5% | USD 30 / USD 200; gifting SKUs | Apr - Jun 2027 |

## 5. Event calendar and the plan for each (US seasons and diaspora)
| Date | Event | Plan | Evidence |
|---|---|---|---|
| Tue 6-Wed 7 Oct 2026 | Amazon Prime Big Deal Days | **Skip** (no stock, no account history) | aboutamazon.com 2026-09-25 (VERIFIED) |
| Sun 8 Nov 2026 | **Diwali 2026 (festival 6-10 Nov)** | **Missed for stock: nothing reaches the US by sea in time.** Use it for content and the waitlist: "Diwali 2027 pre-orders open"; made-to-order orders taken now ship after January. Do not promise Diwali delivery | hindutone.com (ESTIMATE); [../best-selling-products-by-market.md](../best-selling-products-by-market.md) 9.4 |
| Fri 27 Nov / Mon 30 Nov 2026 | Black Friday / Cyber Monday | **No discount.** Early-access list with a free finish swatch kit for the first 50 sign-ups; Q4 CPMs are 15-40% above average, BFCM up to 2x | timeanddate.com; digitalapplied.com (ESTIMATE) |
| Dec 2026 | Christmas gifting | **Not served** (see [07](07-budget-channel-mix-and-timeline.md) section 6 on the air-freight pilot). Content only, Pinterest boards for 2027 | |
| about Thu 14 Jan 2027 | Makar Sankranti/Pongal | First stock lands about 18 Jan: a "just landed" launch, not a Sankranti sale | date ESTIMATE, verify |
| Feb-Mar 2027 | Launch weeks on Amazon/Etsy; wedding season and housewarmings | FIRSTUS and referral live; Amazon launch coupon on S1/S5 | |
| Mon 22 Mar 2027 | Holi | Culture/lifestyle content (colour, home gatherings), no sale | hindusphere.com/samvat.in (VERIFIED via search) |
| about 7 Apr 2027 | Ugadi/Gudi Padwa | New-home/new-year mandir content, SPRING27 running | date ESTIMATE, verify |
| Sun 9 May 2027 | Mother's Day (US) | SPRING27, gift pair (C4) | computed |
| June-July 2027 | Amazon Prime Day (2026 was 23-26 Jun; 2027 date not announced) | Coupon-only participation once the ASIN has reviews; see below | sellerapp.com; date ASSUMPTION |
| Sat 4 Sep 2027 | Ganesh Chaturthi | Compact mandir and pooja stool content | VERIFIED via search |
| Thu 30 Sep 2027 | Navratri start; Dussehra Sat 9 Oct 2027 | Mandir/pooja stool; DIWALI27 starts 1 Oct | VERIFIED via search |
| Fri 29 Oct 2027 | **Diwali 2027** | Main diaspora season; container timing: ship from Jodhpur by 1 Aug 2027 to land in early Oct | VERIFIED via search |
| Fri 26 / Mon 29 Nov 2027 | Black Friday / Cyber Monday | BFCM27 | computed |

## 6. Marketplace promotions (the real tools for the first 100 orders)
### 6.1 Amazon
| Tool | Rules (2026; ESTIMATE from seller-guide summaries, verify in Seller Central) | Our use |
|---|---|---|
| **Coupons** | Percentage or fixed; to show the coupon badge keep the discount at 10% or higher; a per-redemption fee applies (about USD 0.60, ASSUMPTION); coupons can be submitted through the end of an event | **10% launch coupon on S1, S3 and S5 for weeks 2-4 of the listing** (Amazon path contribution stays at 24-31% at 10% off; floor headroom 33%) |
| **Lightning Deals / Prime Exclusive** | Professional seller with a **3.5-star rating** (reviews needed); at least 15% off; **60-day rule** (deal price at or below the lowest price in the last 60 days) and **30-day rule** (at least 5% below the lowest price in the last 30 days); flat fees **USD 500 (Prime Exclusive Lightning Deal), USD 1,000 (Best Deal)**; 2026 deadlines were about two weeks before the event | **Not in the first 100 orders**: no ratings, and the fee equals 1-2 mandir orders of contribution |
| **Prime Day** | Prime Day 2026 was 23-26 Jun; Prime Big Deal Days 6-7 Oct 2026 | Coupon-only in 2027 if the ASIN has 15+ reviews |
| **Price parity** | Amazon dislikes lower prices elsewhere; we keep one shelf price | see [01](01-owner-input-sheet.md) G6 |
| Rules of thumb | A promotion sets the "lowest price" reference for the next 60 days: **run one at a time** | |

Sources: https://www.estorefactory.com/amazon-update/prime-day-2026-deals-fees-rules-deadlines/ (2026-03-24), https://sell.amazon.com/blog/seller-promotions, https://www.sellerapp.com/blog/amazon-prime-day/, https://www.aboutamazon.com/news/retail/amazon-prime-big-deals-day-2026-when-october-6-7 (all read via search, 2026-09-25).

### 6.2 Etsy
Four tools (Etsy Help): **sales** (percentage or free shipping on selected listings for set dates), **promo codes** (shared on social, in messages, in the shop announcement), **discounted bundles**, **targeted offers** (automated to buyers who favourited an item or left it in the cart; one offer per buyer every 30 days, expires 7 days after creation, single use, per secondary sources). https://help.etsy.com/hc/en-us/articles/115014260108-How-to-Set-Up-Sales-and-Discounts-for-Your-Shop.
| Use | Setting | Guardrail |
|---|---|---|
| Launch | "Share and save" promo code 5% on S3, S6, S10 for the first 4 weeks | Etsy floors: mandir 542, coffee table 398, bench 327, jaali 197: **no more than 5% on those** |
| Targeted offer | 5% on favourited/abandoned items (S3, S6, S7, S2 only) | S1/S4/S5/S8/S10/S11 have under 13% headroom on Etsy |
| Sale events | One sale per season only (spring, Diwali 2027) | Etsy's Offsite Ads fee is 15% (12% and mandatory above USD 10k trailing revenue) **and is charged on top**: do not stack a sale on an offsite-ads order below the floor |
| Custom orders | No discount; price by the adder table in [08](08-customisation-offer.md) | |

## 7. Referral and community programme (both audiences)
- Give USD 40 / get USD 40 (codes 2-3), **only** for customers with a delivered order and a photo review (not a condition of the discount: incentives must not depend on review content or sentiment).
- Diaspora communities: a "Founding 25 families" list (real, capped, honest scarcity: the first container has 28 mandirs), a **temple/community-group partnership** (donate a 2 ft mandir to a temple raffle in exchange for a talk; ASSUMPTION), WhatsApp community with opt-in (TCPA consent).
- Interior designer/stager programme: TRADE code, sample kits, lead-time honesty.
