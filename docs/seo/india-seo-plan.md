# India SEO plan — The Wood Vintage (`/in`)

Date: 2026-09-25. Owner: SEO + content strategy. Tags: VERIFIED / ESTIMATE / ASSUMPTION. Development is ON HOLD: this plan specifies pages and
changes by route name only. Related: [technical-seo-checklist.md](technical-seo-checklist.md) (audit + go-live + W-xx change list),
[keyword-map-india.md](keyword-map-india.md), [content-calendar.md](content-calendar.md), [us-uae-seo-plan.md](us-uae-seo-plan.md),
`countries/market-selection.md`, `countries/in.md`, `marketing/marketing-workstream-plan.md`.

---

## 1. Strategy in one page

**Position.** SEO for a brand-new domain with 0 backlinks, a 2-product production catalogue and IP-locked country routing is a **slow, compounding channel**, not the engine of the
first 100 orders. Honest expectation: the first 100 orders come from Instagram/Facebook, WhatsApp/quote leads, referrals, marketplace listings and (optionally) paid, with SEO
contributing brand searches and a handful of orders in the first 90 days, and becoming material from month 4-6 onward (ESTIMATE, section 6). The plan therefore has two jobs:
(1) **do not waste the launch** (fix blockers, launch once, index the right pages) and (2) **build the assets that win on the terms a small specialist can win**.

**Where a small brand wins (VERIFIED competitor language + reasoning, detail in keyword-map section 0):**
1. **Custom / made-to-order furniture** — few big sites (Wooden Street offers wood/finish/dimension customisation but leads with discounts; Woodsala sells "quote in 24 hours") explain the process, cost drivers and lead times transparently. A dedicated `custom-furniture` + `how-customisation-works` pair is the single highest-leverage SEO/conversion asset.
2. **Real Jodhpur provenance** — a named workshop, named carpenters, photos/video of the actual shop floor. Many Jodhpur competitors exist (Woodsala, Timber Guy/Sunrise, Shekhawati Crafts — `competitor-research/indian-competitors-directory.md`), so "solid sheesham" alone is not a differentiator; proof is.
3. **Buying guides that answer real doubts** ("is this really sheesham", "how long will made-to-order take", "will it fit my room", "what does custom cost") with size tables, photographs and prices — where the giants are generic.
4. **Long-tail**: material comparisons, gifting/occasions, care, sizes; each page is easy to rank for, and each links to a money page.

**Where we do NOT compete (year 1):** head terms like "sheesham wood bed price", "wooden dining table", "furniture near me / in <city>" (Wooden Street, Pepperfry, Urban Ladder, IKEA, Amazon, Flipkart + local stores). Head-term pages exist for conversion of paid/social traffic and long-run authority, not as year-1 ranking targets.

**Price story in search snippets.** Owner claim: ~30% below market. Wooden Street's sale price is 45-62% below MRP (VERIFIED `countries/in.md`), so "30% cheaper" compared to MRP is meaningless; state it against a *named, dated, sale-price* comparison or not at all (Consumer Protection / ASCI misleading-claims risk — ASSUMPTION, take legal advice). Prefer "factory-direct from Jodhpur" and transparent price breakdowns.

**Constraint reminders.** Geo-lock (0036): Indian visitors only see `/in`; overseas humans see "not available"; Google is exempted by UA (technical checklist section 5). Catalogue: production 2 SKUs (Channapatna Stacking Rings Rs 1,090; Hand-Carved Krishna Panel Rs 10,490 - VERIFIED via API 2026-09-25); local 46. Both product pages are currently broken for crawlers (F1 in technical checklist) — first job.

---

## 2. What SEO delivers in the first-100-orders plan

| Horizon | Role of SEO | Dependency |
|---|---|---|
| Now - go-live (noindex) | Fix blockers; build P0 pages (custom-furniture, how-customisation-works, made-in-jodhpur, 6 anchor guides); set up GBP, GSC, Bing, GA4, Merchant Center; collect real photos/video/reviews from the first orders | Product photos, real business data, W-01/02/03/14/15/19 |
| Days 1-30 post-launch | Get indexed; brand searches ("the wood vintage"), social profile sitelinks; GBP live; first backlinks (directories, craft bodies, 3-5 pitched blogs) | Launch gates (checklist section 2.1) |
| Days 30-90 | Publish 2 guides/week; first impressions on long-tail; Merchant Center free listings; Pinterest/YouTube compounding; 0-3 organic orders is a normal outcome | Consistent publishing |
| Days 90-180 | First page-1 rankings for Win-tier terms; 5-20 organic orders/month is a *good* outcome (ESTIMATE) | Content + links + real reviews |

SEO also **de-risks paid/social**: every landing page (custom-furniture, product, guides) is built to convert social traffic first.

---

## 3. On-page playbook

### 3.1 Title / meta / H1 / intro / FAQ templates per page type
Rules: title <= ~60 characters (Google truncates by pixels ~600 px), meta <= ~155 chars, one H1 that matches search intent, brand at the end (`| The Wood Vintage`; layout already appends it and strips duplicates), primary keyword first, no ALL CAPS/discount stuffing, no "best" claims we cannot back. All values are overridable per page (SeoMeta model exists, 0006). "[...]" = fill from data.

