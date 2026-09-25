# 10. Risks and unknowns

Part of [../first-100-orders-plan.md](../first-100-orders-plan.md). Date: 2026-09-25. L = likelihood, I = impact (H/M/L, our judgement). "Unknown" means nothing in the docs or our research answers it; a named owner input or a first experiment resolves it.

## A. Money and cost

| # | Risk / unknown | L | I | Why it matters | What resolves it / mitigation | Owner |
|---|---|---|---|---|---|---|
| R1 | **Timber cost per cubic foot** is unknown; 900 vs 2,200 swings most SKUs from healthy to negative ([03](03-starter-catalogue.md) section 4) | H | H | Every price, floor and combo depends on it | Fill B1 and B4 with real purchase invoices; recompute floors before printing prices; recheck monthly | Owner |
| R2 | **Nine of our SKU cost rows are unit-economics rows; eleven new SKUs have invented costs** for the calculation | H | H | Floors and combo margins are placeholders | Carpenter team costs each SKU (timber, labour, carving, polish, hardware, packing) in one afternoon | Workshop lead |
| R3 | **The "30% below market" advantage is unproven**; we may be at or below Woodsala's cost | M | H | If real cost is above the unit-economics "max cost for 20%" columns the price ladder fails | Compare real costs with [../unit-economics-model.md](../unit-economics-model.md) section 5; raise prices toward Woodsala parity | Owner |
| R4 | **Paid CAC is a guess** (no furniture-specific India benchmark) and base CAC leaves only about INR 900 per order before fixed costs | H | H | The first 100 orders may cost more than they earn | Spend the first INR 10,000-25,000 as a test; stop/scale rules ([07](07-channel-mix-and-budget.md) section 8) | Marketing lead |
| R5 | **Cash-negative for 16 weeks** in every scenario (about -1.5 to -2.4 lakh in A-C at default fixed costs) plus ready-stock cash (about INR 1.1 lakh) | H | H | Owner cash needs | Decide scenario deliberately; advances reduce timing risk only; Lean scenario if cash is tight | Owner |
| R6 | **GST**: rate per product family conflicting (18% vs 12% vs 5% for décor); GST on advance payments and invoice timing not researched | M | M | Margin and invoicing correctness | CA confirms; add to gate A11 | CA |
| R7 | **Freight and ODA charges** unknown for Jodhpur to metros; heavy pieces carry surprise surcharges | H | M | Damage and cost both live in freight | Two written quotes per lane (B6); bulky-goods rules per pincode (decision 0015); quote freight per order on furniture | Owner |
| R8 | Payment gateway fees and **gateway approval for furniture/made-to-order** (some gateways review advance-based models) | M | H | Cannot collect on site | Apply now; ask Razorpay and Cashfree about made-to-order; keep UPI/bank/payment-link fallback | Owner |
| R9 | Coupon leakage and stacking; PENDING orders keep redemptions (OPN-05) | M | M | Margin erosion | [05](05-coupon-strategy.md) guardrails; weekly ledger | Accounts |

## B. Operations, logistics and quality

| # | Risk / unknown | L | I | Why it matters | Mitigation | Owner |
|---|---|---|---|---|---|---|
| R10 | **Capacity**: unknown workshop output; Base scenario nears the default capacity at peak, Growth exceeds it | H | H | Late delivery kills the "date we keep" USP | Fill A1/A2; stop scaling at a 10-day backlog; subcontract standard pieces | Workshop lead |
| R11 | **Damage in transit; packaging and courier for furniture untested** (about 7.6% of pieces arrive scuffed is a blog estimate; our allowance is 3%) | H | H | Damage is the #1 review and refund driver for furniture | Trial-ship 2-3 pieces to friends in Delhi/Mumbai/Bengaluru before ads; corner guards, foam, crate; delivery video; courier choice; consider transit insurance (not researched) | Workshop lead |
| R12 | **COD RTO** (COD return rate about 26% vs prepaid under 2%: ESTIMATE) | M | H | Bulky return freight loses more than the margin | No COD on made-to-order; small-parcel COD with INR 300 deposit; advance rules ([08](08-customisation-offer.md) section 4) | Owner |
| R13 | **Lead times slip** (competitors deliver in 4-9 weeks vs the 18-30 they publish) | H | H | Broken promises are the top complaint category | Publish only what the workshop confirms; message before slips; buffer of 3 working days | Workshop lead |
| R14 | Diwali cut-offs missed because ready stock is not built | H | M | Diwali gifting is a short window | A9-A10; no promise without written confirmation | Owner |
| R15 | Carpenter availability, festival closures, illness | M | M | Capacity | A11 blackout dates; second carpenter on standard pieces | Workshop lead |
| R16 | Returns or disputes on customised pieces; policy contradictions on the site | M | H | Site currently states a 36-hour store-credit return, 1-2 day dispatch | Replace policies (gate A6); written spec sheet per order | Owner |
| R17 | WhatsApp-closed sales are invisible to the site's coupon/UTM reports (until gate B8) | H | M | Attribution and inventory mismatch | Lead sheet as the source of truth; one weekly reconciliation with site orders | Marketing lead |

