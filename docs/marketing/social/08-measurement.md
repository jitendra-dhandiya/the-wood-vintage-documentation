# 8. Measurement - KPIs per stage, weekly review, UTM convention, free tools

Part of [../social-media-playbook.md](../social-media-playbook.md). Tags per 10-benchmarks-and-sources.md. We do not invent target numbers: **weeks 1-4 establish baselines; from week 5 the target is baseline +20% per month (HEURISTIC) unless the master growth plan sets a number.** Owner-facing headline metric: **qualified WhatsApp conversations per week -> quotes sent -> orders.** Follower count is a secondary vanity metric.

## 8.1 What the site can and cannot see (from decisions 0025, 0026, 0034)
- The site captures `utm_source`, `utm_medium`, `utm_campaign` from the landing URL into the **`wv_attribution` cookie, first-touch only** (never overwritten), and stores them on **Orders** (typed columns) and on **Leads** (with `sessionId`). Funnel events include `QUOTE_CTA_VIEW`, `QUOTE_CTA_CLICK`, `QUOTE_STEP1_DONE`, `LEAD_SUBMITTED`, `WHATSAPP_CLICK`. Admin has a leads summary by source/UTM/status/day and a Leads CSV export.
- **No `utm_content` / `utm_term` are documented as stored** -> put the theme/creative into `utm_campaign` and keep ad-level detail in Meta.
- **WhatsApp chats started from Instagram/ads/bio do not touch the site**, so they are invisible to this attribution. Use `ref:` codes in prefilled messages + WhatsApp labels + the lead sheet (07). `WHATSAPP_CLICK` counts clicks on the site's own WhatsApp buttons only.
- Orders also store `couponCode` (0035) - a second attribution lane for creators/referrals.
- Consequence: report **both** views - site-attributed (UTM) and manually tagged (WhatsApp/lead sheet) - and never divide one by the other.

## 8.2 KPIs by funnel stage
| Stage | Metric (source) | How to read it (diagnostic, HEURISTIC) | Cadence |
|---|---|---|---|
| **Reach/Discovery** | Reels plays and accounts reached; % non-followers (IG Insights) | Are we being shown beyond followers? | Weekly |
| **Attention** | 3-second hold rate (3s plays/plays), average watch time, completion rate (Reels insights) | Low hold = weak hook (rewrite first 2 s); low completion = story drags | Per reel at day 3 and 7 |
| **Advocacy signals** | Saves, shares (sends), comments, follows from post (Insights) | Shares/reach and saves/reach are the quality indicators (sends per reach named as a top signal - ESTIMATE) | Weekly |
| **Interest** | Profile visits; follows per profile visit | Are people curious after the reel? | Weekly |
| **Click** | Link taps (Insights: website/link taps); site sessions with `utm_source=instagram\|facebook\|pinterest\|youtube` (Admin analytics) | Profile-visit -> link-tap ratio shows bio/link strength | Weekly |
| **Consideration on site** | `QUOTE_CTA_VIEW`, `QUOTE_CTA_CLICK`, `QUOTE_STEP1_DONE` (Admin funnel) | Drop between view and click = page/offer weak | Weekly |
| **Enquiry** | (a) `LEAD_SUBMITTED` (site leads); (b) WhatsApp conversations started by source (labels + lead sheet); (c) DMs -> WhatsApp moved | The core KPI: qualified conversations/week | Daily count, weekly report |
| **Qualification** | % of enquiries with room size + city + budget given | Measures ad/post targeting quality | Weekly |
| **Quote** | Quotes sent; time to first quote; quote-to-advance rate | Speed and price fit | Weekly |
| **Order** | Orders (advance paid), AOV, source (UTM/ref/coupon), cycle time | The outcome; tie to first-100-orders plan | Weekly |
| **Delivery/Reputation** | Reviews, UGC pieces, complaint count, damage rate | Feeds proof content | Monthly |
| **Efficiency** | Cost per qualified conversation, CAC, ROAS (paid) | Guardrails in 06 | Weekly when paid is on |
| **Community** | Response times vs SLA (07) | Speed correlates with conversion (HEURISTIC) | Weekly |
Vanity-metric caution: likes and follower count do not pay. Compare the ratio "qualified conversations per 1,000 reach" across reels to find the content that sells, not just entertains.

## 8.3 Weekly review template (Monday, 45-60 min; copy into the sheet)
```
WEEK {n}  ({dd Mon}-{dd Mon})
1. Posted: reels {x}/4, carousels {x}/2, statics {x}/1, stories days {x}/7
2. Numbers (this week | last week | change):
   Reach | Non-follower reach % | Followers (+/-) | Profile visits | Link taps
   Site sessions from social (by source) | QUOTE_CTA_CLICK | LEAD_SUBMITTED
   WhatsApp conversations started (IG / FB / site / ads / ref) | Qualified % | Quotes sent | Orders | Revenue
   Median first-response time | SLA breaches
3. Top 3 posts (why?)   4. Bottom 3 posts (why?)
5. Comments/DMs: top 5 questions -> next content
6. Funnel leak: (largest drop) -> hypothesis -> fix
7. Paid (if on): spend, conversations, cost/qualified conversation, orders, decision
8. Decisions for next week (max 3) and owner: ...
9. Compliance check: disclosures on any collab posts? claims verified? consent stored?
```
Per-post log (one row per post): `Date | ID (R03/C05...) | Pillar | Format | Hook | Caption keyword | Hashtag set | Reach | 3s hold | Avg watch | Saves | Shares | Comments | Profile visits | Link taps | WhatsApp starts attributed | Leads | Notes/Learning`. Fill at day 3 and 7 after posting.