| Page type | Route | Title | Meta description | H1 | Intro (first 100 words) | FAQ (3-6 Qs, on-page; FAQPage schema optional) |
|---|---|---|---|---|---|---|
| Home | `/in` | The Wood Vintage - Handcrafted Solid Wood Furniture from Jodhpur | Custom and ready solid wood furniture and décor, made by our own carpenters in Jodhpur. Made to your size and finish. Delivery across India. | Handcrafted wood, made in Jodhpur (keep current H1 tone; add city) | Who we are in 2 sentences + custom promise + delivery + one proof line | Brand FAQ: who makes it, delivery, custom, returns |
| Category | `/in/category/[slug]` | [Category, e.g. Sheesham Wood Beds] - Made to Order in Jodhpur | Solid [material] [category] handmade in Jodhpur. Choose size and finish, delivered across India. [1 differentiator]. | [Category] (natural, not stuffed) | What it is, materials, sizes offered, custom option, delivery time; link to buying guide | "What size should I choose?", "Can I customise size/finish?", "How long is delivery?", "How do I care for it?", "Is it real solid wood?" |
| Product | `/in/product/[slug]` | [Product name] - [Material] [Type], [key size] | [Product name] hand-made in Jodhpur from [material]. [Finish]. Custom sizes available. Ships in ~[N] days. Rs [price]. | [Product name] | Formula in 3.3 | Product FAQ (size, finish, lead time, delivery/assembly, care, custom, returns policy) |
| Collection | `/in/collections/[slug]` | [Collection name] Collection - [Room/Style] Furniture | Curated [style/room] pieces ... | [Collection name] | Editorial 100-150 words on the idea + how to combine pieces | 2-3 styling Qs |
| Material | `/in/material/[slug]` | [Material]: Properties, Uses and Furniture in [Material] | Everything about [material] furniture: durability, look, care, price. Browse our [material] pieces made in Jodhpur. | [Material] furniture | 150-250 words: what it is, pros/cons, how it compares (link to comparison guide) **before** the product grid | "Is it durable?", "Termite/moisture?", "How does it compare with X?", "How to care?" |
| Room | `/in/room/[slug]` | [Room] Furniture in Solid Wood - Made in Jodhpur | Solid wood furniture for your [room]: [3 product types]. Custom sizes for small and large spaces. | [Room] furniture | Layout tips + product types | "How to choose [item] for a small [room]?" |
| Style | `/in/style/[slug]` | [Style] Wooden Furniture and Décor | ... | [Style] furniture | Style explainer + how to pair | 2-3 |
| Artisan | `/in/artisans/[slug]` (W-17) | [Name] - Master Carpenter, Jodhpur | Meet [Name], [n] years [craft]; see pieces they made. | [Name], [craft] | Real bio, real photo, real quotes | none |
| Blog/guide | `/in/blog/[slug]` | [Keyword-led question/promise] (2026) | Answer-first summary + what's inside | Same as topic | Direct answer in first 2-3 sentences (featured snippet/AI answer target), table of contents | 4-6 Qs from PAA; CTA block |
| Custom furniture | `/in/custom-furniture` | Custom Furniture Online in India - Made to Order in Jodhpur | Tell us the size, wood and finish - our Jodhpur carpenters build it. Free quote in 1 business day. See cost, timeline and process. | Custom furniture, made to your measurements | 3 lines + CTA (Quote form + WhatsApp) | Section 3.5 |
| Delivery | `/in/delivery` | Furniture Delivery Across India - Timelines and Charges | ... | Delivery and installation | Real table by metro | "ODA charges?", "assembly?", "damage?" |

Copy rules: Indian English (lakh/crore, feet+inches and cm, "almirah" fine); prices in Rs with "incl. GST"; no fake urgency; no "best in India" claims.

### 3.2 On-page checklist per page (apply before publish)
Single H1 = primary intent; H2s = sub-questions; keyword in first 100 words, naturally; >= 1 original image with descriptive alt; internal links (2 up, 2 across, 1 to quote/WhatsApp CTA); external link to 1 authoritative source where it adds trust (e.g., forestry/materials source); "Last updated" date shown and true; author line with a real name; schema per checklist section 8; mobile check; page load check; canonical + hreflang; added to sitemap; logged in the keyword sheet.

