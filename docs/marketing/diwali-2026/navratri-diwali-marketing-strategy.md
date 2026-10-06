# Navratri + Diwali 2026 marketing strategy (India D2C)

Date: 2026-10-06 (Tue). Owner direction (today): focus on the INDIA domestic market for **Navratri (Sun 11 Oct
2026, 5 days away — too close to build net-new stock; treat as a soft/content + early-bird launch window
only)** and **Diwali (Sun 8 Nov 2026, ~33 days away — the real commercial target)**. This runs ALONGSIDE the
existing US-first export plan ([decision 0041](../../decisions/0041-us-first-b2c-export-plan.md)) and the
original India first-100 plan ([decision 0040](../../decisions/0040-marketing-go-to-market-plan.md)) — it
does not replace either; see [decision 0042](../../decisions/0042-navratri-diwali-2026-india-push.md). It
**reuses the method and India data** from
[first-100-orders-plan.md](../first-100-orders-plan.md) + [first-100/](../first-100/) (marked superseded
only because of the US pivot — their India cost/margin/combo/coupon method is still valid and is reused
here directly, numbers re-derived with the same formulas so the two documents stay arithmetically
consistent) and from [india-navratri-diwali-plan.md](../india-navratri-diwali-plan.md) (the workstream brief
for this session).

**IMPORTANT — reconciliation finding, read before configuring anything in section 3:** this document was
drafted using the SKU codes S1-S16/Q1-Q4 from
[first-100/03-starter-catalogue.md](../first-100/03-starter-catalogue.md) (the existing India plan's
*planning* catalogue — a set of ASSUMPTION-cost products invented to make margin arithmetic possible, not a
confirmed list of what is actually in the store). The concurrent `50-diwali-products.md` landed while this
document was being finished and checked the **real** seeded catalogue (`backend/prisma/seed-data/catalogue.ts`,
46 products) directly. Two things follow from that:

1. **No carved mandir/temple unit exists in the real catalogue at all** (confirmed independently by both
   this document's own research and `50-diwali-products.md`'s). S1/S2 "mandir" and therefore **D8 Mandir
   Corner cannot be configured in admin today** — it needs either a genuinely new SKU built and costed by
   the workshop, or dropping from this plan. This was already true of the *existing* first-100 plan's C2
   Mandir Corner combo — it is not a new gap this document introduced, but it means **neither the old nor
   the new mandir combo is actually buildable in admin right now.**
2. **Several other S-codes have a real catalogue product at a materially different price**, which changes
   the combo economics below. The closest real matches (VERIFIED from the seed file, 2026-10-06):

   | Planning code used below | Real catalogue product (slug, price) | Price gap |
   |---|---|---|
   | S5/S6 "mirror" | `hand-carved-jharokha-mirror`, **₹11,900** (vs the planning price of ₹5,499) | **+116%** |
   | S3/S4 "jaali panel" | `jaali-carved-wall-panel`, **₹10,400** (vs ₹6,999) | **+49%** |
   | S13 "serving tray" | `hoshiarpur-inlay-serving-tray`, **₹5,290** (vs ₹1,599) — or the plainer `acacia-serving-tray-with-handles`, ₹2,590, a closer price match | **+231% / +62%** |
   | S14 "cutting board" | `acacia-round-chopping-board`, **₹1,790** (vs ₹1,499) | +19%, close enough to reuse |
   | S15 "masala dabba" | `sheesham-masala-dabba`, **₹2,690** (vs ₹2,199) | +22%, close enough to reuse |
   | S16 "wall shelf set" | `floating-mango-wood-shelves-set-of-3`, **₹4,490** (vs ₹3,199) | +40% |
   | S8 "end/side table" | no exact match; closest is `sheesham-bedside-table-pair`, **₹17,900 for a pair**, a different product entirely | not usable as a swap |
   | S9 "console" | `mango-wood-console-table`, **₹19,900** (vs ₹16,999) | +17%, close enough |

**Decision taken for this draft (to stay fast, per the effort instruction, rather than re-run every margin
calculation against real prices with no real cost breakdown to put against them — the seed file gives
consumer prices, not ex-factory wood/labour/finish costs, so a real combo P&L needs the workshop's numbers
either way):** section 3 below keeps the original S-code combo structure and margin arithmetic **as a
pricing-logic demonstration using the same placeholder costs the rest of this India plan already runs on**,
and flags every combo's real-catalogue status plainly. **Before configuring any combo in admin, the owner/
marketing lead must: (a) pick the real product for each slot from the table above (or `50-diwali-products.md`'s
fuller list), (b) get the workshop's real ex-factory cost for it, (c) re-run the combo price/floor using the
same formula** (section 3's method, reusable in a spreadsheet). This reconciliation gap is logged as an open
item in decision 0042 and in the task list (section 9) — it is not optional cleanup, it blocks go-live.

Tags used throughout: **VERIFIED** (source read on the date given), **ESTIMATE** (third-party figure, not
independently verified), **ASSUMPTION** (our placeholder/reasoning), **OWNER-SET** (a choice, not a fact).
Money figures are INR. Margin arithmetic reuses the exact formula in
[unit-economics-model.md](../unit-economics-model.md) section 2 and the combo method in
[first-100/04-combo-strategy.md](../first-100/04-combo-strategy.md) section 2 (shared packing at 70% of
summed fixed packing, one consignment freight, no coupon allowance on combo lines, one CAC by price band);
recomputed with a throwaway script, validated against the published C3 Cook's Gift Set numbers (reproduced
exactly: INR 1,861 / 43.9% before CAC, 27.4% after paid CAC, 32.1% after organic CAC) before being applied to
new combos.

**Docs read before writing this:** `india-navratri-diwali-plan.md`, `first-100-orders-plan.md` + all 10
files under `first-100/`, `competitor-research/india-market-price-benchmark.md`,
`competitor-research/india-competitor-analysis.md`, `positioning-and-usp.md`, `unit-economics-model.md`,
decisions 0028, 0035, 0037, 0039, 0040, 0041, `docs/ux/customer-psychology-gap-tracker.md`.