## 8.4 UTM naming convention (lowercase, hyphens, no spaces, no personal data)
Format: `?utm_source={platform}&utm_medium={placement}&utm_campaign={market}-{theme}-{yyyymm}`
- `utm_source` = the platform where the link lives: `instagram`, `facebook`, `whatsapp`, `pinterest`, `youtube`, `google` (Business Profile), and `meta` **only** for paid Meta ads (covers IG+FB placements; look at Meta's placement report for the split).
- `utm_medium` = the placement/type: `organic_bio`, `organic_story`, `organic_post`, `broadcast`, `channel`, `status`, `group`, `gbp`, `organic_pin`, `shorts`, `video`, `creator`, `paid_social`, `qr`, `referral`.
- `utm_campaign` = `{market}-{theme}-{yyyymm}`, market = `in` / `us` / `ae`; themes: `profile`, `bestsellers`, `custombeds`, `diwali`, `wedding`, `care`, `factorydirect`, `r03`, ... (`r03` style = reel ID for a link in a story about that reel).
| Placement | Example URL suffix |
|---|---|
| IG bio link 1 | `?utm_source=instagram&utm_medium=organic_bio&utm_campaign=in-profile-202610` |
| IG story link sticker on Reel 26 | `?utm_source=instagram&utm_medium=organic_story&utm_campaign=in-r26-factorydirect-202610` |
| IG Broadcast channel post | `?utm_source=instagram&utm_medium=broadcast&utm_campaign=in-diwali-202610` |
| WhatsApp Channel / status | `?utm_source=whatsapp&utm_medium=channel&utm_campaign=in-diwali-202610` |
| Facebook page post | `?utm_source=facebook&utm_medium=organic_post&utm_campaign=in-custombeds-202610` |
| Facebook group post (if allowed) | `?utm_source=facebook&utm_medium=group&utm_campaign=in-care-202610` |
| Pinterest pin | `?utm_source=pinterest&utm_medium=organic_pin&utm_campaign=in-sheesham-beds-202610` |
| YouTube Short | `?utm_source=youtube&utm_medium=shorts&utm_campaign=in-r03-202610` |
| Google Business Profile | `?utm_source=google&utm_medium=gbp&utm_campaign=in-profile-202610` |
| Creator link (their bio/story) | `?utm_source=instagram&utm_medium=creator&utm_campaign=in-anita_home-202611` (handle underscores allowed only inside the theme slot) |
| Meta paid ad | `?utm_source=meta&utm_medium=paid_social&utm_campaign=in-custombeds-202611` |
| QR on packaging/invoice | `?utm_source=qr&utm_medium=qr&utm_campaign=in-review-202610` (or the review link) |
WhatsApp `ref:` codes (typed in the prefilled message): `IG-BIO`, `IG-REEL-R03`, `IG-STORY-R26`, `FB-PAGE`, `FB-GROUP`, `PIN`, `YT`, `GBP`, `CTWA-<adset>`, `CREATOR-<handle>`, `REF-<name>`, `WALKIN`.
Rules: (1) build every link with Google's Campaign URL Builder (free) or a sheet formula; (2) one master sheet `utm-registry` lists every link ever used (date, URL, owner); (3) never put a customer's name/phone/email in a UTM; (4) test each link in an incognito window once, submit a test lead, and confirm the UTMs appear in Admin > Leads - **then delete the test lead**; remember first-touch: clear cookies between tests; (5) do not change naming mid-campaign.
Optional Meta dynamic parameters exist in Ads Manager (e.g. campaign/ad name macros) - confirm the exact macro syntax in the UI before use (ESTIMATE); only the three stored fields matter to our site.

## 8.5 Tools (free tiers; verify current limits)
| Need | Tool | Note |
|---|---|---|
| Native analytics | Instagram Insights / Professional dashboard; Facebook Page Insights; Meta Business Suite (planner, unified inbox, insights) | Free |
| WhatsApp metrics | WhatsApp Business app statistics + labels | Message-level stats; no source attribution |
| Website funnel and leads | Site Admin: funnel report, Leads summary, CSV export (decisions 0025/0034) | Already built; UTM first-touch |
| Web analytics (optional) | Google Analytics 4 / Search Console | Not decided in code; coordinate with analytics/SEO agents |
| UTM building | Google Campaign URL Builder + Google Sheet registry | Free |
| Reporting | Google Sheets; Looker Studio (free) for a dashboard from the sheet | Free |
| Scheduling | Meta Business Suite planner (free); Metricool/Later free plans (limits vary - ESTIMATE) | Reels scheduling supported by Meta's planner (verify) |
| Hashtag/keyword research | Instagram search suggestions, Google Trends, Pinterest Trends | Free |
| Design/editing | Canva free, CapCut, InShot (09) | Free/low cost |
| Creator vetting | Manual Insights screenshots; free audit tools (accuracy varies) | HEURISTIC |
| Pinterest/YouTube | Pinterest Analytics; YouTube Studio | Free |