### 3.3 Product-description formula (ranks AND converts; 150-300 words)
1. **Headline line (H1 + one line)**: what it is + who it is for. *"Hand-carved sheesham console for narrow entryways."*
2. **The 3-line hook**: size, material, finish - the facts a buyer scans (in a spec table right under the price).
3. **The story** (2-4 sentences): who made it (named carpenter/workshop), how long it took, one craft detail (joinery: mortise-and-tenon, hand-carved motif, hand-rubbed finish). Real facts only.
4. **Why it's worth it**: durability (solid sheesham, kiln-dried? — state only if true), no MDF/particle board, finish options, reparable.
5. **Made your way**: "Available in 3 finishes and custom sizes. Tell us your measurements - reply in 1 business day" + Quote button + WhatsApp button (0034).
6. **Delivery + assembly + lead time**: "Ready in ~N days, delivered to [Delhi NCR] in ~N days; assembly by our team/partner in [cities]"; ODA note.
7. **Spec table**: dimensions (cm + inches, 0039), weight, wood species (botanical name for provenance), finish, load capacity if known, care.
8. **Trust block**: returns/damage policy in one line, GST invoice, warranty (only if real, e.g. "1-year against manufacturing defects"), payment/COD-advance rules.
9. **FAQ (3-5)**: size fit, colour variation ("grain varies"), custom, care, delivery.
10. **Reviews/photos**: only real; ask for photos after delivery.
Never: manufacturer-copied text, duplicated descriptions across products, keyword lists. Existing live copy is already structured (craft / material & finish / dimensions / made-to-order / care - VERIFIED) - extend with 5-8.

### 3.4 Buying guides and comparison content
Plan: 4 pillar guides + 26 supporting articles (section 4). Format: answer first; comparison tables; photos of *our* wood samples side-by-side; a "which should I pick?" recommendation; a callout linking to the relevant product/category and the quote CTA; FAQ; updated dates. Pillars: (P1) The Complete Guide to Sheesham Wood Furniture, (P2) Solid Wood vs Engineered Wood: Buying Guide, (P3) Custom Furniture in India: Cost, Process, Timeline, (P4) Standard Furniture Sizes in India (beds, tables, consoles).

### 3.5 New page specs (route names; build later)

**A. `/in/custom-furniture` — the flagship money page**
Goal keywords: customised furniture online, custom furniture india, made to order furniture india (keyword-map B).
Sections: 1) H1 + promise + CTAs (Get a quote / WhatsApp); 2) "What you can customise" (size, wood, finish, carving, storage, hardware) with photos; 3) 4-step process strip (share idea -> quote in 1 business day -> approve + advance -> made in Jodhpur, updates, delivery); 4) price transparency block ("What decides the price": wood, size, carving hours, finish, freight; indicative ranges from real past quotes); 5) timeline table (typical lead time by product type - owner to supply); 6) gallery of real custom builds (before/after, sketch -> product); 7) materials sample offer (swatch/finish sample; owner decision); 8) B2B strip (cafes, homestays, offices); 9) FAQ (min order, advance %, changes after approval, returns on custom pieces, warranty, delivery, installation, GST invoice, sending your own design/reference photo); 10) trust (workshop photos/video, named carpenters, reviews); 11) links to guides. Quote form (existing lead capture 0034) with fields: type, size, wood, budget, city/pincode, photo upload.
Schema: Organization, BreadcrumbList, FAQPage (optional), Service (`serviceType: Custom furniture manufacturing`, `areaServed: India`).

**B. `/in/how-customisation-works`** — process + expectations page (informational/commercial, targets "how custom furniture works", "custom furniture process", feeds AI answers): timeline diagram, what we need from you (measurements guide, photo references, how to measure), revision rules, advance/payment/refund rules, production updates via WhatsApp video, packing, delivery, installation, care. Include measurement worksheet download (PDF) to earn links and leads.

**C. `/in/made-in-jodhpur`** — workshop story + proof (targets jodhpur furniture online/manufacturer, E-E-A-T): real photos/video of the carpenter team, timber sourcing (legal origin documents - matters for credibility and future export), how a piece is made, Jodhpur furniture heritage (cite sources), workshop address + map + visit rule (only if visitable), contact. Feeds GBP and `Organization`/`FurnitureStore` schema.

**D. `/in/delivery`** — see keyword-map D. **E. `/in/guides`** hub. **F. `/in/corporate-gifting` and `/in/custom-furniture/for-business`** (P2).

### 3.6 Programmatic / landing ideas (with guard rails)
| Idea | Verdict |
|---|---|
| Material / room / style pages (built, 0023) | Keep; index only when populated (>= 3 products + 150+ words unique) |
| Size-based landing pages ("6-seater dining tables", "queen size beds") | Good *if* real products; use category filters + editorial, not separate thin pages |
| City pages ("furniture in Jaipur") | **Only with real per-city facts** (section keyword-map D). Doorway pages are a spam-policy violation risk. Start with one `/in/delivery` page |
| Pincode pages | No |
| Festival landing pages (Diwali/housewarming/wedding season) | Yes - evergreen URLs (`/in/gifts/diwali`) updated yearly, not new URLs each year |
| "Made-in-<state>" craft pages | No (business is Jodhpur furniture) |
| Product-comparison pages ("Sheesham vs Mango") | Yes (blog) |
| Auto-generated pages from search-console queries | No |

---

## 4. 30 article briefs

Legend: KW = target keyword; INT = intent; LINKS = internal links (money page first); CTA = call to action (Q = quote form `/in/custom-furniture`, W = WhatsApp button, S = shop category). All: answer-first opening, original photos, real numbers only, author = named person, FAQ block, last-updated date. Volume/difficulty: verify via keyword-map section 6 before writing; order suggests build priority (calendar file schedules them). Word counts are guidance (1,200-2,500).