---

## 0. The one thing to read if you read nothing else

1. **Navratri (11-19 Oct) is a content + early-bird phase, not a sales push** — no new stock can be built in
   5 days. Use it to build the audience and take early-bird orders against existing ready stock only.
2. **The real sales push is 22 Oct - 8 Nov**, gated entirely on **fixing the still-placeholder WhatsApp
   number/phone/Instagram** (confirmed still placeholder as of the latest gap-tracker read — section 7) —
   this is the single biggest swing factor in every order estimate below, bigger than ad budget.
3. **28 Oct is the last order date for guaranteed Diwali delivery on ready stock** (pan-India courier); made-
   to-order décor effectively cannot be advertised for Diwali at all from a 6 Oct start (lead times already
   leave no safety margin); made-to-order furniture carries no Diwali promise, same conclusion as the
   existing first-100 plan.
4. **Recommended budget: Base, ~INR 1.3 lakh over the 5-week window**, expected **25-45 orders by 8 Nov**
   (range; see section 6) — more optimistic than the original first-100 plan's own week-6 figure of ~10
   cumulative orders **only if** Gate A (WhatsApp/phone/photos) is fixed by about 12 Oct. If it slips past
   20 Oct, plan on the original trajectory (~10-15 orders) instead.
5. **9 Diwali combos** built on the live combo engine (section 3), **8 coupon codes** built on the live
   coupon engine with WELCOME10 confirmed retired (section 4).

---

## 1. Owner input sheet (INR) — fill this before spending a rupee

Reuses [first-100/01-owner-input-sheet.md](../first-100/01-owner-input-sheet.md) wholesale (same business,
same costs) with the rows that matter for a 33-day festive sprint pulled to the top. **Every default below
is the same ASSUMPTION/ESTIMATE already in that file** unless marked NEW; write the real number in the last
column.

