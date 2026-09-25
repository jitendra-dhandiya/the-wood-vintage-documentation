# 0041. US-first B2C export plan: first 100 orders from US consumers

Date: 2026-09-25

## Decision
Adopt the US edition of the go-to-market plan: `docs/marketing/us-first-100-orders-plan.md` (ten files under `docs/marketing/us-first-100/`), `docs/marketing/social/11-us-diaspora-and-mainstream-playbook.md`, `docs/seo/us-seo-plan.md` and the "US-first revision" at the top of `docs/marketing/master-growth-plan.md`. It **supersedes decision 0040 for the export business** (0040's India-only first-100 plan is superseded by the owner's direction; its India material stays as history and method).

1. **Market and model:** the USA, B2C, first 100 orders from US consumers; India domestic out of scope; UAE B2B research only. Hybrid fulfilment: hero SKUs by LCL sea freight to a US 3PL and ground delivery in 3-7 days; custom pieces made to order in 10-12 weeks (5-8 by air with a premium); DHL Express only for samples, parts and gifts of USD 250 or more.
2. **Position and prices:** parity to about 8% below boutique comparables, never "30% cheaper"; one all-in price ("free delivery, duties included"); no compare-at prices; five provable USPs (named Jodhpur workshop, honest wood naming, custom to your room, honest dates with duties included, repair-or-replace).
3. **Catalogue:** 11 SKUs in a first container of about 11.2 CBM and 118 units (USD 5,320 ex-factory, about USD 9,630 at the 3PL, about USD 42,000 retail): mandir 2.5 ft 599, compact mandir 2 ft 449, mirror 279, jaali 219, coffee table 459, side table 309, console 559, bench 369, bookshelf 739, pooja stool 189, kitchen gift set 109. **Container 1 is all mango/acacia** (no Dalbergia) until the CITES Management Authority answers in writing. Six combos (USD 299-1,099) and eight own-site/quote coupons (USD money terms via `countryTerms`, `excludeSaleItems`), plus Amazon and Etsy promotions.
4. **Channels:** Amazon.com FBA for stocked heroes (3 SKUs first), Etsy for custom and photography-led pieces, Instagram/Pinterest/Facebook groups/YouTube/WhatsApp as traffic, thewoodvintage.com as brand hub and quote form; own-site checkout after about order 50.
5. **Budget and timeline (recommended Base):** about USD 25,700 before per-order shipping, commit USD 20,000, peak cash about -USD 18,800 (Feb 2027); stock lands about 18 Jan 2027; 100th order about the week of 29 Mar 2027 (range 1 Mar to Aug 2027). Lean (USD 13,800) and Growth (USD 37,250, not recommended) are documented. **Diwali 2026 and Christmas 2026 are not served; the Christmas air-freight pilot was evaluated and rejected.** Diwali 2027 (29 Oct) is the first festival served.
6. **Gates:** Gate 0 (decide), A (customs and legal, before the container leaves), B (marketplaces, policies, assets), C (website for US visitors); paid ads and listings wait for the gates.

## Why
- The owner set the business as B2C export with the USA first. Research since then showed that DHL Express door-to-door fails for every SKU at rack rates (shipping 59-407% of price) and that sea consolidation plus a US 3PL makes seven of twelve SKUs viable (`export-b2c-logistics-and-landed-cost.md`); "30% cheaper" does not survive at US retail; the mandir niche is served by US-stocked sellers with mostly laminate units, leaving a gap for solid carved wood at USD 450-900 with custom size.
- Marketplaces (Amazon, Etsy) need no development, collect sales tax as facilitators and already carry the demand; the platform's US checkout, tax and legal pages are not built and development is on hold.
- Sea freight fixes the first sale date (about 18 Jan 2027), so ad spend cannot bring the 100th order forward by more than about four weeks; cash, not marketing, is the constraint.

