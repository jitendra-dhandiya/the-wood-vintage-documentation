# US and UAE SEO plan — export pilot (USA, hybrid) and secondary (UAE)

> **SUPERSEDED FOR THE USA BY [us-seo-plan.md](us-seo-plan.md) (2026-09-25).** The US half of this plan assumed India first and a small-décor Etsy pilot; the USA is now market #1 (B2C). The UAE half (B2B research) still stands.

Date: 2026-09-25. Tags: VERIFIED / ESTIMATE / ASSUMPTION. Development is ON HOLD; this is a plan and a set of preconditions, not a launch instruction.
Phase-1 conclusion (`countries/market-selection.md`): first 100 orders = India D2C; export pilot = USA via hybrid (Etsy/Amazon for small décor + B2B/quote leads) after orders ~30-50; UAE secondary, pending price/competitor data (not found). See also
[india-seo-plan.md](india-seo-plan.md), [technical-seo-checklist.md](technical-seo-checklist.md). Profiles: `countries/us.md`, `countries/uae.md`.

## 0. Bottom line
1. **Do not invest in own-site US or UAE SEO until the preconditions in section 5 are met.** Today `/us` is a preview market with sample prices (decision 0031), online payment for non-INR is refused (0027), no US carrier/tax/legal build exists, and the geo-lock (0036) shows overseas humans "not available" for any market that is not enabled. Ranking for US searchers to a page they cannot buy from is wasted effort and creates bad engagement signals.
2. **The US search surface for small handmade décor is Etsy and Amazon, not our domain.** Marketplace SEO (titles/tags/attributes/reviews) is the first US "SEO" investment; own-site US SEO is second, and B2B/wholesale content is a parallel low-cost track.
3. **UAE**: most attractive on duty/compliance (`market-selection.md` 4.2) but we have no demand/price data; a 2-week research spike (section 4.1) before any build.
4. Everything here is sequenced *after* India go-live so learning from India (reviews, photos, custom process, content) transfers.

---

## 1. What changes versus India (US)