| ID | Input | Default (reused) | Tag | Priority | Owner's real value |
|---|---|---|---|---|---|
| F1 | Navratri 2026 | Sun 11 Oct | given | - | |
| F2 | Dhanteras 2026 | **Fri 6 Nov** (re-verified 2026-10-06 against a live festival calendar — VERIFIED, [shubhpanchang.com](https://shubhpanchang.com/festivals/dhanteras), [universaltimedate.com](https://www.universaltimedate.com/holidays/dhanteras); matches the owner's original brief) | VERIFIED | - | |
| F3 | Diwali 2026 | Sun 8 Nov (Lakshmi Puja); Choti Diwali/Naraka Chaturdashi Sat 7 Nov; Govardhan Puja Mon 9 Nov; Bhai Dooj Tue 10 Nov | VERIFIED (same source) | - | |
| OWN-1 (NEW) | **Budget available for this 5-week festive push** (marketing spend only, excludes ready-stock cash) | Not given — section 6 shows Lean/Base/Growth at INR 39k / 1.3L / 3.16L | OWNER-SET | **P0** | |
| A9 | **Ready stock willing to pre-build for Diwali** (units by SKU) | 10 x S2 mandir 2 ft, 10 x S3 jaali 60x90, 15 x kitchen-wood sets (S13/S14/S15), 10 x S5/S6 mirror — about INR 1.1 lakh cash at default ex-factory costs (same figure as first-100 A9; recompute once real costs replace the defaults) | ASSUMPTION | **P0** | |
| OWN-2 (NEW) | **Cash available** for (a) ready stock INR ~1.1 lakh + (b) marketing spend (section 6) + (c) running 16-week overheads concurrently | Not given | OWNER-SET | **P0** | |
| OWN-3 (NEW) | **Current stock status** — how many of the A9 units are already built today (6 Oct) vs still to cut/carve/polish in the next 3 weeks | Not given — assume 0 built yet | ASSUMPTION | **P0** | |
| A3-A6 | Lead times: ready stock 3 working days dispatch + 4-7 days transit; made-to-order décor 12-18 working days + transit; made-to-order furniture 21-30 days + transit | ASSUMPTION (unchanged) | - | P0 | |
| A10 | **Last order date for Diwali delivery** | Ready stock: **28 Oct pan-India, 2 Nov Rajasthan/Delhi NCR** (closer lanes); made-to-order décor: effectively already past safety margin from a 6 Oct start (see timeline, section 2); made-to-order furniture: no promise | ASSUMPTION | P0 | |
| C2 | Advance-payment % on made-to-order | 50% for orders ≥ INR 15,000; 100% prepaid under INR 5,000; 40% between | OWNER-SET | P0 | |
| C3 | COD allowed? | No COD on made-to-order; COD only on ready-stock parcels under INR 5,000 with a INR 300 prepaid deposit | ASSUMPTION | P0 | |
| C4 | Prepaid share | 70% | ASSUMPTION | P1 | |
| B7 | GST rate per product family | 18% furniture (HSN 9403); décor 5% or 12% (CA to confirm — unresolved since 25 Sep) | ESTIMATE | P1 | |
| B1 | Timber (sheesham) purchase price | INR 1,500/cft (range 900-2,200) | ESTIMATE | P0 | |
| B1-B6 | Ex-factory cost per SKU (timber, labour, carving, finish, hardware, packaging, freight) | Reused as-is from [first-100/03-starter-catalogue.md](../first-100/03-starter-catalogue.md) section 2 — still unconfirmed by the carpenter team as of this write-up | ASSUMPTION | **P0** | |

**The owner decisions this sheet cannot make for you (also in section "owner decisions needed this week"
below):** how much cash to put at risk on ready stock for a 33-day window; whether to pause other spend to
fund this push; whether Gate A (real WhatsApp/phone, real photos, honest policies — section 7) can genuinely
close by 12 Oct.

---

## 2. Timeline: 6 Oct → 8 Nov

Today is **Tuesday 6 Oct 2026**. 33 days to Diwali. Dates below are IST.

| Window | Dates | Phase | What happens | Money |
|---|---|---|---|---|
| **Week 0** | 6-10 Oct (Tue-Sat) | **Prep sprint** | Owner fills section 1 P0 rows same afternoon as the carpenter team; confirm real WhatsApp Business number/phone/Instagram in Admin > Settings (gap tracker CON-02/LOW-01 — still placeholder); remove fake testimonials/artisans (AWR-01, still open); configure the 9 combos (section 3) and 8 coupons (section 4) in admin; shoot/round up real photos for the ready-stock SKUs; start the 150-300-contact personal WhatsApp list; brief 3-4 nano creators | Content/samples only, no ads |
| **Navratri** | **Sun 11 - Mon 19 Oct** (9 nights) | **Soft/content launch — NOT a sales push** | Daily Navratri content (colour-of-the-day tie-ins optional), WhatsApp status + personal outreach, NAVRATRI26 early-bird code live (ready-stock décor only); D1 Pooja Thali Set, D9 Cook's Diwali Gift Set, D2 Housewarming Gift Box go live for early-bird orders against existing/in-progress ready stock; **no promise of new production** — same owner direction as the brief | Lean-level spend only (boost test under INR 5,000) |
| **Dussehra** | **~Wed 21 Oct** (Vijayadashami, as given in the brief; owner to confirm against a 2026 panchang before publishing content) | Minor content moment | "Auspicious new beginnings" post; no new coupon (folds into the run-up to Dhanteras) | - |
| **The real sales push** | **Thu 22 Oct - Sun 8 Nov** (just over 2 weeks) | **Full push** | Paid ads ramp (Base scenario, section 6) **only if Gate A is closed**; D3 Corporate Gifting Crate and D6 Festive Home Refresh go live; corporate/society direct outreach starts in earnest; DHAN26 and DIWALI-FLASH coupons (section 4) run inside this window; D7 Return Gift Pack pushed to WhatsApp broadcast/corporate contacts for Diwali-party return gifts | Base-scenario spend, staged |
| **Ready-stock cutoff** | **Wed 28 Oct** (pan-India); **Mon 2 Nov** (Rajasthan/Delhi NCR) | **Hard deadline** | "Order by 28 Oct for Diwali delivery" countdown messaging on ready-stock items only — do not publish this date until the workshop has confirmed real dispatch capacity in writing (same rule as first-100 A10) | - |
| **Dhanteras** | **Fri 6 Nov** | **Peak buying day, no NEW discount** | Content and in-person/local (Jodhpur/Jaipur/NCR) sales only; an order placed on or after 29 Oct cannot reach most of India by Dhanteras under default lead times, so this is a "last-chance local pickup / nearby delivery" day, not a new coupon day — same honesty rule the first-100 plan already set for this date | - |
| **Choti Diwali** | Sat 7 Nov | Content | Greeting content, workshop "final polish" video | - |
| **Diwali** | **Sun 8 Nov** | **Greeting only, no discount** | Diwali greeting post/WhatsApp broadcast; dispatch any remaining ready-stock Diwali orders; no new coupon push — an order taken this close cannot be delivered in time, so advertising one would break the "honest delivery date" USP | - |
| **Beyond this plan's scope** | 9 Nov onward | Hand-off | Feeds directly into the existing first-100 plan's wedding-season phase (C5 Newlywed Home Gift, from 20 Nov) and the ongoing 16-week roadmap — not re-planned here | - |

**Reconciling with the existing first-100 roadmap:** [09-roadmap-and-operations.md](../first-100/09-roadmap-and-operations.md)
section 2 already modelled this exact calendar window (its week 4 = 19 Oct, week 6 = 2 Nov) and projected
only **10 cumulative orders by 2 Nov** in its Base scenario, because that plan assumed a slower gate-closure
timeline (16 Oct) and did not front-load corporate/referral channels until week 8+. This document assumes
Gate A closes about 4 days earlier (12 Oct, to catch the Navratri window) and actively works corporate/
referral/community channels from day one of the push — hence a higher order estimate (section 6). **If Gate
A is not closed by 12 Oct, revert to the original plan's 10-15-order trajectory**; do not spend Base-scenario
money against an unmet precondition.

---

## 3. Combos (built on the live combo engine, decision 0037)

Same engine rules as [first-100/04-combo-strategy.md](../first-100/04-combo-strategy.md) section 1: atomic
FIXED_PRICE bundles, saving is real (computed off actual product prices), combo lines are sale lines so
**every coupon in section 4 is `excludeSaleItems = true` and never stacks with a combo**, one consignment
freight, stock checked per product. Costing method: shared packing at 70% of summed fixed packing + 3% of
summed factory cost; one-consignment freight = max(highest individual minimum freight, sum of each item's
weight x its own freight rate); one CAC by price band (under 5,000: 700; 5,000-12,000: 1,500; 12,000-25,000:
2,200; over 25,000: 2,800); no coupon allowance. Floor = lowest price clearing 25% contribution before CAC
**and** 10% after paid CAC (or, for organic-only-tagged combos, 20% after an organic CAC of INR 500) — same
two-part test as the first-100 combos. All at the default timber INR 1,500/cft; recompute when real costs
land.

**D8 and D9 are carried over, not re-invented** — they already exist in the first-100 combo set and are the
two best-fitting combos for Diwali; this plan simply re-launches them with festive creative and the
DHAN26/NAVRATRI26 windows rather than duplicating the margin work. **See the reconciliation note in the
header: D8 (mandir) cannot be configured today — no mandir product exists in the real catalogue — and every
price/cost figure below is on the planning-catalogue placeholders, not confirmed real-catalogue costs.**
Swap in real slugs/prices (header table, or the fuller list in `50-diwali-products.md`) and the workshop's
real costs before touching admin.

| # | Combo (audience) | Items | Separate total | **Price (FIXED_PRICE)** | Saving | Before CAC | After paid CAC | After organic CAC | **Floor** | Tag |
|---|---|---|---|---|---|---|---|---|---|---|
| D1 | **Diwali Pooja Thali Set** (families, puja-corner refresh) | S13 tray (as the thali) + 2 x S15 masala dabba (kumkum/akshat + prasad) | 5,997 | **5,499** | 498 (8.3%) | 1,765 (37.9%) | 265 (**5.7%**) | 1,265 (27.2%) | 5,000 | **Organic-only** (fails the 10%-after-paid test) |
| D2 | **Housewarming Diwali Gift Box** (gifters, personal) | S6 round mirror + S16 wall shelf set + S15 masala dabba | 10,197 | **9,199** | 998 (9.8%) | 2,667 (34.2%) | 1,167 (15.0%) | 2,167 (27.8%) | 8,700 | Paid-eligible |
| D3 | **Corporate Gifting Crate** (B2B, bulk/society/office) | S13 tray + S14 board + S15 dabba + S16 wall shelf | 8,496 | **7,799** | 697 (8.2%) | 2,501 (37.8%) | 1,001 (15.1%) | 2,001 (30.3%) | 7,350 | Paid-eligible; bulk quote at or above floor for 10+ crates, GST invoice, optional paid logo-engraving add-on |
| D4 | **Mithai & Dry Fruit Tray Set** (gifters, low-risk first purchase) | 2 x S13 tray + S14 cutting board | 4,697 | **4,299** | 398 (8.5%) | 1,732 (47.5%) | 1,032 (28.3%) | 1,232 (33.8%) | 3,400 | Paid-eligible, best margin of the set |
| D5 | **Diya & Torans Combo** (gifters, Instagram-led) | Proposed: 1 wooden toran (door hanging) + 1 wooden tealight/diya tray — **NEW SKUs, not in the current catalogue and not costed by the workshop** | ~3,598 (illustrative) | **2,999 (illustrative)** | - | - | - | - | - | **Stretch — do not configure until costed.** At an illustrative 2,999 price, the combined ex-factory cost (wood+labour+finish+hardware for both pieces) must stay **under about INR 950-1,000** to clear the same 20%-after-organic floor the other organic-only combos clear. Reconcile against `50-diwali-products.md` once it lands — it may already contain a costed equivalent. If the workshop cannot confirm a cost under that ceiling by ~14 Oct, **drop this combo for 2026** rather than launch at a loss; D1/D2/D4 already cover festive giftable décor |
| D6 | **Festive Home Refresh** (home-owners refreshing for the festival) | S8 round end table + S6 round mirror + S16 wall shelf set | 12,997 | **11,699** | 1,298 (10.0%) | 3,658 (36.9%) | 2,158 (21.8%) | 3,158 (31.8%) | 10,150 | Paid-eligible |
| D7 | **Return Gift Pack** (bulk distribution — Diwali parties, societies, corporate) | 10 x S15 masala dabba (one combo, quantity 10) | 21,990 | **19,490** (≈ INR 1,949/unit) | 2,500 (11.4%) | 5,397 (32.7%) | 3,197 (19.4%) | 4,897 (29.6%) | 17,400 | Paid-eligible. 25-pack/50-pack available as a quote (same per-unit ratio, bulk corporate route — not a button on site) |
| D8 | **Mandir Corner — Diwali Special** (*carried over from first-100*: S1 mandir 2.5 ft + S3 jaali panel + S13 tray) | — | 24,597 | **21,999** | 2,598 (10.6%) | 6,189 (33.2%) | 21.4% | 30.5% | 19,500 | **Cannot be configured today — no mandir product exists in the real seeded catalogue** (confirmed in the header reconciliation note); either cost and add a real mandir SKU first, or drop this combo and lead Diwali content with D2/D6/D9 instead |
| D9 | **Cook's Diwali Gift Set** (*carried over from first-100*: S13 tray + S14 board + S15 dabba) | — | 5,297 | **4,999** | 298 (5.6%) | 1,861 (43.9%) | 27.4% | 32.1% | 3,850 | Paid-eligible; crosses the INR 4,999 free-delivery threshold, lowest-risk first purchase |

**Launch order:** D9 and D1 first (lightest, ready-stock-able, lowest cash risk — live from 11 Oct Navratri);
D2, D4 next (live from 11 Oct); D8 re-launched 11 Oct with Diwali creative; D3, D6, D7 live from 22 Oct (the
real push, once corporate outreach and paid ads are running); D5 only if costed in time, otherwise skip.

**Psychology, channel, season (brief recap — full method in [first-100/04-combo-strategy.md](../first-100/04-combo-strategy.md)
section 4):**

| Combo | Psychology (honest only) | Primary channel |
|---|---|---|
| D1 Pooja Thali Set | Ritual completeness for Navratri/Diwali puja; low ticket, trial-size brand introduction | WhatsApp broadcast, Instagram, own network |
| D2 Housewarming Gift Box | Gift-ready at a round price; "one thing to bring, not three" decision-fatigue removal | Instagram + WhatsApp |
| D3 Corporate Gifting Crate | GST invoice, repeatable spec, "say thank you without a card"; genuine seasonal B2B angle | Direct outreach to offices/societies (section 5), WhatsApp |
| D4 Mithai & Dry Fruit Tray Set | Low-risk, crosses nobody's "too much" threshold; classic Diwali hosting need | Instagram, Google Merchant free listing |
| D6 Festive Home Refresh | "New look for the puja/living corner without new furniture spend"; bundling anchor | Meta CTWA, Pinterest |
| D7 Return Gift Pack | Solves a real logistics problem (20-50 identical gifts) at a bulk per-unit price; no fake scarcity, the saving is the real combo discount | Corporate/society outreach, WhatsApp broadcast |
| D8 Mandir Corner | Heritage + ritual completeness; the best-modelled carved product | CTWA + Instagram carving reels |
| D9 Cook's Gift Set | Trial-size brand introduction, free-delivery reward framing | Instagram + WhatsApp, Google Merchant |

**Config checklist (admin only, no dev):** name/slug/description stating wood, finish, lead time and what is
customisable; badge text (e.g. "Set of 3 — one invoice"); FIXED_PRICE; enabled India `ComboCountryPricing`
row; `showOnHome` for D8/D9/D1 only; real photo of the assembled set (gate item, do not launch on placeholder
images); test add-to-bag + confirm a coupon is correctly refused on combo lines before go-live.

---

## 4. Coupon strategy (built on the live coupon engine, decision 0035)

Same engine as [first-100/05-coupon-strategy.md](../first-100/05-coupon-strategy.md): PERCENTAGE / FIXED /
FREE_SHIPPING, `minOrderAmount`, `maxDiscount` cap, `userLimit` (default 1), global `usageLimit`,
`firstOrderOnly`, start/end dates, product/category scope, `excludeSaleItems`, `countryCodes = IN`, one
coupon per order (engine rule, unusable coupon rejects the whole order), **BUY_X_GET_Y not supported** (use
combos instead — D7's bulk pack is the workaround). All codes below: `countryCodes = IN`,
`excludeSaleItems = true` (never stacks with the 9 combos above), `userLimit = 1` unless noted.

**Guardrail (reused from first-100):** smallest headroom among coupon-eligible SKUs is the study desk (8%)
and mandir/console/mirror (12-13%); **no blanket percentage coupon exceeds 5%**, and caps stay at
INR 500-750, so a redeemed code can never push a single-SKU price below its floor in
[first-100/03-starter-catalogue.md](../first-100/03-starter-catalogue.md) section 3.

| # | Code | Purpose | Type/value | Cap | Min order | Scope | Limits | Window (IST) | Public? |
|---|---|---|---|---|---|---|---|---|---|
| 1 | **NAVRATRI26** | Early-bird, content-phase incentive on ready-stock-able décor only | PERCENTAGE 5% | INR 750 | INR 4,999 | Categories: mandir/temple, jaali panels, mirrors, kitchen-wood (not furniture, not quote-only) | usage 60 | **11 - 19 Oct** (Navratri) | Yes |
| 2 | **DHAN26** | "Dhanteras collection" — same ready-stock categories, badged for the Dhanteras buying mood, window chosen so it is honestly deliverable by Dhanteras/Diwali | PERCENTAGE 5% | INR 750 | INR 5,499 | Same categories as NAVRATRI26 | usage 50 | **20 - 28 Oct** (ends at the ready-stock cutoff) | Yes |
| 3 | **DIWALI-FLASH** | Real urgency only: the exact remaining ready-stock count, updated weekly from admin stock — **never a fake "only N left"** | FIXED INR 500 | n/a | INR 6,999 | The ready-stock SKUs only, scoped to actual remaining units | usage = the real remaining unit count at launch (owner updates down, never up) | **24 - 28 Oct** | Yes, with the real count shown |
| 4a | **GIFT-\<FRIEND\>** (referral "give", festive-badged) | Friend gets INR 500 off their first order | FIXED INR 500 | n/a | INR 6,000 | All launch singles | usage 5/code, `firstOrderOnly`, expires 90 days | Created on demand, 6 Oct - 30 Nov | No |
| 4b | **THANKS-\<REFERRER\>** (referral "get") | Referrer gets INR 500 off their next order, issued after the friend's delivery is confirmed | FIXED INR 500 | n/a | INR 6,000 | All launch singles | usage 1, expires 6 months | Created after delivery | No |
| 5 | **CORP-\<FIRM\>** | Corporate/bulk gifting — genuine B2B angle for offices/societies buying many single gift items (not combo lines, which coupons cannot touch) | PERCENTAGE 8% | INR 3,000 | INR 10,000 | Kitchen-wood/gifting/décor singles (S13-S16 class) | usage 10/firm, non-public | 6 Oct - 15 Nov (runs slightly past Diwali to catch late corporate orders) | No |
| 6 | **NUDGE-DIW** | Abandoned-cart/quote nudge, sent at D+3 | FIXED INR 300 | n/a | INR 5,499 | All launch singles | usage 40, expires 7 days after issue | 6 Oct - 8 Nov | No |
| 7 | **FIRST100** (carried over unchanged) | Welcome/first-order code, already floor-safe | PERCENTAGE 5% | INR 1,000 | INR 5,499 | All launch singles | usage counts against the same 100-order cap as the first-100 plan, not a new allocation | Stays live through this window | Yes |
| 8 | **WELCOME10** | **Confirmed RETIRED, not reintroduced for Diwali.** Decisions 0040/0041 already flagged that 10% breaks the floor on the desk (8% headroom), both mirrors, the console and the 2.5 ft mandir at default costs — several of which (mirror, mandir) are exactly the Diwali hero SKUs in D2/D6/D8. Reintroducing it for festive volume would be the single easiest way to sell below floor during the highest-volume week of the year | - | - | - | - | - | - | Deactivate in Admin > Coupons this week if not already done |

**Stacking rule:** one coupon per order (engine-enforced); none of the eight codes apply to D1-D9 (all
`excludeSaleItems = true`); a WhatsApp manual concession replaces a coupon, never both; CORP-\<FIRM\> cannot
combine with FIRST100 or any other code.

**Abandoned-online-order gap (reused, OPN-05):** PENDING orders keep their coupon redemption until
cancelled — cancel PENDING orders older than 48 hours weekly, same as the existing runbook, and do this more
often (every 2-3 days) during the 22 Oct - 8 Nov push given higher volume.

---

## 5. Target audience for Diwali India

| Segment | Triggers | Channel | Message | Offer | Price sensitivity |
|---|---|---|---|---|---|
| **1. Home-owners refreshing for the festival** (27-45, own or rent a flat/house) | Diwali deep-clean/decorate tradition; a bonus or festive budget; Navratri→Diwali is the one time of year people redecorate on impulse | Meta CTWA, Instagram reels, Pinterest | "Refresh one corner for Diwali — made to your size, delivered before the day if you order by 28 Oct" | D6 Festive Home Refresh, D8 Mandir Corner, NAVRATRI26/DHAN26 | M — will compare against Flipkart/IKEA for the cheapest option but responds to "made to fit + arrives on time" |
| **2. Gifters — personal** (housewarming, friends/family, Diwali mithai-exchange tradition) | Diwali gift-giving norm (near-universal in the target cities); low-risk first purchase from a new brand | Instagram, WhatsApp broadcast/status, Google Merchant free listing | "A gift with a maker's name, not a generic hamper" | D1 Pooja Thali Set, D2 Housewarming Gift Box, D4 Mithai & Dry Fruit Tray Set | H under INR 3,000, M at INR 4,999+ where free delivery and packaging matter |
| **2b. Gifters — corporate/B2B bulk** (HR/admin/office managers buying 10-100+ gifts; a real seasonal B2B angle, not a stretch) | Diwali is the one guaranteed corporate-gifting occasion of the year in India; GST invoice and a repeatable spec are the actual purchase drivers, not discount | Direct outreach (phone/WhatsApp/email) to offices, housing societies, co-working spaces in Jodhpur/Jaipur/Delhi NCR/Bengaluru; low-cost, high-relevance for a 33-day window exactly as the brief asks for | "One supplier, one invoice, one delivery date for all N gifts" | D3 Corporate Gifting Crate, D7 Return Gift Pack, CORP-\<FIRM\> | L-M — buyer cares about reliability and invoicing more than price once above ~INR 5,000/unit value |
| **3. NRI gifting to India relatives** | Diwali is the top remote-gifting occasion for the diaspora; "I can't be there, let me send something real" | WhatsApp video call + family-side contact (quote-only, same gap as the first-100 plan: non-INR payment gateways are not configured — OPN-01) | "We confirm the piece and the delivery date with your family on a video call before you pay" | D2, D8, quote-only for anything larger | L — this segment pays for reliability and a trusted contact, not price, but the payment-method gap (international cards/transfer) must be solved manually (UPI/bank transfer link) before this is advertised |
| **4. Wedding-season overlap (post-Diwali 2026)** | Indian wedding season restarts after 20 Nov — outside this plan's 8 Nov cutoff, but Diwali content (reels, UGC, reviews) is the asset that feeds the wedding-season push the existing first-100 plan already has queued (C5 Newlywed Home Gift) | Creators, wedding planners (not this plan's spend — flagged for continuity) | - | C5 (existing combo, not re-specified here) | - |
| **5. Interior decorators** | Clients asking for a festive refresh before Diwali house parties; warm, high-leverage channel the existing plan already identified | Direct outreach, lookbook, trade code (TRADE-\<FIRM\> already exists in first-100/05) | "Your client's Diwali deadline, our dated delivery" | D6, D8, custom jaali | M — cares about their own margin and a date they can promise a client |

---

## 6. Budget & channel mix (5-week festive sprint, 6 Oct - 8 Nov)

Reuses the scenario structure and funnel formulas in
[first-100/07-channel-mix-and-budget.md](../first-100/07-channel-mix-and-budget.md), compressed to this
window and uplifted for festive CPM/creator-rate inflation (web-verified below). **All figures below are
ASSUMPTION/ESTIMATE**; the first INR 10,000-15,000 spent is the real test, same rule as the base plan.

### 6.1 Real festive-season cost data found (India, 2025-2026 seasons; cited, no furniture-specific benchmark exists anywhere)

- Meta: baseline India CPM Facebook ~INR 30-120, Instagram ~INR 50-180 depending on targeting; **CPMs spike
  during the festive season** (climbing from mid/late September, roughly six weeks before Diwali, across
  electronics/apparel/jewellery/gifts categories) — ESTIMATE, [superads.ai India CPC/CPM data](https://www.superads.ai/facebook-ads-costs/cpc-cost-per-click/india) (accessed 2026-10-06).
  We apply a **+20-30% festive uplift** to the base-plan's CPM/CAC assumptions for the 22 Oct - 8 Nov window
  — ASSUMPTION, no home-décor-specific number exists.
- Influencers: **festive-season rate cards are 15-30% higher than off-season**, with short-form/reel content
  up 25-30%; nano influencers (1K-10K) typically INR 500-5,000 per reel/post, micro (10K-100K) INR 2,000-
  80,000 depending on format; nano/micro accounted for ~75% of festive creator bookings in 2025 with 3-7x
  the engagement rate of celebrity campaigns — ESTIMATE, [Social Samosa, "Influencer rate cards surge 15-30% as brands spend ₹700 crore this festive season"](https://www.socialsamosa.com/experts-speak/influencer-rate-cards-surge-brands-spend-700-crore-festive-season-10479915) (accessed 2026-10-06),
  [exchange4media festive ad-rates piece](https://www.exchange4media.com/festive-season-news/influencers-cost-sheet-festive-ad-rates-up-10-30-25-30-more-for-short-form-content-147770.html) (accessed 2026-10-06).
  We therefore price creators at the **top of** the existing first-100 creator-rate range (nano cash
  INR 3,000-8,000, micro INR 10,000-25,000), not the bottom.
- Marketplaces (Amazon/Flipkart festive sale slots): CPC for sponsored product listings during festive sale
  periods typically runs INR 1-5 for most categories, rising to INR 5-10 for competitive categories during
  the sale window — ESTIMATE, [Fibre2Fashion Big Billion Days ads playbook](https://emerge.fibre2fashion.com/blogs/10896/how-to-prepare-for-big-billion-days-or-great-indian-festival-inventory-coupons-and-ads-playbook) (accessed 2026-10-06).
  **Not usable for this plan**: both platforms' 2026 festive sale windows (Big Billion Days/Great Indian
  Festival) run late September into early October, already closing or closed by the time this document is
  written, and new-seller onboarding/catalogue-approval on either marketplace realistically takes longer
  than the 33 days remaining — same honest conclusion as the US marketplace-timeline finding elsewhere in
  this project. **Recommendation: evaluate marketplace presence for the next cycle (Holi/wedding season
  2027), not this one.**

### 6.2 Three scenarios for the 33-day window

| Line (INR, whole window) | **Lean** | **Base (recommended)** | **Growth** |
|---|---|---|---|
| Meta CTWA + retargeting (staged: ~0 during Navratri, ramps 22 Oct) | 15,000 | 45,000 | 150,000 |
| Google Search (T1 terms only, if Gate A closes in time) | - | 8,000 | 20,000 |
| Creators (nano barter + 2-3 nano cash + 1 micro, festive-rate-adjusted per 6.1) | 6,000 | 28,000 | 55,000 |
| Corporate/B2B outreach (lookbook, samples, visits — the genuine low-cost high-relevance channel) | 2,000 | 10,000 | 20,000 |
| Content production (Diwali reels, 1 extra shoot day) | 5,000 | 12,000 | 20,000 |
| WhatsApp broadcast/CRM tool, samples, festive-fragile packaging upgrade | 5,000 | 12,000 | 21,000 |
| Contingency | 3,000 | 8,000 | 20,000 |
| **Total marketing spend (33 days)** | **~39,000** | **~1.30 lakh** | **~3.16 lakh** |
| Also needed, not in this table | Ready-stock cash ~INR 1.1 lakh (section 1, A9) — same for every scenario, this is inventory, not marketing spend | same | same |

**Recommendation: Base, staged** — spend at the Lean rate through Navratri (11-19 Oct, content-only, matches
the owner's own framing of that window), step to full Base from Dussehra/22 Oct **only if** Gate A has
closed, hold at Lean/organic-only if it has not. Growth is **not recommended** this cycle: ready stock is
capped at ~45 units (section 1, A9) and the workshop's custom capacity was never confirmed for this volume
(see risks, section 8) — Growth-level ad spend would mostly buy backlog and broken delivery promises, not
orders, the same capacity-vs-demand failure mode the original first-100 plan already flagged for its own
Growth scenario.

### 6.3 Funnel math and expected orders by Diwali

Base funnel assumptions reused from [first-100/01](../first-100/01-owner-input-sheet.md) D1-D7 (CPM ~200,
CTR 0.9%, click-to-chat 40%, qualified 35%, quoted 75%, cold close 8%, warm close 20%), with the **+20-30%
festive CPM uplift** from 6.1 applied for the 22 Oct - 8 Nov window, pushing base CAC from ~INR 2,650 to
roughly **INR 3,200-3,500** (ESTIMATE) during the push.

| Scenario | Paid orders (range) | Organic/WhatsApp/referral/corporate orders (range) | **Total orders by 8 Nov (range)** | All-in cost/order |
|---|---|---|---|---|
| Lean | 3-8 | 10-18 (own network + early corporate outreach) | **15-25** | ~INR 1,600-2,000 |
| **Base (recommended)** | 8-22 | 15-28 (own network, corporate crates/return-gift bulk, referral, Navratri-phase community building converting in the push) | **25-45** | ~INR 2,900-3,900 |
| Growth | 20-45 (theoretical) | 20-35 | **40-65 theoretical, ~35-45 realistically achievable** (capped by ready-stock units + unconfirmed custom capacity) | ~INR 5,000-6,500, worse if capacity breaks |

**Why Base here is more optimistic than the original first-100 plan's own week-6 figure (~10 cumulative
orders):** that plan assumed Gate A closes 16 Oct and ramped corporate/referral channels only from week 8+.
This plan assumes Gate A closes ~12 Oct (so the Navratri window isn't wasted) and works corporate/bulk
gifting and referral hard from day one of the push, because Diwali is specifically the one occasion where
those channels convert fastest. **If Gate A slips past 20 Oct, this reverts to the original 10-15-order
trajectory** — do not spend Base money against an unmet precondition; fall back to Lean and treat the window
as content/community-building for the post-Diwali wedding-season push instead.

**Stop/scale rules:** reuse [first-100/07](../first-100/07-channel-mix-and-budget.md) section 8 unchanged
(pause 48h if INR 3,000 spent with zero qualified conversations; CAC ceiling INR 3,000-3,500 during the
festive uplift; never scale on clicks/likes/followers alone).

---

## 7. Operational readiness — what must be true before spending

Reuses the Gate A checklist from [first-100/02-launch-readiness-gate.md](../first-100/02-launch-readiness-gate.md)
and the live findings in [docs/ux/customer-psychology-gap-tracker.md](../../ux/customer-psychology-gap-tracker.md),
re-checked for currency on 2026-10-06:

| Item | Status as of this write-up | Blocking? |
|---|---|---|
| Real WhatsApp Business number, phone, Instagram | **Still placeholder** (`whatsapp_number` = `919876543210`, `site_phone` = `+91 98765 43210`, `instagram_url`/`facebook_url` empty — gap tracker CON-02/LOW-01, confirmed open) | **Yes — P0, blocks every paid-ad and festive-coupon activity.** No ad or coupon in section 4 should go live while this is true: a click-to-WhatsApp ad pointing at a stranger's number is the single worst thing this plan could ship |
| COD/payment gateway live keys | Razorpay/Cashfree configured in code (decision 0027 fixed the currency-mischarge bug) but third-party keys are **placeholders** in `.env` per this repo's own `CLAUDE.md` | **Yes — P0 for any on-site checkout spend.** UPI/payment-link fallback on WhatsApp works regardless (same workaround as the base plan) |
| Fake testimonials/artisans/blog still on site | Open (AWR-01, gap tracker) | **Yes — P0**, same as every other campaign in this project; cannot run paid traffic to a page with fabricated social proof |
| Real photos of the ready-stock Diwali SKUs | Not yet shot as of this write-up | **Yes — P0** for D1/D2/D4/D8/D9, which all launch in the Navratri window |
| Return/shipping policy pages honest for made-to-order and gifting | Open (CON-xx items in the gap tracker: policy pages still reference non-furniture-era store-credit/36-hour return language) | **Yes — P0 before any gifting-focused ad**, since gift-givers specifically ask about returns for the recipient |
| Packaging for festive fragile items (mandir, jaali, mirrors) | Untested (same R11 risk as the base plan: ~7.6% of furniture pieces reported scuffed in transit, ESTIMATE) | **P1** — trial-ship 2-3 D8/D2 combos to friends in Delhi/Mumbai/Bengaluru before the 22 Oct push |
| 9 combos + 8 coupons configured in admin | New work for this plan (sections 3-4), not yet done | **P0**, config only, no dev needed |
| Ready-stock count confirmed in writing by the workshop | Not yet confirmed (section 1, OWN-3) | **P0 — do not publish the 28 Oct cutoff date until this exists** |

**The honest bottom line:** none of the P0 items above are new problems — they are the same Gate A items the
original first-100 plan already listed as open on 25 Sep and that remain open today, 11 days later. **This
week's real task is closing Gate A, not writing more strategy.**

---

## 8. Risks

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| **Production capacity vs. demand spike** — ready stock capped at ~45 units (section 1, A9), workshop custom capacity for this volume never confirmed | H | H | Do not advertise beyond the confirmed ready-stock count; cut DIWALI-FLASH usage limit to the real remaining count weekly; stop scaling ads the moment backlog exceeds the ready-stock buffer |
| **COD RTO during festive rush** — COD return rates run materially higher than prepaid (ESTIMATE, same source base as the first-100 risk file) and festive-season parcel volume stresses every courier's RTO handling | M | H | No COD on made-to-order; small-parcel COD only with the existing INR 300 deposit; watch RTO weekly on D1/D4/D9 (the lowest-ticket, most COD-exposed combos) |
| **Courier delays close to Diwali** — every courier network in India is at peak festive volume in this exact window, independent of anything specific to this brand | H | H | Build in the 4-7 day transit buffer already in A3-A6; do not promise the 28 Oct cutoff without a written confirmation from the actual courier; prefer Rajasthan/NCR lanes (shorter, less congested) for the highest-value combos |
| **Competing with every other brand's Diwali sale** — Wooden Street, Woodsala, Urban Ladder, Flipkart sellers all run festive campaigns in the same window | H | M | Differentiate on the five USPs already established in [positioning-and-usp.md](../positioning-and-usp.md): real wood named, a delivery date kept, workshop visibility, repair-first warranty, one honest price — **never** compete on "biggest Diwali discount"; the combos above save 5.6-11.4%, not 30-50%, which is the honest ceiling this business can sustain |
| **Cash flow** — ready stock (~INR 1.1 lakh) plus marketing spend (INR 39k-1.3L) plus the existing 16-week plan's own fixed costs all land in the same 5 weeks | H | H | Owner decision explicitly needed this week (section 1, OWN-2); advance payments (40-100% depending on order value) soften timing but do not remove the cash-negative period, same conclusion as the base plan's section 3 |

---

## 9. Owner decisions needed THIS WEEK (6-12 Oct)

1. **Budget available for this push** (section 1, OWN-1) — Lean ~39k, Base ~1.3 lakh, Growth ~3.16 lakh (not
   recommended).
2. **Cash available** for ready stock (~1.1 lakh) + marketing concurrently with the existing 16-week plan's
   own spend (OWN-2).
3. **Real WhatsApp Business number, phone, Instagram** — must be live before any ad or coupon in this plan
   goes out; this is a same-day config task, not a dev task.
4. **Confirm in writing with the workshop**: how many of the A9 ready-stock units can genuinely be
   built/finished by 28 Oct, and whether today's real ex-factory costs still clear the floors in section 3 —
   do not publish the Diwali-delivery cutoff until this exists.
5. **WELCOME10: confirm retirement** (section 4, item 8) — low-effort, high-protection, should be done this
   week regardless of the rest of this plan.
6. **Swap every combo's planning-code items for real catalogue slugs and real workshop costs** before
   configuring anything in admin (header reconciliation note + the price-gap table there) — this is the
   single most concrete piece of unfinished work in this document. `50-diwali-products.md` landed while this
   was being written and independently confirms: no mandir product exists (D8 cannot be configured as
   named), and it separately proposes the same two new-SKU ideas as D5 (a hand-carved sheesham door toran
   with brass bells, and a jaali tealight lantern) — corroborating that D5 is a real gap worth costing, not
   just this document's invention, but it is still **not yet costed by the workshop** either way.

---

## 10. Sources (web-verified, 2026-10-06)

- [Social Samosa — "Influencer rate cards surge 15-30% as brands spend ₹700 crore this festive season"](https://www.socialsamosa.com/experts-speak/influencer-rate-cards-surge-brands-spend-700-crore-festive-season-10479915)
- [exchange4media — "Influencers cost sheet: Festive ad rates up 10-30%, short-form content sees 25-30% rise"](https://www.exchange4media.com/festive-season-news/influencers-cost-sheet-festive-ad-rates-up-10-30-25-30-more-for-short-form-content-147770.html)
- [superads.ai — Facebook/Instagram ad cost benchmarks, India](https://www.superads.ai/facebook-ads-costs/cpc-cost-per-click/india)
- [Fibre2Fashion — "How to Prep for Big Billion Days / Great Indian Festival: Inventory, Coupons, and Ads Playbook"](https://emerge.fibre2fashion.com/blogs/10896/how-to-prepare-for-big-billion-days-or-great-indian-festival-inventory-coupons-and-ads-playbook)
- [shubhpanchang.com — Dhanteras 2026 date](https://shubhpanchang.com/festivals/dhanteras)
- [universaltimedate.com — Dhanteras 2026](https://www.universaltimedate.com/holidays/dhanteras)

All other figures are reused from, and kept arithmetically consistent with, the India-first documents listed
in the header (unit-economics-model.md, first-100/*, india-market-price-benchmark.md,
india-competitor-analysis.md, positioning-and-usp.md) — no new cost or conversion data was invented.