**Pillars**
1. **Sheesham Wood Furniture: The Complete Buyer's Guide** — KW: sheesham wood furniture / is sheesham wood good for furniture. INT: I/C. Outline: what sheesham (Dalbergia sissoo) is; grain/colour; durability and hardness vs others; pros/cons; termite/moisture; price ranges (real); how to identify real vs fake; care; when not to buy. LINKS: material/sheesham, beds, tables, guides 2/3/9. CTA: S + Q.
2. **Solid Wood vs Engineered Wood (MDF/Plywood): Which Furniture Should You Buy?** — KW: solid wood vs engineered wood furniture. Outline: definitions; construction; lifespan; repair; cost; resale; where engineered is OK; checklist to spot fakes ("solid wood" claims); price myth. LINKS: category/furniture, sheesham guide. CTA: S.
3. **Custom Furniture in India: Cost, Process and Timeline** — KW: custom furniture india / custom furniture cost. Outline: what custom means; price drivers with sample cost table (from real quotes); design inputs; timeline; contract/advance; quality checks; returns; common mistakes. LINKS: custom-furniture, how-customisation-works. CTA: Q + W.
4. **Standard Furniture Sizes in India (Beds, Dining Tables, Consoles, Wardrobes)** — KW: standard bed sizes in india / dining table size for 6. Outline: cm + ft tables; room clearance rules; mattress sizes; measure-your-room worksheet. LINKS: beds, tables, custom. CTA: Q (custom size).

**Materials and comparisons**
5. **Sheesham vs Mango Wood** — KW: sheesham vs mango wood. Outline: appearance, hardness, price, maintenance, best uses, verdict by use case; photo of end grain; table. LINKS: material pages both. CTA: S.
6. **Sheesham vs Teak** — KW: sheesham vs teak. As above + outdoor/indoor guidance and cost. LINKS: teak/sheesham pages.
7. **Sheesham Wood Pros and Cons: An Honest Review** — KW: sheesham wood pros and cons. Outline: strengths; weaknesses (weight, darker tones, cracks with humidity); who should avoid. LINKS: guide 1.
8. **How to Identify Real Sheesham Wood (and Spot Fakes)** — KW: how to identify real sheesham wood. Outline: grain, weight, smell, sound, price sanity; seller questions; tests (do not damage); documents. LINKS: guide 1, quote/WhatsApp ("send us the listing, we'll tell you").
9. **Is Mango Wood Good for Furniture? Durability, Look, Care** — KW: is mango wood good for furniture. LINKS: material/mango-wood.
10. **Acacia vs Sheesham vs Mango: Choosing the Wood for Your Dining Table** — KW: best wood for dining table india. LINKS: tables.
11. **Wood Finishes Explained: Honey, Walnut, Teak, Natural (with Photo Swatches)** — KW: wood finish colours furniture. Outline: finish types (PU, melamine, oil, wax), durability, look on sheesham, samples offered. LINKS: custom. CTA: Q (request swatches).
12. **Solid Wood Furniture and Termites: What Actually Protects It** — KW: termite proof furniture / does sheesham get termites.

**Care and ownership**
13. **How to Care for Solid Wood Furniture (Monsoon, Summer, Winter)** — KW: how to care for wooden furniture. Upgrade the existing post: seasonal, humidity by city, stain/ring removal, polish schedule. LINKS: material pages.
14. **How to Remove Water Rings, Scratches and Heat Marks from Wooden Furniture** — KW: remove water ring from wood table. Video helpful (VideoObject).
15. **Wooden Furniture in Humid Cities (Mumbai, Kolkata, Chennai): Do's and Don'ts** — KW: wooden furniture humidity india.
16. **How to Clean and Polish Wooden Cutting Boards and Spice Boxes** — KW: clean wooden cutting board. LINKS: cutting-boards, spice-boxes. (existing post `kitchen-boards-and-spice-boxes-care-and-use` may be extended instead).

**Buying decisions**
17. **How to Choose a Dining Table: Size, Shape, Wood** — KW: how to choose dining table size. LINKS: tables.
18. **How to Choose a Bed: Size, Storage, Headboard, Wood** — KW: best bed for bedroom india. LINKS: beds.
19. **What to Check Before Buying Furniture Online in India (10-Point Checklist)** — KW: buying furniture online tips india. Outline: joinery, thickness, finish, delivery damage, returns, reviews, warranty; how we address each. LINKS: about/delivery. CTA: W.
20. **Console Tables: How to Pick and Style One (Entryway, Living Room)** — KW: wooden console table / how to style a console table. LINKS: room/entryway, console category.
21. **Small-Space Solid Wood Furniture Ideas for Indian Flats** — KW: furniture for small living room. LINKS: room/living-room, custom (size).
22. **Jharokha, Jaali and Carved Décor: Styling Heritage Woodwork in a Modern Home** — KW: jharokha mirror decor / jaali panel decor. (existing `styling-a-jharokha-mirror-in-a-modern-home` - upgrade). LINKS: collection heritage-living, wall-art.

