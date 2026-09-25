# 6. Paid social - how organic and paid connect

Part of [../social-media-playbook.md](../social-media-playbook.md). **Scope guard:** overall acquisition budget, offers, price ladder, channel mix and the 100-order arithmetic belong to `docs/marketing/first-100-orders-plan.md` (written by another team). This file defines only the Instagram/Facebook mechanics, structure, creative-testing method and guardrails, and refers to that plan for budget numbers. Where numbers appear here they are illustrative ASSUMPTIONS, to be replaced by that plan.
Tags per 10-benchmarks-and-sources.md. Meta's Ads Manager labels change often; names below are ESTIMATE - confirm in the UI.

## 6.1 Readiness gate (do not pay to send traffic to a broken funnel)
Paid traffic starts only when ALL are true:
- [ ] WhatsApp Business number is real and the site setting `whatsapp_number` is updated (still the placeholder `919876543210` per decision 0034), and `lead_response_promise` matches what you can deliver.
- [ ] A person can answer within the SLA (07) every day, including weekends and festivals.
- [ ] Quote-form leads reach the admin (notification email configured, decision 0034) and are logged.
- [ ] At least 15-20 organic posts, 5+ Highlights, and 3 pieces of real social proof (customer photos/quote) exist.
- [ ] If the objective is website *sales*: online payment works in production (Razorpay/Cashfree keys are still placeholders per in.md/decision 0027). Until then, run **WhatsApp or Leads** objectives only; COD/advance flows can be completed on WhatsApp.
- [ ] Attribution tracked: UTM naming (08), WhatsApp ref codes and labels.
- [ ] Meta Pixel/Conversions API decision made with analytics (needed for website retargeting/catalog sales; the site's own events and `wv_attribution` are in-house, decisions 0025/0026 - a Meta pixel is an additional request, not built).

## 6.2 How organic feeds paid (and the reverse)
1. **Organic is the creative lab.** Post every reel organically first; after 5-7 days, pick the top 2 by watch-through and sends (08) and turn them into ads. Their hooks are pre-validated for free. (HEURISTIC)
2. **Boost vs Ads Manager.** *Boost* (Instagram button on a post/reel) is quick and low-control: use it for a reel already performing organically to get more reach/profile visits or "more messages" (options depend on the UI - ESTIMATE). *Ads Manager* is required for real objective choice, placements, audiences, catalog ads, A/B tests and clean reporting. From week 5, use Ads Manager for everything that must be measured; use boosts only for quick-and-dirty amplification of festival greetings/announcements.
3. **Paid feeds organic:** every ad viewer who engages becomes a retargeting seed (video viewers, profile visitors, post engagers) and a follower; put the best reel as pinned.
4. **Ads are also social proof:** comments on ads count; reply to them like organic comments.

## 6.3 Campaign objectives for a furniture D2C (in order of fit)
Meta's structure is outcome-driven (Awareness, Traffic, Engagement, Leads, Sales - ESTIMATE); within these, choose destinations:
| Priority | Objective / destination | Why it fits custom furniture | Watch-outs |
|---|---|---|---|
| 1 | **Click-to-WhatsApp (CTWA)** - Engagement -> Messages (WhatsApp), or Leads -> WhatsApp depending on UI | Indian buyers of high-ticket, custom items prefer chat; conversation starts open a 72-hour free window for template messages (ESTIMATE; verify current Meta pricing) | Needs fast human replies; ensure prefilled message includes `ref:CTWA-<adset>`; track WhatsApp labels |
| 2 | **Leads with website quote form (traffic to the product/landing page)** - Traffic -> Landing page views, or Leads -> Website | Our page has "Get Best Quote & Price" primary CTA + WhatsApp (decision 0034), UTM+session captured on the Lead | Landing page quality (mobile), speed; cookie is first-touch only, so an earlier organic visit will hold the attribution |
| 3 | **Instant (lead) forms** on Meta | Higher volume, lower friction | Lower intent: add qualifying fields (city, room size, budget range, timeline), use "higher intent" review step if available; these leads live in Meta, not in our Leads table: export to the lead sheet daily and call within 30 min |
| 4 | **Catalog / Advantage+ catalog sales (retargeting)** | Shows the exact viewed products; strong for warm audiences later | Needs catalog + pixel/Conversions API; furniture has low conversion rate and long consideration (vendor benchmark: 3.77% conversion in furniture, ESTIMATE); do after ~100 site visits/day or a meaningful warm audience |
| 5 | Awareness/Reach | Only for brand recall in a city launch or festival | Not needed in Phase 1 |
Recommendation: **Phase 1 = CTWA + website quote-form traffic**. Add catalog retargeting when the pixel and 500+ engaged/visited people exist.

## 6.4 Account and campaign structure (India test)
```
Campaign A: TWV | IN | CTWA | Custom-Beds | 2026-11
  Ad set A1: Broad 25-45, Delhi NCR + Bengaluru + Jaipur + Mumbai (cities where delivery is confirmed)  [Advantage+ audience ON]
  Ad set A2: Rajasthan (Jodhpur, Jaipur, Udaipur, Ajmer) 25-50 - (closer logistics, cheaper delivery)
    Ads (3 hooks x 1 format each): R03 plank-to-bed, R26 factory-direct, R11-R14 series cut
Campaign B: TWV | IN | Traffic-Quote | Bestsellers | 2026-11
  Ad set B1: Broad 25-45 (same cities); Ads: carousel "how custom orders work", reel R19 myths
Campaign C (after week 6): TWV | IN | Retarget | 30d engagers + site visitors
  Audiences: IG/FB engagers 30-90 days, video viewers >= 50%, lead-form openers; exclude past buyers
```
Naming convention: `TWV|{country}|{objective}|{theme}|{yyyy-mm}` for campaigns; `{audience}|{age}|{place}` for ad sets; `{reelID}_{hook}_{format}_{version}` for ads (e.g. `R26_showroomrent_reel_v1`).
Placements: start with Advantage+ placements; review by placement after 7 days; Reels and Stories usually have lower CPM than feed (India: Reels CPM Rs 45-140 vs feed Rs 150-350 - ESTIMATE, upgrowth.in) but that says nothing about lead quality: judge by cost per *qualified* lead.
Targeting: broad + creative variety first (Meta's delivery is increasingly creative-driven - HEURISTIC). Add interest signals (home decor, interior design, home renovation, wedding planning, first-time home buyers) as suggestions, not hard limits. Exclude pin codes where delivery/ODA charges make the item non-viable (see decision 0015 bulky-goods shipping rules).
Lookalikes: only after >= 100 quality seeds (past buyers, qualified leads) - do not create from 20 people. (HEURISTIC)

## 6.5 Creative testing plan (weeks 5-10)
- **Variables, one at a time:** (1) Hook (first 2 s), (2) Angle (custom / factory-direct / craft / festival), (3) Format (reel vs carousel vs static), (4) CTA ("WhatsApp QUOTE" vs "Send room size"), (5) Language (Hinglish vs English vs Hindi).
- **Design:** each test = 3 ads in one ad set (dynamic budget equal), 7 days, same audience. Week 1: hooks (3 variants of one reel). Week 2: angles (3 different reels). Week 3: format/CTA of the winning angle. Week 4: language.
- **Metrics per ad:** CPM, 3-second hold rate (3s plays / impressions), 15s/thruplay rate, CTR (link/message), cost per WhatsApp conversation, **cost per qualified conversation** (room size + city + budget given), quote-sent rate, orders.
- **Decision rules (HEURISTIC; replace with plan numbers):** do not judge an ad before it has ~1,000 impressions and Rs 1,000-1,500 spend; pause an ad when cost per conversation is > 2x the ad set's best after 3 days; graduate a winner after 30 conversations or 3 orders; cap creative fatigue: refresh when frequency > 3 in 7 days or CTR falls > 30% from peak.
- **What to log:** creative ID, hypothesis, spend, results, decision, learning - one row per ad in the weekly sheet (08).
- **Ad policy hygiene:** use own footage (no unlicensed music), no exaggerated/unverifiable claims ("best", "guaranteed", "lifetime" unless in written policy), real discounts only. See 09.

## 6.6 Budget guardrails (illustrative; final numbers from first-100-orders plan)
Vendor advice (ESTIMATE) says D2C brands under Rs 1L/month of spend get punished by the learning phase and should treat Rs 1.5-2L/month as a true minimum (upgrowth/monaqo-type blogs). We cannot verify that and it is not a rule; for a custom-furniture lead business with WhatsApp objectives a smaller, capped test is reasonable if you accept slower learning.
Illustrative schedule (ASSUMPTION):
| Stage | When | Daily | Cap | Exit criteria |
|---|---|---|---|---|
| T0 Boost tests | wk 3-4 | Rs 200-300 / boost | Rs 5,000 total | Reel reach, profile visits per Rs, 5+ conversations |
| T1 CTWA test | wk 5-6 | Rs 500-700 | Rs 10,000 | >= 15 conversations, >= 5 quotes sent; cost per qualified conversation known |
| T2 Scale if healthy | wk 7-10 | +20% every 3 days if cost per qualified conversation <= target | Rs 30,000/month until CAC known | First orders; CAC estimate |
| T3 Retargeting | wk 8+ | Rs 200-300 | 20% of spend | ROAS/CAC vs organic |
Break-even guardrail: define **maximum allowed CAC = gross margin per order x 40-50% (HEURISTIC)**; if the owner's margin per order is Rs {M}, kill any ad set whose blended cost per order (after 14 days and >= 3 orders) exceeds that. **Owner input required: gross margin per product category** (not in the docs).
Stop-loss: pause everything for 48 h and diagnose if spend > Rs 3,000 with 0 qualified conversations, or if reply SLA is missed for 2 consecutive days (the funnel, not the ad, is failing).
Benchmarks for expectations (ESTIMATE, vendor blogs): India Instagram CPM Rs 45-350, CPC Rs 6-55; home decor ROAS 3-5x reported; furniture conversion trails (~3.8%). Treat as ranges to test against, not promises.

## 6.7 Attribution across social and site
- All website links in ads carry UTMs (naming in 08). Campaign name ONLY (utm_campaign) is stored with Leads/Orders along with source and medium; there is no content/term column documented, so encode the theme in `utm_campaign` and keep ad-level detail in Meta.
- The `wv_attribution` cookie is **first-touch only**: a buyer who discovered us organically then clicked a paid ad remains "organic". Expect paid to look worse than reality on last-click analysis; compare with Meta's own reporting and WhatsApp labels.
- WhatsApp chats do not carry UTMs: rely on the `ref:` code in the prefilled message + labels. Log every CTWA conversation with the ad set/ad in the lead sheet.
- Coupon codes (0035) are a second attribution lane (orders store the code): use per-creator/per-campaign codes.

## 6.8 Facebook-specific notes
Facebook adds older, family-decision-maker reach; keep Facebook placements on in Advantage+ but review separately; Messenger click-to-message auto-reply should hand to WhatsApp. Lead ads on Facebook feed can be cheaper but lower intent (ESTIMATE, HEURISTIC).

## 6.9 Later markets (paid)
USA/UAE paid social only after payments/shipping/legal are ready (us.md, uae.md); use separate campaigns with `country` in the name; do not reuse India creative with INR prices.
