# 7. Channel mix, budget scenarios, funnel math and stop/scale rules

Part of [../first-100-orders-plan.md](../first-100-orders-plan.md). Date: 2026-09-25. Every conversion rate, CPM and organic-order count here is an **ASSUMPTION** (inputs D1-D12 in [01-owner-input-sheet.md](01-owner-input-sheet.md)); ranges are labelled low / base / high; CPC/CPL ranges are **ESTIMATE** taken from vendor blogs quoted in [../social/06-paid-social.md](../social/06-paid-social.md) and [../unit-economics-model.md](../unit-economics-model.md) (India Meta CPM about INR 120-230; Reels INR 45-140; CPC INR 6-55). No furniture-specific Indian benchmark was found by any team. The model was computed with a script whose arithmetic is reproduced in the tables; change the inputs, redo the columns.

## 1. Budget scenarios (per 4-week block, steady state) and recommendation

Definitions: the 16-week plan runs Mon 28 Sep 2026 (week 1) to Sun 17 Jan 2027 (week 16). Paid ads start only after gate A (target end of week 3); spend ramps 25% -> 50% -> 100% as the stop/scale rules (section 7) allow, so the **actual 16-week spend is lower than 4 x the monthly figure** for the paid lines. Non-paid lines run all 16 weeks.