**Custom, delivery, trust**
23. **How Long Does Made-to-Order Furniture Take? (Real Timelines)** — KW: how long does custom furniture take. LINKS: how-customisation-works.
24. **Furniture Delivery from Jodhpur: Timelines, ODA Charges, Assembly, Damage Claims** — KW: furniture delivery charges india / oda charges furniture. LINKS: delivery. Uses real carrier facts (icarry etc. only as cited context).
25. **Behind the Scenes: How a Sheesham Console Is Made in Our Jodhpur Workshop (with Video)** — KW: how wooden furniture is made / jodhpur furniture makers. Story + VideoObject. LINKS: made-in-jodhpur.

**Gifting and occasions**
26. **Housewarming (Griha Pravesh) Gift Ideas in Wood: 25 Ideas by Budget** — KW: housewarming gifts wooden. LINKS: gifting, combos. Publish by early Oct/Nov for wedding season & Diwali.
27. **Diwali Décor and Gifts in Wood: Ideas for Home and Family** — KW: Diwali gifts wooden / diwali home decor. Timing: publish 6-8 weeks before Diwali. LINKS: gifting, collections/gifts-that-last.
28. **Wedding Gifts and Return Gifts in Wood: What to Give and Why It Lasts** — KW: wedding gift wooden. LINKS: gifting.
29. **Wooden Toys for Babies and Kids: Safe Finishes and Channapatna Craft** — KW: wooden toys for baby safe. LINKS: toys-games, product stacking rings. E-E-A-T on safety claims (vegetable-dye lacquer; state only what is true; BIS/toy-safety standards note - legal check).
30. **Buying Furniture for a Cafe, Homestay or Office: Custom vs Off-the-Shelf** — KW: custom furniture for cafe / bulk furniture manufacturer. LINKS: custom-furniture/for-business. CTA: Q.

---

## 5. Off-page and channels