## Alternatives considered
- **Keep the India-first plan (0040):** rejected by the owner's direction.
- **DHL Express DDP per parcel:** fails the margin test for all 12 SKUs (logistics doc, table 2); kept only for samples and parts.
- **Own-site-first with a US 3PL:** best margin, but needs USD checkout, tax and legal pages (dev on hold) and traffic; deferred to after about order 50.
- **Amazon-only or Etsy-only:** Etsy alone is the thinnest channel (14.5% fee stack) and its ships-from-US rule for India shops is unverified; Amazon alone concentrates account risk.
- **Christmas 2026 air pilot:** one-week selling window, thin margins (9-15% before acquisition cost), prerequisites not closable in five weeks; rejected (a seed batch of at most USD 1,500 is the alternative).
- **Growth scenario (14.8 CBM, USD 37,250):** brings the 100th order forward only about four weeks, exceeds default workshop capacity.
- **Sheesham in container 1:** CITES permit for seven of eleven SKUs (over 10 kg net timber) and an unverified annotation for finished goods; deferred.

## Chosen approach
Ten US files plus the social, SEO and master-plan documents as listed above; all costs and conversion rates are ASSUMPTIONS with an owner-editable input table in USD; the margin, funnel, timeline and cash model was computed with a throwaway script from the logistics doc's formulas (which it reproduces exactly for the shared SKUs) and is reproduced in the tables. No code changed; nothing pushed.

## Consequences (what changes versus 0040)
| Topic | 0040 (India-first) | 0041 (US-first) |
|---|---|---|
| Market for the first 100 orders | India domestic | USA; India out of scope; UAE B2B research only |
| Currency, tax, pricing | INR incl. GST | USD, all-in delivered price; marketplaces collect sales tax |
| Catalogue | 16 SKUs + 4 quote-only; heavy items (beds, TV units) quote-only | 11 SKUs, KD (legs-off) packing, mango/acacia; beds, dining, trunks, planters, cabinets excluded |
| Combos and coupons | 9 combos, 8 INR coupons (`countryCodes = IN`) | 6 USD combos, 8 USD coupons (`countryCodes = US`, `countryTerms` in USD) plus Amazon/Etsy promotions; the engine only sees site checkout |
| Channels | WhatsApp-led, site-based | Amazon FBA + Etsy + community, site as hub; WhatsApp as sales desk |
| Budget | INR 3.6 lakh over 16 weeks, cash-negative by INR 2.4 lakh | USD 25,700 spend, USD 20,000 committed, peak -USD 18,800; inventory is the main cash item |
| Timeline | 100 orders in week 17 (18 Jan 2027) | Stock lands 18 Jan 2027; 100 orders about 29 Mar 2027 |
| Festivals | Diwali 8 Nov 2026 ready-stock | Diwali 2026 and Christmas 2026 not served; Diwali 2027 first |
| Gates | Gate A (content/config) and B (dev) | Gate 0, A (customs/legal), B (marketplaces/policies/assets), C (site) |
| Customisation | 50% advance, 6 steps, 6-30 day lead times | 40% deposit, 10-12 weeks by sea, FTC ship-date rule, limited warranty |
| SEO | India go-live and `/in` pages | Marketplace-first; staged noindex removal for `/us`; geo-lock decisions (crawler verification, soft banner, notify-me); decide the fate of `/in` and `/` |
| Customer service | IST 10:00-20:00 | Two IST windows covering US morning and evening |
- Owner must supply: real cost sheet, carton sizes and species, capacity, cash (USD 20,000), forwarder/3PL/broker quotes, the US network list, and answers on Etsy ships-from-US and Amazon fees (input sheet P0 rows).
- Gate C needs owner-approved config changes now (real USD prices, shipping rule, contact, policies, fake content removed) and dev items later (hide Add to Bag for US, US legal pages, review feature, consent banner, checkout, tax).
- The geo-lock (0036) and the India-first redirect from `/` to `/in` need a decision now that India is out of scope.
- Revisit at order 25 (book container 2), order 30 (re-rank segments and SKUs by contribution), checkpoints at weeks 22 and 26, and after the first container's damage rate is known.

## Date
2026-09-25