## C. Trust, claims and compliance

| # | Risk / unknown | L | I | Why it matters | Mitigation | Owner |
|---|---|---|---|---|---|---|
| R18 | **New-domain and new-brand trust**: no reviews, no orders, 0 followers, site noindex until go-live | H | H | High-ticket purchases from an unknown brand convert poorly | Workshop video, real people with consent, written spec sheet, GST invoice, workshop visits, video call, real reviews from the first 10 customers, Google Business Profile | Marketing lead |
| R19 | **Fake content still on the site** (testimonials, artisans, blog, seed photos) | H | H | Consumer-protection exposure and instant loss of credibility | Gate A4 before any ad | Owner |
| R20 | **Claims honesty**: teak/solid/handcrafted/kiln-dried/lifetime/30% cheaper/free returns | M | H | ASCI and consumer-protection exposure (we assert no law; lawyer to advise) | [../positioning-and-usp.md](../positioning-and-usp.md) section 6 list; approval checklist per post ([../social/09-production-and-compliance.md](../social/09-production-and-compliance.md)) | Marketing lead |
| R21 | Comparative advertising and price comparison (naming Woodsala/Wooden Street) | M | M | Legal risk | Do not name competitors in ads; keep dated screenshots; lawyer view | Owner |
| R22 | Consent, privacy and retention of lead data (Leads store phone, city, needs); privacy policy wording; India's data-protection rules not researched | M | M | OPN-15 open | Privacy page mentions leads; delete on request; lawyer to confirm | Owner |
| R23 | **Influencer disclosure** (ASCI #ad) and creator claims | M | M | Fines/reputation | Written brief, disclosure check before payment | Marketing lead |
| R24 | Carpenter and customer consent for photos and video | M | M | Rights | Signed consent; credits | Marketing lead |
| R25 | Photo credits and licences (CC BY seed images) | M | M | OPN-12 | Remove or add credits page | Marketing lead |

## D. Channels, platforms and systems

| # | Risk / unknown | L | I | Why it matters | Mitigation | Owner |
|---|---|---|---|---|---|---|
| R26 | Meta ad account restrictions on a new account/business; disapproved ads; WhatsApp Business messaging limits or a spam block on a fresh number | M | H | The main channel could stop | Verify the business early, follow ad policy, warm up the WhatsApp number with normal conversations, two admins and 2FA, keep an Instagram DM route; limits not verified here | Marketing lead |
| R27 | Low-quality/bot leads from CTWA | M | M | Wasted sales-desk time | Qualifying questions, ice-breakers, ad copy with price band and city | Sales desk |
| R28 | Sales desk overloaded (about 50 chats/day at Base) | H | H | Unanswered leads waste spend | 2 people, quick replies, labels; cut ads before SLA | Owner |
| R29 | **Geo-lock may misroute real Indian buyers** (VPN, mobile carrier IPs) and product pages failed once (nginx X-Forwarded-For bug) | M | H | Paid clicks could land on `/not-available` | Gate A9 test on three networks; watch bounce from ads; lead-capture on the not-available page is a logged follow-up (GLB-04) | Ops |
| R30 | Single VPS, no CDN, no off-host backups, no monitoring (OPN-10) | M | H | An ad spike or outage burns spend | Verify uptime before scaling; resize; backups; uptime monitor (free tier) | Ops |
| R31 | Tracking gaps: first-touch UTM, WhatsApp chats invisible, no Meta pixel, no combo events | H | M | Cannot prove which ads work | Lead sheet + `ref:` codes + labels; KPI sheet ([../master-growth-plan.md](../master-growth-plan.md) section 4) | Marketing lead |
| R32 | SEO expectations: new domain, noindex, no backlinks; organic search contributes a handful of orders by 90 days | H | L | Over-reliance | Treat as a month 4-6+ channel ([../../seo/india-seo-plan.md](../../seo/india-seo-plan.md) 6.5) | Marketing lead |
| R33 | Marketplace strategy for India (Amazon.in/Flipkart) not researched in depth (blocked pages) | M | M | An alternative channel for kitchen wood/gifts | Assess after order 30; keep the owner's brand-price discipline | Owner |
| R34 | Export: US tariffs/CITES/freight change fast; single-piece express parcels lose money at USD 25-39 retail | H (if attempted) | H | Not part of the first 100 | Do not launch export before order 100; B2B sample route later ([../unit-economics-model.md](../unit-economics-model.md) section 6) | Owner |

## E. Assumptions most likely to be wrong (test first)
1. Organic orders (35 in 16 weeks): least evidenced number; measure weekly from week 2.
2. Cold quote-to-order close of 8%: the biggest lever after CAC; measure per 30 quotes.
3. Click-to-WhatsApp conversion (40%) and qualification (35%).
4. Order mix and AOV (INR 12,600): check at order 20.
5. Cost inputs for the eleven new SKUs.
6. Lead times and Diwali capacity.