### 5.1 Google Business Profile (GBP) for the Jodhpur workshop
- Eligibility: GBP requires in-person contact with customers during stated hours (Business eligibility guidelines, https://support.google.com/business/answer/13763036, accessed 2026-09-25; snippet-level - read it in full). A back-room carpenter workshop that is not open to the public may be ineligible or must be a **service-area business** (address hidden, service areas listed). **Decision for owner:** if customers can visit a showroom/workshop with posted hours -> standard listing, with photos, "furniture manufacturer"/"furniture store" category. If not -> either create a service-area listing (risky, Google can suspend for eligibility) or skip GBP and use directories. Do NOT use a virtual office/fake address (suspension + policy).
- If eligible: primary category "Furniture manufacturer" (or "Custom furniture maker" if available - check category list), secondary "Furniture store", "Wood working"; description with custom/made-to-order/Jodhpur; products with photos and prices; Posts weekly (new pieces, custom builds); Q&A seeded with real questions; photos (workshop, team, finished pieces: 10+ at launch, 3-5 per month); attributes; hours; WhatsApp/phone; UTM on the website link. Reviews (5.8).
- Value: local pack for "furniture manufacturer Jodhpur", "carpenter near me" (Jodhpur only), brand panel. It won't drive national sales; it builds trust and brand SERP.

### 5.2 Citations and directories — honest evaluation
| Directory | Use | Value for us | Caveats |
|---|---|---|---|
| **IndiaMART** | B2B lead marketplace | Useful for B2B/bulk/wholesale leads and as a discoverable manufacturer profile; a brand mention/link | Paid plans are the norm for visibility; lead quality for B2C is low and price-shopping heavy; links are typically nofollow (ASSUMPTION - check); do not compete on price with resellers. Listing as "manufacturer" helps B2B (cafe/hotel/exporter) inquiries. Use it for the B2B side, not D2C |
| **TradeIndia / ExportersIndia** | B2B/export | Low-medium; export buyers do use them; free listing worth 1 hour | Spam-heavy, many low-quality inquiries |
| **Justdial** | Local consumer directory | Medium for local Jodhpur business awareness; NAP consistency | Aggressive paid upselling; skip paid; claim free listing; watch fake call-backs |
| **Sulekha / Google Maps aggregators / Facebook Page / Instagram / Apple Maps / Bing Places** | Free profiles | Low-medium; **NAP (name, address, phone) consistency** matters for local | Keep identical details everywhere |
| **Houzz India / Pinterest / Behance** | Discovery | Houzz - relevant for home-design audience (verify India presence) | |
| **Wedding directories (WedMeGood etc.), Urban Company-type?** | Occasion | Only if the gifting/dowry-furniture angle is pursued | |
General principle: 8-15 high-relevance listings with identical NAP beat 100 low-quality ones (bulk directory submission is a link-scheme risk, Google spam policies). Time-box: 1 day at launch.

### 5.3 Backlinks (realistic, white-hat)
Targets, in order of effort/value:
1. **Craft and trade bodies**: EPCH (Export Promotion Council for Handicrafts) - membership INR 5,000/yr + INR 2,500 joining (search results 2026-09-25; verify at epch.in) gives a member listing, buyer-seller meets, RCMC; also helps the US export path (Vriksh certificates - `market-selection.md`). Rajasthan state handicraft/MSME/DIC (District Industries Centre, Jodhpur), RIICO, Jodhpur Chamber of Commerce, Jodhpur Handicrafts Exporters Association (verify existence), Craftmark/AIACA/Dastkari Haat Samiti events - members pages link out.
2. **Design/home blogs and creators**: Indian interior designers, architects, home-décor bloggers/Instagrammers; offer a piece for a feature or a co-authored guide (disclose as sponsored/gifted; use `rel="sponsored"` for paid).
3. **Wedding/home/lifestyle publications**: pitch "custom furniture cost guide" data, "how a Jodhpur console is made" photo essay; regional press (Dainik Bhaskar Jodhpur, Rajasthan Patrika) for the workshop story - local press earns links and GBP trust.
4. **HARO-equivalents for India**: Qwoted / Featured.com / Source of Sources (Peter Shankman's) / Terkel / Help a B2B Writer / X (#journorequest, #PRrequest) — HARO itself was relaunched (Connectively -> Featured; ESTIMATE, verify current status); Indian-specific: journalists on X/LinkedIn asking for home/design experts, "Contify"/"Qwoted" listings. Free tier = time investment ~2 hrs/week.
5. **Digital PR angles from the workshop** (need the owner's real story): (a) "What custom furniture really costs in India" — real quote data; (b) "Sheesham, mango, teak - a Jodhpur carpenter's honest comparison"; (c) photo/video "one console, 90 hours" (hand-carving time-lapse); (d) apprenticeship story of the carpenter team (women/youth employment if true); (e) "traditional Rajasthani joinery in modern flats"; (f) sustainability: legal-origin sheesham, waste reuse; (g) festival tie-ins (Diwali/housewarming).
6. **Resource/link magnets**: measurement worksheet PDF, size chart image, "wood comparison" infographic (embed with credit), wood-care calendar.
7. **Supplier/customer links**: hardware/finish suppliers, delivery partner, carpenter's own social profiles, friends' blogs (real, not bought).
Avoid: paid links, PBNs, guest-post farms, bulk directory blasts, comment spam. Realistic target: 15-30 relevant referring domains in 6 months (ESTIMATE); 1-3 truly editorial links in 90 days would be a good result.

### 5.4 YouTube SEO
- Channel: "The Wood Vintage - Jodhpur Furniture"; banner + description with links + `sameAs` in Organization schema.
- Content types (search-driven): "How to identify real sheesham" (10 min), "Sheesham vs mango wood" (comparison), "How a console table is made" (process), "Custom furniture: how to give measurements", "Room walk-throughs with our pieces", Shorts of finishing/carving (feeds Instagram Reels too).
- Metadata: title = query-led + brand (<= 60 chars), description first 2 lines = keyword + link to page, chapters, pinned comment with quote CTA/WhatsApp, English + Hinglish titles/captions (upload SRT), tags minor, custom thumbnail, playlist per topic.
- Embed the video on the matching guide/product page with `VideoObject`.
- Cadence: 1-2 long + 3-4 Shorts per month (capacity ASSUMPTION; production is the bottleneck).

### 5.5 Pinterest SEO
Pinterest is a search engine for décor intent and refers durable traffic (pins live for months). Steps: Business account, claim domain, enable Rich Pins (Product pins from Merchant/feed; Article pins from blog), boards by room/style/material/occasion, keyword-rich pin titles + descriptions (<= 100/500 chars), vertical 2:3 images (1000x1500) with clear overlay text, 3-5 pins/day (fresh pins per URL), link every pin to the specific page (with UTM), Pinterest catalogue feed after Merchant feed exists. Expectation: early impressions in 4-8 weeks; small conversions, high saves (ESTIMATE).

### 5.6 Instagram/Facebook interplay
Not covered in depth here (`marketing/social-media-playbook.md`), but SEO-relevant: profile links to the site with UTM; bio contains "custom furniture Jodhpur"; alt text on posts; hashtags are not ranking factors on Google; brand-name consistency.

### 5.7 Marketplace listing SEO (Amazon.in / Flipkart / Etsy / others) — India-first
Marketplaces are search engines themselves; relevant for **small décor and gifts** (not large custom furniture). Fit with the brand: they give reviews/social proof and discovery, at fee + price-comparison cost; brand-protection issue with "handmade" claims. Owner to decide after order #30-50 (`market-selection.md`).
Title formulas (write for the marketplace's own algorithm; keep <= 200 chars on Amazon, front-load the first ~80):
- **Amazon.in**: `[Brand] [Product type] - [Material] [Key attribute] | [Size/Dimensions] | [Use/Room] | [Finish/Colour] | Handmade in Jodhpur` e.g. "The Wood Vintage Sheesham Wood Console Table - Solid Wood Hand-Carved Entryway Table 90 cm, Honey Finish, Handmade in Jodhpur". Bullets (5): material/build, size, custom option, finish/care, delivery/warranty; A+ content with workshop photos; backend search terms (Hinglish variants, no repeats); use Brand Registry if trademark is filed (ASSUMPTION: not yet).
- **Flipkart**: `[Brand] [Material] [Product] ([Size], [Colour])` shorter; structured attributes matter more; Flipkart has strict furniture listing rules (delivery/assembly).
- **Etsy (India sellers can list)**: first 40 chars weighted most; 13 tags with long-tail phrases; attributes filled; renewal not needed. Etsy ranks on query match (~40%), listing quality/CTR/conversion (~35%) and shop experience (~25%) per 2026 seller-guide summaries (https://blog.marmalead.com/etsy-algorithm-2026/ , accessed 2026-09-25 - third-party, ESTIMATE). Formula: `[Primary keyword phrase] | [Material] [Type] | [Style] | [Use/gift]` e.g. "Hand carved wooden wall panel, Krishna sheesham wood decor, Indian temple art housewarming gift". US-oriented spellings in the US plan.
- **Pepperfry/Urban Ladder-type marketplaces**: essentially curated; approach via vendor onboarding, low priority.
- **Amazon Karigar / Flipkart Samarth / GeM (Government e-Marketplace)**: government-supported handicraft/MSME programmes exist (verify current names and eligibility with EPCH/DC Handicrafts); can lower marketplace fees for artisans - ASSUMPTION, verify.
Cross-channel rule: same product names and SKUs everywhere; use marketplaces to collect reviews and photos, then send buyers (in packaging inserts, allowed by rules?) — careful: marketplaces prohibit diverting buyers off-platform; obey each marketplace's policy.

### 5.8 Review generation (real reviews only)
- Post-delivery flow: WhatsApp message on day 3-7 with a one-tap Google review link (GBP "Get reviews" link) and a product review link on-site; ask for photos; incentives may not condition on positive ratings; do not gate. Never write, buy or seed reviews (`docs/claude/seo-rules.md`; India CCPA/ASCI disclosure norms, ASSUMPTION - legal check).
- Show reviews on product pages with photos (real), mark up only real reviews (technical checklist section 8).
- Video testimonials from the first 10 customers; get written consent for names/photos.
- Respond to every review within 48 hours; treat negative ones as content (how we fixed it).
- Target: 10 Google reviews + 10 site reviews by order #30; 25+ by order #100.

---

## 6. Measurement, cadence, 90-day roadmap, honest timelines

### 6.1 KPIs
| Tier | KPI | Source | Target (ESTIMATE; recalibrate from real data) |
|---|---|---|---|
| Health | Indexed pages / submitted pages | GSC Pages | >= 90% of intended indexable URLs within 30 days of launch |
| Health | Core Web Vitals pass (mobile) | PSI, GSC CWV | LCP <= 2.5 s, INP <= 200 ms, CLS <= 0.1 |
| Health | Structured data valid | Rich Results Test, GSC | 0 errors on Product/Organization |
| Visibility | Impressions, average position (non-brand) | GSC | 30d: 500-3,000 impressions; 90d: 5,000-30,000; 180d: 30,000-150,000 (wide ESTIMATE) |
| Visibility | Brand queries | GSC | "the wood vintage" ranks #1 by day 14 |
| Traffic | Organic sessions | GA4 | 30d: 100-500; 90d: 1,000-5,000; 180d: 5,000-20,000 (ESTIMATE, assumes 2 posts/week + links) |
| Engagement | Organic engaged-session rate, pages/session | GA4 | > 55% |
| Conversion | Quote/WhatsApp leads from organic | GA4 events + 0034 lead source | 90d: 5-25 leads; 180d: 20-80 |
| Revenue | Organic orders and revenue | GA4/orders (UTM discipline) | 90d: 0-3 orders; 180d: 5-20 orders/month |
| Authority | Referring domains (relevant) | GSC Links, Ahrefs Webmaster Tools (free) | 90d: 5-10; 180d: 15-30 |
| Local | GBP views, calls, direction requests, reviews | GBP | 10 reviews by day 90 |
| Content | Articles published; top-10 keywords count | Sheet | 24 articles by day 90 |
| Merchant | Free-listing impressions/clicks | Merchant Center | first data by day 30-45 |

### 6.2 Rank-tracking method (free)
1. **Ground truth**: Search Console (Performance -> Queries, Country India, Device mobile) weekly export to Sheets (Looker Studio connector optional).
2. **Fixed keyword set** (30-40 rows from keyword-map, P0/P1) checked monthly in an incognito, logged-out, India-location browser (or Ubersuggest/AccuRanker trial; avoid one-off Google scrapers). Record position + SERP features + who ranks.
3. **Bing Webmaster** for a second signal; **Google Business Profile** performance for local.
4. Do not chase daily fluctuations; review trends over 28-day windows.

### 6.3 Search Console review cadence
Weekly (30 min): Coverage/Pages (new errors), Performance top queries/pages, CWV, Merchant listings warnings, Crawl Stats response time, Manual actions. Monthly (2 h): content decisions (which queries have impressions but low CTR -> rewrite titles; positions 8-20 -> add depth/links; pages with 0 impressions after 60 days -> improve/merge/noindex). Quarterly: strategy reset with real volumes.

### 6.4 90-day roadmap (starting from a go-live date "D"; today is 2026-09-25 and the site is noindex, so pre-launch work starts now)
| When | Work | Owner |
|---|---|---|
| **Pre-launch (now -> D)** | Fix W-01/02/03/14/15/19; photo shoots for >= 12 products (4+ images each); write custom-furniture, how-customisation-works, made-in-jodhpur, delivery, FAQ; owner supplies lead times/price factors; GSC/Bing/GA4/Clarity/Merchant Center setup; GBP decision; 6 anchor guides drafted (briefs 1, 2, 3, 5, 6, 8) | SEO + owner + dev (later) |
| **D (week 0)** | Remove noindex (staged), sitemap submit, inspect 10 URLs, baseline screenshots | SEO/ops |
| **Weeks 1-2** | Publish P0 pages/guides; GBP verification (postcard/video); citations (10); Pinterest account + 30 pins; first outreach (EPCH/DIC, 5 bloggers) | |
| **Weeks 3-4** | 2 guides/week; product feed -> Merchant Center; first review requests; YouTube channel with 2 videos | |
| **Month 2 (weeks 5-8)** | 8 guides; category pages/copy refinement using GSC queries; 10 pitches; Diwali/housewarming content live (Diwali 2026 is in early Nov; publish by mid-Sep to catch it — if go-live is later, treat as 2027 asset and do a fast Dhanteras/wedding-season push) | |
| **Month 3 (weeks 9-12)** | 8 more guides; comparison pillars finished; first data-driven rewrites; link-magnet PDF; digital PR pitch #1 (custom furniture cost study); decide city pages using real delivery data | |
| **Days 90-180** | Publish 4-6/month; expand categories to range; video series; 20 more pitches; review growth; Hindi pages if data supports; consider US/UAE pilot pages (`us-uae-seo-plan.md`) | |

Diwali 2026 falls on 8 November 2026 (ESTIMATE from public calendars - verify); with the site still noindex on 2026-09-25, **organic Diwali sales are not realistic this year** unless launch happens within ~3 weeks *and* content is live; rely on social/WhatsApp for Diwali 2026 and use SEO to prepare for 2027.

### 6.5 Honest expectations (new domain; no measured benchmark - ESTIMATE)
- **Day 0-30**: pages indexed (Google: "several hours to several weeks"); impressions in the tens-hundreds, mostly brand and odd long-tail; rankings mostly beyond page 3; 0 organic orders is normal. Good outcomes: 80-100% of indexable pages indexed, brand #1, GBP live, no errors.
- **Day 30-60**: first non-brand impressions on Win-tier guides; average positions 20-60; a few clicks per day at best.
- **Day 60-90**: first page-2/3 → some page-1 for the longest-tail; 1,000-5,000 organic sessions cumulative is plausible; 0-3 organic orders; leads from custom-furniture page from social traffic dominate.
- **Day 90-180**: with 40-50 quality pages + 15-30 referring domains, first stable page-1 rankings for Win keywords (e.g., sheesham vs mango, how to identify sheesham) and long-tail product/custom queries; organic starts to produce 5-20 orders/month *if* conversion (custom quote -> order) works.
- Google says there is no official "sandbox", but new sites take time to be trusted (Mueller, SEJ link above). Assume 3-6 months before competitive terms move; 12+ months for head terms.
- Everything above hinges on: catalogue breadth, real photos, real reviews, conversion of leads, and consistent publishing. A 2-SKU catalogue will not attract meaningful SEO regardless of tactics.

---

## 7. Dependencies, blockers and risks (owner + engineering)

**Owner inputs needed** (blocks P0): product range list (what can be made), lead times per category, price-factor breakdown, real workshop address/hours/visitability, phone/WhatsApp/email, 12+ products photographed, 2-3 minute workshop video, carpenter names/consent, legal-origin timber documents, GST/legal pages, returns policy for custom pieces, budget for photos/videos/EPCH membership.
**Engineering ("website changes needed later")**: see technical-seo-checklist.md section 12 (W-01 ... W-21). Most critical: W-01/W-02 (product SSR + sitemap), W-03 (canonicals), W-14 (schema + feed), W-15 (custom-furniture/how-customisation-works/made-in-jodhpur/delivery/guides), W-19 (placeholder/fake content removal), W-05 (thin-page gate), W-07 (verified crawler exemption).
**Top SEO risks**: (1) launching with broken product pages (F1) or empty taxonomy pages; (2) the 0036 geo-lock mishandling Googlebot (US IP) or unverified UA exemption; (3) fake/seeded reviews or backdated blog dates; (4) doorway city pages; (5) thin 2-SKU catalogue; (6) new-domain trust delay mismatched with expectations; (7) head-term chasing vs Win-tier discipline; (8) price/"30% below" claims that mislead; (9) 2-CPU origin slowing crawl/CWV without caching; (10) copied competitor text (never do).

---
Sources (accessed 2026-09-25): repo files listed in technical checklist; live GET requests; Google Search Central (locale-adaptive, spam policies, Product structured data, Business Profile eligibility https://support.google.com/business/answer/13763036); Search Engine Land / Search Engine Journal (Mueller); EPCH membership summaries (taxguru.in, epch.in via search); Etsy algorithm summaries (blog.marmalead.com); IndiaMART/Justdial listing overviews (search results); Wooden Street, Woodsala pages. Search volumes: none obtained.