| Topic | India (`/in`) | USA (`/us`) | Action |
|---|---|---|---|
| URL/hreflang | `en-IN` + `x-default` | add `en-US`; reciprocal tags on every page that exists in both markets; x-default stays `/in` (technical checklist 4) | Only after `/us` is enabled AND publicly indexable |
| Currency/price display | INR incl. GST | USD; tax shown as "sales tax calculated at checkout" or included by marketplace; **DDP (duties paid) vs DAP** must be stated in snippet text and Product schema shipping | Content + schema |
| Structured data | `priceCurrency: INR` from country (0023 fix) | `USD`, `shippingDetails.shippingDestination: US`, `deliveryTime` in business days incl. sea/air, `hasMerchantReturnPolicy` per US policy (custom = final sale; damage = replacement) | W-14 variant |
| Spelling/units | Indian English, cm/ft | US English ("color", "finish", "gray"), inches/lb (0039 size system supports units — confirm inches display) | Copy + templates |
| Wood naming | "sheesham" is mainstream | Buyers search **"sheesham wood" (niche), "Indian rosewood" (recognised), "mango wood", "acacia wood", "reclaimed wood", "solid wood"**; "rosewood" alone maps to Brazilian/other Dalbergia and to CITES-listed species. Etsy lists `sheesham wood decor` (https://www.etsy.com/market/sheesham_wood_decor - noted in `us.md`). **Use "sheesham (Indian rosewood)" with the botanical name, and lead with mango/acacia/solid-wood terms for categories where mango/acacia is the actual wood.** Never call sheesham "rosewood" alone (buyers may assume protected Brazilian rosewood; CITES Appendix II for Dalbergia sissoo, `market-selection.md` 4.1). | Keyword map US |
| Legal/compliance messaging | GST invoice | Lacey Act plant declaration (importer), CITES rule (< 10 kg per item no permit, > 10 kg permit/Vriksh), Prop 65 (ASSUMPTION), duties (10% Section 301 on India from 24 Jul 2026, 25% Section 232 on upholstered wooden seating; de minimis $800 suspended - `market-selection.md` 4.2) | State honestly on shipping/FAQ pages; do not hide duty in snippets |
| Delivery expectation | 3-10 days | Courier 5-10 days (expensive: ~INR 918-1,118/kg DHL, `market-selection.md` 4.3) vs sea LCL 28-42 d / FCL 6-10 wks | Snippet: "Ships from India, 2-3 weeks", not "fast" |
| Search engines | Google.co.in dominant | Google.com; Bing ~ meaningful share (ESTIMATE) | Both |
| Language/support time | IST | IST +9.5-12.5 h from US zones -> async support, WhatsApp/email SLA | Content |

## 2. US keyword strategy (relative tiers only; no volumes obtained)

Method: same tiering as `keyword-map-india.md` (D/K/priority) — **volumes not available**; owner pulls real data (Keyword Planner with location United States, Google Trends US, Ubersuggest, Etsy search suggest, Amazon.com autosuggest, Pinterest suggest, eRank free/Marmalead trial for Etsy). Template columns identical to India sheet plus `platform` (Google / Etsy / Amazon / Pinterest).

| Cluster | Example keywords | Surface | D / K (ESTIMATE) | Target |
|---|---|---|---|---|
| Etsy/handmade décor | hand carved wood wall panel; sheesham wood decor; indian carved wooden mirror; jharokha mirror; wooden spice box; hand carved wooden tray | Etsy, Pinterest | M / Med | Etsy listings (section 3) |
| Rustic/reclaimed | reclaimed wood console table; rustic solid wood dining table; mango wood coffee table; acacia wood furniture; live edge coffee table | Google, Wayfair-dominated | H / Hard | Own-site content + B2B; unrealistic to rank early |
| Provenance | handmade furniture from India; Jodhpur furniture; fair trade Indian furniture; Rajasthani carved furniture | Google | L-M / Win | Guides |
| Materials | sheesham wood vs mango wood; is sheesham wood good; what is Indian rosewood furniture; mango wood furniture pros cons | Google | M / Win | Guides in US English |
| Custom/wholesale | custom wood furniture manufacturer India; wholesale wooden furniture India; buy furniture direct from India; wood furniture container import; private label furniture India | Google, Alibaba/IndiaMART/Thomasnet | M / Med | B2B page + quote form (0034) |
| Gifts/decor seasons | housewarming gift wooden; Diwali decor USA; Indian wedding gifts; Christmas wooden ornaments | Etsy, Google | M / Med | Seasonal Etsy/Pinterest |
| Large furniture | sheesham bed, dining table set solid wood | Google | H / Hard | **Skip** (duty + freight + CITES permit > 10 kg; single-piece DTC not viable, `us.md`) |

## 3. Etsy/Amazon as the search surface (small décor, < 10 kg per piece)

- **Etsy**: 13 tags with long-tail phrases, title first 40 characters carry most weight; ranking = query match + listing quality (CTR, conversion, favourites) + shop experience (2026 seller-guide summaries, third-party: https://blog.marmalead.com/etsy-algorithm-2026/ accessed 2026-09-25 - ESTIMATE); fill all attributes (material, colour, room, occasion, style); 5-10 photos + video; shipping profile with realistic "ships from India, 2-3 weeks" (Etsy reviews penalise slow shipping); origin story in About; "Made to order" processing times set honestly. Etsy handles payments and sales tax as marketplace facilitator (`us.md`; ASSUMPTION - verify for India-based sellers, payouts, eligibility).
  - Title formula: `[Hero keyword phrase] | [Material] [Object] | [Style/origin] | [Gift/room]` e.g. "Hand carved wood wall panel | Sheesham wood Krishna temple art | Indian home decor | Housewarming gift".
  - Tag ideas: `indian home decor`, `hand carved wall art`, `sheesham wood`, `krishna wall panel`, `housewarming gift`, `boho wall decor`, `rustic wood decor`, `wooden wall hanging`, `carved wood plaque`, `diwali decor`, `spiritual gift`, `hindu wall art`, `handmade in india`.
- **Amazon.com (Global Selling from India)**: Home & Kitchen shows strong growth claims (35% YoY from a weak source, `us.md`) but furniture category rules/fees for India-to-US must be confirmed on sell.amazon.in/global-selling (search 2026-09-25 returned only general guides: register, W-8BEN, EIN) - **VERIFY before committing**. Amazon title: `[Brand] [Product] - [Material] [Dimensions] [Use], Handmade in India`; 5 bullets; A+ content; backend keywords (US synonyms). Fulfilment: FBA needs inventory in the US (not for made-to-order) vs FBM ship-from-India (long delivery hurts ranking).
- **Wayfair/other**: supplier onboarding (CastleGate) - B2B, not SEO; evaluate only after a container test.
- Marketplaces give reviews faster than own-site SEO; reuse photos/video, and collect reviews in India first for credibility.

## 4. UAE plan

### 4.1 Research spike first (2 weeks, before any build) — data we do NOT have
Competitor and price bands: IKEA UAE, Home Centre / Home Box, Pan Emirates, Danube, Amazon.ae, Noon, specialist Indian-origin stores (found 2026-09-25: Wooden Twist - Saharanpur brothers, showroom in Sharjah since 2023, 100,000+ orders claimed; Urban Oak - solid wood; Wood Culture - teak/rattan Dubai custom; Pinky Furniture - Sharjah workshop, Indian designs. https://woodentwist.ae/ , https://urbanoak.ae/ , https://woodculture.ae/ , https://pinkyfurniture.com/). This shows **local workshops already serve the Indian-diaspora and expat niche** (Sharjah/Dubai), so our advantage would be price/quality/custom from India, not novelty. Need: Keyword Planner (UAE), Google Trends UAE, Amazon.ae/Noon top listings, price ladder, demand segments (diaspora vs expat vs Emirati), Arabic search behaviour.

### 4.2 What changes for UAE (if researched positively)
| Topic | UAE plan |
|---|---|
| Engines/marketplaces | Google.ae (English + Arabic), Amazon.ae, Noon, Instagram-led buying (ASSUMPTION), Facebook Marketplace/Dubizzle for used/local; local shops win "near me" |
| Language | **English first**, Arabic later. Arabic is a separate demand pool ("اثاث خشب" etc.); do not machine-translate: hreflang `en-AE` + `ar-AE` on Arabic pages with RTL, native review. Start with English pages for the diaspora; add Arabic only after English shows traction |
| URL | `/ae` (decision 0004 already uses `ae` for the UAE) + hreflang `en-AE` (+ `ar-AE` later) |
| Currency/tax | AED, 5% VAT shown; duty 5% GCC CIF but India-UAE CEPA can give 0% on ~80% of lines with certificate of origin (`market-selection.md` 4.2) - state in FAQ "duty handled/paid" |
| Delivery | Sea India->Jebel Ali short (transit not verified); courier cheaper than US (rate not found); timezone IST -1.5 h |
| Payments | Cards, COD (common, ASSUMPTION), BNPL Tabby/Tamara (ASSUMPTION) — payments build is a precondition |
| Content | Home décor and majlis/floor seating? (ASSUMPTION - verify demand); Ramadan/Eid/National Day gifting calendar; villa/apartment sizing; "furniture direct from India" guides; corporate/hospitality custom (cafés, hotels) as B2B lead content |
| Keywords (relative tiers, to be verified) | "Indian furniture Dubai", "solid wood furniture Dubai / Sharjah", "sheesham furniture UAE", "custom furniture Dubai", "wooden furniture online UAE", "majlis furniture", "carved wooden furniture" | 

## 5. Preconditions before investing in own-site US/UAE SEO (checklist)
(from `countries/market-selection.md` sections 5 and 7; all currently ABSENT unless noted)

| # | Precondition | Status |
|---|---|---|
| 1 | India go-live done, first 30-50 orders fulfilled, reviews/photos gathered | Pending |
| 2 | Enabled market row (`/us` or `/ae`) with **real** local prices (not 0031 sample) and per-product enablement (0032) | Pending |
| 3 | Online payment for USD/AED (Razorpay International ~3% (2026, razorpay.com), or Stripe/PayPal - availability for Indian merchants not verified) — 0027 guard extended | Pending |
| 4 | Tax model: US sales tax (marketplace facilitator vs own nexus), UAE VAT display, GST export handling (LUT), seller-of-record decision | Pending |
| 5 | Carrier/forwarder + DDP/DAP policy + realistic shipping-rate rules (0031's flat $39 is unrealistic for furniture) | Pending |
| 6 | Legal pages per market (returns for custom = final sale, damage replacement policy, privacy, Lacey/CITES statement, Prop 65 check) | Pending |
| 7 | Product compliance fields: species, country of harvest, HS code, per-item weight (10 kg CITES rule), packed dimensions | Pending |
| 8 | Export paperwork: IEC, EPCH membership (Vriksh), AD code, packaging (ISPM-15), damage rate data | Owner Q4/Q5 |
| 9 | Geo-lock decision: an enabled `/us` lets US visitors buy; overseas diaspora currently see "Not available" (0036) - and the crawler exemption must be verified-not-spoofable (technical checklist 5) | Pending |
| 10 | Support model across time zones; WhatsApp/email SLA | Pending |
| 11 | Unit economics: landed cost vs price after 10% Section 301, freight, returns — owner cost sheet (Q6) | Pending |
| 12 | For B2B: quote capture (0034) live and a written wholesale price/MOQ/lead-time sheet | Partial (form exists) |

**Go/no-go rule:** if any of 2-6 is missing, the US/UAE effort is limited to (a) marketplace listings (platform handles 3-4), (b) B2B content + quote form, (c) informational guides in US English (cheap, long-lived, no purchase path needed) — these are not blocked by the geo-lock only if the pages are indexable to Google via the crawler exemption and reachable to humans... **but humans in the US are redirected to `/us` or shown "Not available" when `/us` is not enabled.** So even guides cannot be read by US humans on our domain until a market is enabled. Options: (1) enable `/us` as a *content + quote-lead* market (no checkout; the preview already exists, 0031), or (2) host US guides on Medium/Substack/Pinterest/YouTube. **Recommended: option 1 after preconditions 2 and 6 (light) are met, with checkout disabled and a visible "request a quote / ships from India" flow.**

## 6. US/UAE technical SEO notes (delta from the India checklist)
- hreflang and canonical: technical checklist section 4. Each market page unique in content where price/shipping/duty/spelling differ; otherwise thin-duplicate risk.
- Sitemap per market (`sitemap-us.xml`, `sitemap-ae.xml`) and separate GSC URL-prefix properties for each `/us/`, `/ae/`.
- Schema: `shippingDetails.shippingDestination` per market; `MerchantReturnPolicy` per market; `areaServed`.
- Merchant Center: separate country feeds (US free listings need US-eligible shipping/tax settings) - postpone until precondition 3-5.
- CWV: US visitors to an India-hosted 2-CPU server: latency ~200-300 ms RTT (ESTIMATE) -> a CDN/edge cache (Cloudflare free) is required before any US SEO push; note the geo backend already honours `cf-ipcountry` (0036).
- Structured local trust: no fake US address; use "Ships from Jodhpur, India" plainly.

## 7. Measurement and timeline (US/UAE)
- KPIs: Etsy/Amazon: listing views, favourites, conversion, reviews; Google: impressions/clicks by country (GSC filter US/UAE); quote leads; wholesale inquiries; first container order.
- Realistic timeline (ESTIMATE): Etsy: first sales in 2-8 weeks for well-optimised niche décor if photos/reviews are good, otherwise 0; Google US organic for handmade furniture: 9-18 months to meaningful non-brand traffic on a new domain. UAE: unknown until the research spike.
- Decision checkpoints: (a) order #30-50 India -> decide marketplace pilot; (b) 60 days after marketplace start -> decide own-site `/us` content+quote market; (c) tariff review on 1 Jan 2027 (Section 232 step-ups) and any court/trade change (`market-selection.md` marks tariff data as FAST-changing).

## 8. Risks
1. Tariff/policy volatility (wooden handicraft exports fell 16.6% in FY26 to USD 840M after the 2025 tariff shock — `market-selection.md`, IBEF); 2. CITES/Lacey mistakes on sheesham > 10 kg; 3. Naming mismatch ("rosewood"); 4. Geo-lock hiding content from the very people we target, or the crawler exemption failing for Googlebot US IPs; 5. Freight erasing the 30% price advantage on single large pieces; 6. Support latency; 7. UAE local workshops already competing on price/near-me; 8. Marketplace policy limits on off-platform diversion of buyers.

---
Sources (accessed 2026-09-25): `countries/market-selection.md`, `us.md`, `uae.md`; Etsy algorithm summary (marmalead); Amazon Global Selling guides (skydo.com, sell.amazon.in/sell.amazon.com search results); UAE competitor sites listed above; Google locale-adaptive docs. No search volumes obtained for US or UAE; UAE price data not found.