| Line (INR per 4-week block at steady state) | **A. Organic-plus** | **B. Lean** | **C. Base (recommended, gated)** | **D. Growth** |
|---|---|---|---|---|
| Meta Click-to-WhatsApp (CTWA) | 0 (boosts of winning reels: 3,000) | 22,000 | 47,500 | 120,000 |
| Meta lead form / traffic to the quote page | - | - | 12,500 | 40,000 |
| Meta retargeting and catalog ads (from week 8, needs pixel for catalog) | - | 2,000 | 7,500 | 32,000 |
| Google Search (T1 terms, exact/phrase) | - | - | 10,000 | 32,000 |
| Google Merchant free listings (free) and Performance Max (only when catalogue is ready, feed live, at least 30 conversions recorded) | free | free | free | PMax 24,000 |
| **Paid media subtotal** | **3,000 (20%)** | **24,000 (60%)** | **77,500 (62%)** | **248,000 (62%)** |
| Creators, micro-influencers, barter (cash part; barter product cost comes from the samples line) | 0 | 4,000 | 12,500 | 48,000 |
| Designers' trade programme (lookbook print, sample kits, workshop-visit hospitality) | 1,500 | 2,000 | 7,500 | 24,000 |
| Content production (props, lighting, photographer day, travel to a customer's room, editing help) | 4,500 | 4,000 | 12,500 | 40,000 |
| Tools (WhatsApp CRM/labels tool, scheduler, storage; most are free tiers) | 2,250 | 2,000 | 3,750 | 8,000 |
| Samples and gifting (finish swatch kits about INR 150 each, care cards, small pieces for creators) | 3,000 | 2,000 | 5,000 | 12,000 |
| Contingency | 750 | 2,000 | 6,250 | 20,000 |
| **Total per block** | **15,000** | **40,000** | **125,000** | **400,000** |
| Expected actual 16-week outlay | about INR 47,000 | about INR 1.19 lakh | about INR 3.61 lakh | about INR 11.6 lakh |
| Also needed, not in the table | Ready stock for Diwali: about INR 1.1 lakh at default costs ([01](01-owner-input-sheet.md) A9); the team's time; the owner's own salary | same | same | same |

**Recommendation: Scenario C (Base), released in stages.** Reason: it is the only scenario whose base case reaches about 100 orders inside the 16-week window (week 17, about 18 January 2027), at a cost per order about INR 3,800 all-in; Lean is cheaper per order (INR 2,200) but reaches only about 54 orders by week 16 (about week 25 for 100); Growth would take orders faster than the workshop can build (section 4) at INR 6,000 per order. Stage it: weeks 4-5 at Lean spend, weeks 6-8 at half, full Base spend from week 9 **only if** the scale rules in section 7 pass. If the owner cannot fund INR 3.6 lakh over four months, run B and accept about 6 months to 100.

## 2. What one order is worth (the yardstick for every CAC decision)

Order mix used (ASSUMPTION; per 100 orders): mandir 2.5 ft 8, mandir 2 ft 5, jaali 60x90 10, jaali 90x120 3, mirror 6, round mirror 3, coffee table 7, end table 3, console 2, bookshelf 3, desk 2, bench 2, tray 4, board 3, dabba 3, wall shelf 3, C1 6, C2 5, C3 6, C4 4, C5 3, C6 2, C7 2, C8 1, C9 1, dining pilot 3.

| Measure | Value | How |
|---|---|---|
| Average order value incl. GST | INR 12,574 | Weighted by the mix above; skewed up by a few large combos |
| Net revenue per order (ex GST, after coupon allowance) | INR 10,371 | |
| **Contribution before CAC per order** | **INR 3,573 (34.5% of net)** | Uses the SKU/combo economics in [03](03-starter-catalogue.md) and [04](04-combo-strategy.md) |
| Break-even CAC (contribution before overheads = CAC) | INR 3,573 | |
| **Break-even ROAS** (revenue incl. GST / ad spend) | **3.5** | 12,574 / 3,573 |
| CAC ceiling (kill line) | INR 3,000 | About 85% of contribution (owner input D11) |
| CAC target for scaling | INR 2,000 | About 55% of contribution; ROAS about 6.3 |
| Base funnel CAC (section 5) | INR 2,646 | ROAS about 4.8: above break-even, below the scale target |

### Break-even CAC by product (contribution before CAC, default inputs)
Do not pay more than these to acquire one order of that product:

| Product | INR | Product | INR |
|---|---|---|---|
| S13 Tray | 553 | S7 Coffee table | 3,303 |
| S14 Cutting board | 550 | S4 Jaali 90x120 | 3,308 |
| S15 Masala dabba | 611 | S1 Mandir 2.5 ft | 3,934 |
| S16 Wall shelf set | 786 | S9 Console | 4,122 |
| S5 Mirror | 1,439 | S10 Bookshelf | 4,249 |
| S6 Round mirror | 1,285 | C3 Cook's Gift Set | 1,861 |
| S8 End table | 1,471 | C4 Diwali Trio | 1,731 |
| S3 Jaali 60x90 | 2,279 | C5 Newlywed Gift | 3,236 |
| S12 Bench | 2,613 | C2 Mandir Corner | 6,189 |
| S2 Mandir 2 ft | 2,708 | C6 Study Nook | 7,269 |
| S11 Desk | 3,549 | C7 Entryway Set | 7,745 |
| C1 Housewarming Living Set | 7,977 | C8 Apartment-in-a-Box | 17,344 |

Reading it: at the base paid CAC (INR 2,646) **paid traffic makes money only on combos and on the T1 hero products**; a INR 1,599 tray costs INR 553 to serve before CAC, so it can never be bought with cold ads. This is why paid creative leads with C1, C2, S1/S2 and S10, and the kitchen items are organic and add-on products.

## 3. Honest split: what comes from organic and what from paid (16 weeks, Base scenario)

| Source | Orders (base) | Low-high | Why it is plausible / what could break it |
|---|---|---|---|
| Own network, WhatsApp status, family and friends | 10 | 5-14 | The first 150-300 contacts are the cheapest, warmest audience; also the source of the first photos and reviews. Breaks if the owner does not personally message them |
| Designers and architects (trade) | 8 | 3-12 | 60-100 firms contacted, assume 1 in 10 replies and about a quarter of those order within the window; slow to start, compounding |
| Referrals and repeat | 6 | 2-9 | Needs delivered orders first; the referral code ([05](05-coupon-strategy.md)) formalises it |
| Instagram organic + DMs (no ads) | 5 | 2-8 | A new account with 0 posts; the playbook target is 2-7K followers by week 12 (unproven). Not a volume engine in 16 weeks |
| B2B: cafes, homestays, offices | 4 | 0-6 | Site visits and quotes; long cycles |
| Search, Google Business Profile, Merchant free listings | 2 | 0-4 | New domain, noindex until go-live; SEO is a month 4-6+ channel ([../../seo/india-seo-plan.md](../../seo/india-seo-plan.md) section 6.5) |
| **Organic subtotal** | **35** | **21-46** | The least-evidenced number in the plan (input D12) |
| **Paid Meta + Google** | **about 61** | 24-86 | Base CAC INR 2,650 after a learning phase at about INR 3,500 |
| **Total by week 16** | **about 96** | **59-132** | |

Three things the owner should hear plainly:
1. **Without paid ads, expect 25-40 orders in four months, not 100.** Organic and referral orders are cheap but limited by the owner's network and the account's age.
2. **Paid traffic on its own barely pays for itself on the first order** (base CAC INR 2,650 vs INR 3,573 contribution; about INR 900 left before fixed costs, and negative on small items). It pays back through combos, referrals, repeat orders, reviews and the assets it builds (proof for the next customer) - none of which is modelled.
3. **The plan is cash-negative over 16 weeks in every scenario:** contribution of the orders less the outlay less fixed costs (default INR 60,000/month over 3.7 months) is about -1.6 lakh (A), -1.5 lakh (B), **-2.4 lakh (C)**, -6.9 lakh (D). Advance payments soften the timing but not the sum. This is the cost of building the first 100 customers, and the owner should decide it deliberately.

## 4. Capacity check per scenario (input A1/A2)

| | A | B | C | D |
|---|---|---|---|---|
| Steady-state orders per week (base) | 2-3 | 4-5 | 9-10 | 19-20 |
| Orders per 4 weeks | 8-12 | 16-20 | 36-40 | 76-80 |
| Against default workshop capacity (40 décor + 10 furniture per month, about 46 per 4 weeks) | comfortable | comfortable | **near the limit at peak; lead times will stretch** | **exceeds it: backlog grows every week; do not run without more carpenters or a subcontract partner** |
| WhatsApp conversations per week (paid + organic) | 20-40 | 130-140 | about 350 (about 50 per day) | about 850 (about 120 per day) |
| People needed on the sales desk (A7 default) | 1 | 1 | **2 for 3 hours a day each** | 3-4 |

If the desk cannot keep the 15-minute reply SLA, the rule is to cut the ads, not the SLA ([../social/07-community-and-sales.md](../social/07-community-and-sales.md) 7.1).

## 5. Funnel math per scenario (steady state, one week; impressions -> clicks -> WhatsApp/quote leads -> quotes -> orders)

Base funnel: CPM INR 200, click-through 0.9%, click-to-chat 40%, qualified 35%, quoted 75%, quote-to-order (cold) 8%. Low: CPM 260, CTR 0.6%, chat 30%, qualified 30%, quoted 70%, close 4%. High: CPM 150, CTR 1.4%, chat 50%, qualified 45%, quoted 80%, close 14%. Growth uses CPM +25% (audience saturation, ASSUMPTION). Base cost per click INR 22 (range INR 11-43), cost per WhatsApp conversation INR 56, per qualified conversation INR 159, per quote INR 212 (**ESTIMATE ranges, all from the assumptions above**).

| Scenario, case | Weekly paid spend | Impressions | Link clicks | WhatsApp conversations | Qualified | Quotes | Orders | CAC |
|---|---|---|---|---|---|---|---|---|
| B low | 5,538 | 21,300 | 128 | 38 | 12 | 8 | 0.3 | 17,196 |
| **B base** | 5,538 | 27,700 | 249 | 100 | 35 | 26 | 2.1 | **2,646** |
| B high | 5,538 | 36,900 | 517 | 259 | 116 | 93 | 13.0 | 425 |
| C low | 17,885 | 68,800 | 413 | 124 | 37 | 26 | 1.0 | 17,196 |
| **C base** | 17,885 | 89,400 | 805 | 322 | 113 | 85 | 6.8 | **2,646** |
| C high | 17,885 | 119,200 | 1,669 | 835 | 376 | 301 | 42.1 | 425 |
| D low | 57,231 | 176,100 | 1,057 | 317 | 95 | 67 | 2.7 | 21,495 |
| **D base** | 57,231 | 228,900 | 2,060 | 824 | 288 | 216 | 17.3 | **3,307** |
| D high | 57,231 | 305,200 | 4,273 | 2,137 | 962 | 769 | 107.7 | 531 |

Read the low row as "the funnel is broken" (it triggers the stop rules, not a plan) and the high row as "do not plan on it"; the base row is the planning number until real data replaces it. **Only the first INR 10,000-25,000 of spend is needed to learn which row we are in.** Meta also allows a lead-form objective, which usually costs less per lead but produces lower intent ([../social/06-paid-social.md](../social/06-paid-social.md) 6.3); its leads live in Meta, not in the site's Leads table, and must be exported daily.

## 6. Orders by week and month per scenario (base case; cumulative)

Calendar: week 1 = 28 Sep; 3 = 12 Oct; 4 = 19 Oct; 6 = 2 Nov (Diwali 8 Nov falls in week 6); 9 = 23 Nov; 13 = 21 Dec; 16 = 11 Jan.

| Week (start) | A | B | **C** | D |
|---|---|---|---|---|
| 4 (19 Oct) | 4 | 4 | **4** | 4 |
| 6 (2 Nov) | 6 | 8 | **10** | 14 |
| 8 (16 Nov) | 10 | 15 | **20** | 34 |
| 10 (30 Nov) | 14 | 24 | **37** | 70 |
| 12 (14 Dec) | 19 | 34 | **56** | 110 |
| 14 (28 Dec) | 24 | 44 | **76** | 151 |
| 16 (11 Jan) | 30 | 54 | **96** | 192 |
| Range at week 16 (low - high) | 18 - 39 | 33 - 73 | **59 - 132** | 119 - 270 (capacity-capped) |
| Week 100 reached (base) | about week 39 | about week 25 | **about week 17** | about week 12 (needs more capacity) |
| Expected all-in cost per order | INR 1,580 | INR 2,180 | **INR 3,770** | INR 6,020 |

Week-by-week detail for the recommended scenario is in [09-roadmap-and-operations.md](09-roadmap-and-operations.md) section 2. Seasonality (Diwali gifting, wedding season) is not modelled; it is upside for gift sets and mandirs in weeks 4-6 and 9-14, but the Diwali delivery cut-offs cap it (section 3 of the roadmap).

## 7. Channel notes

- **Meta Click-to-WhatsApp (priority 1).** High-ticket custom items fit chat; ice-breaker questions and a prefilled message carrying `ref:CTWA-<adset>`; enquiries must be answered within 15 minutes. Structure and creative testing follow [../social/06-paid-social.md](../social/06-paid-social.md) 6.4-6.5; budget stage T1 INR 10,000 cap, T2 scale only on rules below.
- **Lead form / quote-page traffic (priority 2-3).** Use when the sales desk is saturated with chats (lead forms allow a qualification step) and for the site's quote CTA; site events give funnel visibility (QUOTE_CTA_VIEW to LEAD_SUBMITTED).
- **Retargeting (from week 8).** Video viewers 50%+, IG/FB engagers 30-90 days; 20% of paid spend at most; catalog ads need the pixel/CAPI and feed (gate B6).
- **Google Search (Base and above).** T1 keyword themes only, exact and phrase ([06](06-target-audience.md) 2.1-2.2), negative list, INR 300-500/day; expect low volume on a new domain and rely on it for intent, not reach. **Merchant Center free listings** after the feed exists (W-14). **Performance Max only** with a ready catalogue of 20+ real-photo products, a live feed and at least 30 recorded conversions; until then the money stays in Meta.
- **Creators (nano first).** 10 creators over weeks 3-8: 6 nano barter (small piece, landed cost INR 1,500-4,000), 3 nano cash (INR 3,000-8,000 per reel), 1 micro (INR 10,000-25,000) - the pilot in [../social/05-growth-plan.md](../social/05-growth-plan.md) 5.7 (ESTIMATE rates: upgrowth.in, dazzlerr.com); disclosure (#ad/paid partnership) is mandatory; each gets a `CREATOR-` code and a UTM link.
- **Designers' trade programme.** Lookbook PDF + one sample kit per firm + workshop visit + trade code; reply to a designer's request within 2 hours; track per firm.
- **Content production.** Two shoot days at the workshop plus one styled-room day; it feeds organic and ads. Do not spend on agencies in the first 16 weeks.
- **Samples/gifting.** Finish swatch kits for quotes above INR 12,000 (or INR 299 refundable against order, owner decision), care cards inside every box, a real "thank you" note.
- **Contingency** is for a re-shoot, a gateway fee change, a damaged consignment replacement, or a paid test that must be repeated.

## 8. Stop and scale rules (owner-editable; defaults use INR 3,000 kill line and INR 2,000 target)

**Pause the whole paid account for 48 hours and diagnose the funnel** if any of: (1) more than INR 3,000 spent with zero qualified conversations; (2) first-reply SLA missed on two consecutive days; (3) a delivery/quality complaint that is not resolved within 24 hours; (4) the workshop backlog exceeds two weeks of lead time; (5) payment or checkout is failing.

**Pause an ad set/ad** if: cost per qualified conversation exceeds twice the best ad set's after 3 days; CAC exceeds INR 3,000 after 14 days and at least 5 orders; frequency above 3 in 7 days with falling click-through (rotate creative); or an ad contains a claim we cannot prove.

**Scale (+20% every 3 days, at most)** when for two consecutive weeks: at least 6 paid orders per week; CAC at or below INR 2,500 (target INR 2,000); first reply within SLA on 95% of chats; actual margin on redeemed-coupon orders at or above floor; backlog below 10 working days.

**Move up a scenario** (B to C, C to D) only when scale rules held for three consecutive weeks **and** capacity/desk staffing for the next step is confirmed.

**Move down** if by week 8 (16 Nov) cumulative orders are under 60% of the scenario's week-8 figure (C: under 12) or CAC is above INR 3,000: fall back one scenario, re-check the creative, offer and proof, and read the contingency plan in [09-roadmap-and-operations.md](09-roadmap-and-operations.md) section 6.

**Never scale on** clicks, likes, followers or leads alone: the scale signal is paid orders at a CAC below the target. Attribution is imperfect (first-touch UTM, WhatsApp chats invisible to the site), so read Meta's reporting, WhatsApp labels and the lead sheet together ([../social/08-measurement.md](../social/08-measurement.md) 8.1).
