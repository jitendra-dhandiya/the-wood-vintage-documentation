# Customer-psychology gap tracker

Owner: UX / conversion-psychology. Written 2026-09-25 (development on hold; documentation only).
Goal it serves: the first 100 orders for a handmade, made-to-order, customisable furniture D2C brand,
with first-time buyers arriving from Instagram, Facebook and Google ads, mostly on mobile in India
(later US, UAE, UK).

## How this was produced

- Read: `CLAUDE.md`, `docs/agents/ux-agent.md`, `docs/agents/ecommerce-agent.md`, decisions 0029, 0030, 0033,
  0034, 0035, 0037, 0039, `docs/claude/technical-debt.md`, `tasks/TASKS.md`, `docs/qa/2026-09-20-rebrand-qa.md`.
- Read the storefront code: `components/product/ProductDetailClient.tsx`, `QuoteLead.tsx`, `app/[country]/(store)/{cart,checkout,order-success,faq,shipping-policy,return-policy,track}`,
  `components/layout/{Footer,MobileBottomNav}.tsx`, account routes, homepage seed (`backend/prisma/seed-data/{homepage,content}.ts`).
- Read-only GETs against production (`/api/v1/settings/public`, `/api/v1/products`, headless-Chrome screenshots of
  `/in` at 390px). No orders placed, nothing written.
- "Evidence" below is a file path or URL that was actually opened. Anything I could not verify is marked
  **(unverified)**. Impact ratings are reasoned from the mechanism, not from invented conversion statistics; none of
  them has been measured on this site (there is no traffic data yet).
- UX-agent guardrail applied throughout (`docs/agents/ux-agent.md`): no fake urgency, no fake proof, no dark
  patterns. Every scarcity or social-proof item below is "only if true".

## Legend

Impact H/M/L = expected effect on first-100-orders conversion. Effort S (under a day) / M (days) / L (a week+).
Priority: P0 = fix before paid traffic (credibility or legal risk), P1 = do for first 100 orders, P2 = after first
orders/data, P3 = later or market-specific. Status is Open for all. Every item's "Later" line is the implement-later note.

## The five findings that matter most

1. **Policies describe a parcel shop, not a furniture maker** (return-policy, faq, shipping-policy). 36-hour window, store
   credit only, mandatory unboxing video, Instagram-only support, "dispatch in 1-2 business days", flat Rs 79 shipping. For
   made-to-order furniture at Rs 20k-65k this is the single largest trust gap and it contradicts the PDP's own
   "Made to order - ships in N days".
2. **Fabricated social proof and provenance ships in the seed** and (per the runbook) production boilerplate matches local:
   six invented testimonials with city names, "8 Artisan workshops", "Saharanpur, Jodhpur and Channapatna" while the real story
   is a carpenter team in Jodhpur, "seasoned, certified timber", "packed and insured". Must be replaced or hidden before ads.
3. **Contact channels are placeholders in production**: `whatsapp_number` = `919876543210`, `site_phone` = `+91 98765 43210`,
   `instagram_url` empty, `lead_notification_email` empty (verified live on `/api/v1/settings/public`). The primary CTA
   ("Get Best Quote") therefore sends leads nowhere a human is watching, and the WhatsApp button opens a stranger's number.
4. **Real photography is missing**: 3 of 46 seeded products have a real photo (decision 0030); production has 2 products.
   Nothing else in this document out-converts real workshop, product-in-room and detail photography for a handmade brand.
5. **Checkout is built for low-ticket parcels**: login required before the address form, COD = pay delivery online then cash on
   delivery, static "5-7 business days" per shipping method, no pincode check, `country: 'India'` hard-coded, no advance-payment
   path for custom orders.

---

## A. Landing and discovery (ads, homepage, category, search)

### AWR-01 Fabricated testimonials and counters on the homepage
- **Evidence:** `backend/prisma/seed-data/content.ts` `TESTIMONIALS` (Ananya R. Bengaluru, Vikram S. Mumbai ... "delivery and assembly were smooth"),
  rendered by `TESTIMONIALS` homepage section; `seed-data/homepage.ts` `stats: '8' Artisan workshops`; decision 0029 admits testimonials/artisans/blogs are "fictional demo".
- **Missing/wrong:** Invented reviews and numbers presented as real customers/facts. There have been no orders yet, so none of these can be true.
- **Principle:** Authenticity and trust; social proof works only when believed, and one detected fake collapses all other trust cues. Also a legal exposure (misleading advertising / consumer-protection rules on fake reviews).
- **Impact:** H (negative today: a sceptical first-time buyer on a Rs 40k purchase looks for exactly this).
- **Effort:** S. **Dependency:** none to remove; real reviews need real customers.
- **Approach:** Hide the `TESTIMONIALS` section and the "8 Artisan workshops" stat now (admin Homepage Builder toggle, no deploy). Replace with founder/carpenter statement and real-count facts ("Made by our own carpenters in Jodhpur"). Re-enable when there are real reviews with permission.
- **Priority:** P0. **Status:** Open. **Later:** add a review-request flow (POS-04) so the section fills with true content; keep a "verified buyer" tag.

### AWR-02 Provenance story does not match the business
- **Evidence:** homepage `BRAND_SECTION` copy and hero ("workshops of Saharanpur and Jodhpur"), footer/`site_description` ("Saharanpur, Jodhpur, Kutch and beyond"); brief says the makers are a carpenter team in Jodhpur.
- **Missing/wrong:** Claims of multi-city craft clusters and "family workshops"; images are Wikimedia stock (decision 0030) of unrelated craftsmen.
- **Principle:** Provenance and authenticity ("made in Jodhpur" is a strength: Jodhpur is a recognised furniture centre); mismatch between story and reality is the classic handmade-brand trust leak.
- **Impact:** H. **Effort:** S copy / M photos. **Dependency:** owner facts + real photos (see owner list).
- **Approach:** Rewrite hero, `BRAND_SECTION`, about page, footer blurb around the real story: who the carpenters are, years of experience, workshop location, wood sourcing. Name the founder. Show Jodhpur on a small map/badge.
- **Priority:** P0. **Status:** Open. **Later:** "Meet the workshop" page with a 60-90s video.

### AWR-03 Real photography and video absent
- **Evidence:** decision 0030 consequences ("only 3 of 46 products have real photos", artisan portraits are initials); QA doc ("Product images and most banners are labelled placeholders"); production has 2 products only.
- **Principle:** Perceived risk reduction through concrete evidence (can I see the real thing, the real grain, the real people?). For online furniture, photos are the product.
- **Impact:** H. **Effort:** L (shoot). **Dependency:** owner assets.
- **Approach:** Shot list per product: hero on white, in-room, 3 detail macros (joinery, carving, finish), scale shot with a person or common object, back/underside. One 20-30s vertical video per hero product (Instagram reuse). Replace Wikimedia images; until then remove images from the first fold where a stock photo could be mistaken for the maker.
- **Priority:** P0. **Status:** Open. **Later:** UGC gallery from customers (RET-06).

### AWR-04 Every product shows a "Save X%" chip and Sale link
- **Evidence:** QA doc "Every product shows a Sale badge because every product has a compare-at price"; `ProductDetailClient.tsx` renders `Save {discount}%`; footer link "Sale" (`/shop?discount=true`); announcement bar "USE CODE WELCOME10".
- **Principle:** Anchoring works when the reference price is credible; a permanent strike-through on a handmade, made-to-order item reads as inflated MRP (common in Indian D2C and increasingly distrusted). Reference-price rules also apply in consumer law.
- **Impact:** M. **Effort:** S. **Dependency:** owner pricing decision.
- **Approach:** Use compare-at only where a real prior price existed or for a true launch offer with an end date. Otherwise show a single honest price and anchor with value ("solid sheesham, 4 weeks of hand work") instead. Remove the "Sale" footer link when nothing is on sale.
- **Priority:** P1. **Status:** Open. **Later:** anchor via combo savings (already supported, decision 0037).

### AWR-05 Mobile header overflows at 390px (verify)
- **Evidence:** headless-Chrome screenshot of `https://thewoodvintage.com/in` at 390 wide shows nav links ("NEW IN", "SHOP", "COLLECTION...") clipped at the right edge and no visible menu trigger. QA 2026-09-20 reported no overflow, so this may be a headless viewport artefact. **(unverified on a real phone)**.
- **Principle:** Thumb-zone and first-impression usability on the dominant traffic device.
- **Impact:** H if real, L if artefact. **Effort:** S. **Dependency:** real-device check.
- **Approach:** Test on a real 390px iPhone and a 360px Android; screenshot at those widths via CDP with device metrics emulation (not `--window-size`). Fix header breakpoint if reproduced.
- **Priority:** P0 (check). **Status:** Open. **Later:** add a Playwright/CDP layout guard at 360/390/412 to CI.

### AWR-06 Announcement bar and hero optimise for discounts, not for the real offer
- **Evidence:** `announcement_text` = "FREE SHIPPING ON ORDERS ABOVE Rs 4,999 | USE CODE WELCOME10 ..." (live settings). Free shipping above 4,999 will apply to nearly every furniture order, so it is not a differentiator; WELCOME10 has minOrder 2,999 and max Rs 1,500.
- **Principle:** Message-market fit. The high-value promise for this buyer is made-to-size, made-by-hand, and a person who answers, not a shipping threshold.
- **Impact:** M. **Effort:** S. **Dependency:** owner offer decisions.
- **Approach:** Replace with "Made to your size in Jodhpur | Free design help on WhatsApp" and keep the coupon as a secondary message once real. Put the reply-time promise (`lead_response_promise`) there.
- **Priority:** P1. **Status:** Open. **Later:** rotate messages by campaign using UTM (`wv_attribution`) so an Instagram ad landing gets a matching bar.

### AWR-07 Ad-landing continuity (UTM-aware landing pages)
- **Evidence:** UTM captured (decisions 0025/0026) but nothing reads it to change page content; ads will land on `/in/product/...` or `/in`.
- **Principle:** Message match (scent trail): the promise in the ad must be visible in the first screen after the click.
- **Impact:** M. **Effort:** M. **Dependency:** ad creatives.
- **Approach:** Two or three lightweight campaign landing pages (e.g. "Custom beds in sheesham", "Study desks") reusing existing sections, with the ad's headline, price-from, lead form above the fold. Reuse `COMBO_OFFERS` and `SHOP_BY_LOOK` blocks.
- **Priority:** P2. **Status:** Open. **Later:** decide after first ad results.

### AWR-08 Search and category: no size/price-band/room quick paths, no "not found" recovery to quote
- **Evidence:** decision 0039 gaps ("no size facet in search"), filter chips limited to Finish (Natural/Walnut/Honey); search facets Material/Style/Room/price (Phase 4). No empty-search state offering "tell us what you need".
- **Principle:** Reduce search cost; a failed search should convert into a lead, not a bounce.
- **Impact:** M. **Effort:** S (empty state) / M (facets). **Dependency:** none.
- **Approach:** Empty/low-result search shows a "Can't find it? We make it to order - tell us" card opening the existing lead dialog with `source=SEARCH`. Add price-band chips and "Ready to ship / Made to order" filter once the catalogue is bigger.
- **Priority:** P2. **Status:** Open. **Later:** typo tolerance/synonyms (tracked in TASKS Phase 4).

### AWR-09 Catalogue thinness in production
- **Evidence:** runbook "only 2 products (hand-carved-krishna-panel, channapatna-stacking-rings)"; the seeded 46-product catalogue is placeholder-imaged.
- **Principle:** Choice adequacy; a 2-item shop looks abandoned, a 46-item shop of placeholders looks fake.
- **Impact:** H. **Effort:** M-L. **Dependency:** owner: which 8-12 hero pieces to launch with, with real photos and real prices.
- **Approach:** Launch with a small, fully real catalogue (8-12 items across bed / table / seating / storage). Hide everything without real photos (`isActive=false`), do not show placeholders publicly.
- **Priority:** P0. **Status:** Open. **Later:** grow category by category as photos arrive.

---

## B. Consideration (product page)

### CON-01 No returns / repair / warranty statement at the point of purchase
- **Evidence:** PDP trust row (`ProductDetailClient.tsx` ~L802-813): "Shipped in protective packaging", "Hand-finished by artisans" (uses the Replay/return icon), "Secure payments". Nothing on returns, repair, or warranty. `return-policy/page.tsx`: 36-hour window, store credit only, no refund.
- **Principle:** Risk reversal. Buyers of high-ticket items look for the "what if it is wrong" answer next to the buy button. A mismatched return icon on a non-return claim is also confusing.
- **Impact:** H. **Effort:** S (copy) after policy decision. **Dependency:** owner policy (see CON-02).
- **Approach:** Replace the trust row with 4 true, specific lines: "Free repair of manufacturing defects for N years", "Made-to-order: 50% advance, balance before dispatch" (if true), "Delivered and assembled by our team" (if true), "Real person replies within 1 business day". Each links to the relevant policy anchor.
- **Priority:** P0. **Status:** Open. **Later:** add a compact "Our promise" accordion under the CTA.

### CON-02 Policies contradict made-to-order furniture (return, dispatch, shipping)
- **Evidence:** `return-policy/page.tsx` (36 hours, store credit only, unboxing video, request only via Instagram), `faq/page.tsx` ("dispatched within 1-2 business days", "3-5 business days to metro"), `shipping-policy/page.tsx` (Rs 79/149/249, 1-2 day processing, Shiprocket/Delhivery/BlueDart parcel carriers), `order-success/page.tsx` ("Shipped within 1-3 business days"). PDP says "Made to order - ships in N days".
- **Principle:** Consistency and expectation management; contradictory promises are the top source of post-purchase disputes and pre-purchase doubt.
- **Impact:** H. **Effort:** M. **Dependency:** owner decisions on lead time, advance %, cancellation window for custom pieces, damage claim process, freight method.
- **Approach:** Rewrite as furniture policies: standard vs made-to-order vs custom; lead times by category; cancellation until production starts; damage-in-transit (photos within 48-72h, courier-inspected, replaced/repaired); repair promise; wood-variation clause (already present in FAQ); support by phone/WhatsApp/email, not Instagram only. Single source of truth for charges (QA doc: settings 199/499 vs code 79/149/249).
- **Priority:** P0. **Status:** Open. **Later:** legal review before US/UAE/UK launch.

### CON-03 No delivery estimate or shipping cost on the product page; no pincode check
- **Evidence:** No pincode/delivery widget anywhere in storefront (grep of `app/`, `components/`); static `days: '5-7 business days'` in `constants/index.ts`; only the made-to-order line on PDP. Settings expose a `self_delivery_pincodes` key in production, so a pincode concept exists in the backend **(behaviour unverified)**.
- **Principle:** Uncertainty aversion; "when will it reach me and what will it cost" is the top-two question after price. Hidden shipping surprises at checkout are a leading abandonment cause.
- **Impact:** H. **Effort:** M. **Dependency:** owner: delivery method and freight cost by zone; backend pincode/zone table.
- **Approach:** "Enter pincode" box under the price: returns "Made in about N days + X-Y days transit = deliver by <date range>" and shipping cost or "Free". Persist pincode in cookie, prefill checkout. Honest wording: ranges, not exact dates.
- **Priority:** P1. **Status:** Open. **Later:** for US/UAE/UK show a "ships from Jodhpur, 3-6 weeks" band by country.

### CON-04 Flat Rs 79 shipping is not credible for furniture
- **Evidence:** `SHIPPING_METHODS` (Rs 79/149/249) in `constants/index.ts`; per-product override exists (`standardShippingCharge`) but the storefront only shows the flat rate until checkout; free above Rs 4,999.
- **Principle:** Transparency; a beds-and-tables buyer knows freight costs money. A Rs 79 quote either signals a scam or later becomes a surprise.
- **Impact:** H. **Effort:** S-M. **Dependency:** owner freight costs.
- **Approach:** Per-product/per-category freight in admin (fields exist), show "Delivery included" on the PDP where absorbed into price, or the actual figure. Retire the small-parcel Express option for large items.
- **Priority:** P1. **Status:** Open. **Later:** carrier integration (TASKS: none exists).

### CON-05 Price psychology: no anchoring on value, no EMI/pay-in-parts, no GST clarity
- **Evidence:** PDP price block shows price + strike-through only; no EMI line; cart says "Taxes calculated at checkout"; `Product.taxPercent` global (technical-debt "No per-country tax rate model"); decision 0035: GST `taxAmount` display-only.
- **Principle:** Mental accounting ("from Rs X/month" makes a Rs 45k bed feel like a monthly decision); transparent all-in pricing reduces "checkout shock".
- **Impact:** H for EMI on Rs 20k+ items; M for GST wording.
- **Effort:** S (wording) / M (EMI). **Dependency:** Razorpay/Cashfree account enabling card EMI/pay-later; owner statement of whether prices include GST.
- **Approach:** Show "Inclusive of GST" under price. For items over Rs 15k show "EMI from Rs X/month" using the gateway's offer API or a plain formula labelled "with eligible cards". Never show a fake "no-cost EMI" unless the gateway actually provides it.
- **Priority:** P1. **Status:** Open. **Later:** lower-priority: price breakdown "what you are paying for" tooltip (wood, labour).

### CON-06 No reviews on the product page (list, submit, photos)
- **Evidence:** `ProductDetailClient.tsx` shows a `Rating` only when `totalReviews > 0`; no review list/submit UI in the PDP (no reviews component in `components/product/`); `ProductCard` shows count similarly.
- **Principle:** Social proof, specifically for the "people like me bought this" question. Honest empty state beats fake.
- **Impact:** H long-term, L on day one. **Effort:** M. **Dependency:** real orders; backend review model exists as `totalReviews/avgRating` fields **(submission API unverified)**.
- **Approach:** Verified-buyer reviews with photo upload, requested by WhatsApp/email 10-14 days after delivery (POS-04). Until then, no stars. Consider "Reviewed by our first 10 customers" wall with real quotes gathered by hand from WhatsApp, with written permission.
- **Priority:** P2 (P0 to remove fakes, see AWR-01). **Status:** Open. **Later:** aggregate rating into Product JSON-LD only when real.

### CON-07 Scarcity is only the low-stock line; made-to-order slots and batch dates not expressed
- **Evidence:** `lowStockLeft` (<=5) and `manufacturingTimeDays` line in `ProductDetailClient.tsx`. Good: no fake counters (decision 0034). Missing: real capacity signals.
- **Principle:** Truthful scarcity. A small carpenter team has genuinely finite production capacity.
- **Impact:** M. **Effort:** S once data exists. **Dependency:** owner: real monthly capacity / next production batch date.
- **Approach:** Admin setting "Next production slot: <month>, N slots left", shown on made-to-order PDPs and in the quote sub-line only while true, with a date it expires. Festive-season cut-off banners (Diwali/wedding season) with real dates.
- **Priority:** P2. **Status:** Open. **Later:** display "Ready to ship" vs "Made to order" tag on cards.

### CON-08 Decision support: no room-fit help, size guidance, AR, samples, comparison
- **Evidence:** PDP shows size chips and alternate units (decision 0039) but no "will it fit" guidance, no clearance/door-width note, no scale image, no wood/finish sample offer, no compare. `product.sizeChart` field exists (null in prod product).
- **Principle:** Reduce anticipated regret; fit and finish are the two reasons furniture is returned.
- **Impact:** H. **Effort:** S (scale diagram + guide) to L (AR).
- **Dependency:** measurements per product; owner: sample policy.
- **Approach (in order):** (1) dimensions block with a to-scale silhouette next to a person (170 cm) and a "measure your space" tip (door, lift, staircase); (2) "Order a finish/wood swatch for Rs X (adjusted against your order)" - ships fast, high-trust; (3) "Send us a photo of your room, we suggest a size" via the existing WhatsApp CTA; (4) Google `<model-viewer>` AR only for hero SKUs later; (5) simple 2-3 item compare only when catalogue is larger.
- **Priority:** P1 for (1)-(3), P3 for AR/compare. **Status:** Open. **Later:** measure-in-your-room overlay.

### CON-09 Finish selection has no swatch imagery
- **Evidence:** finishes rendered as text `OptionBox` chips (Natural / Walnut / Honey) in `ProductDetailClient.tsx`; images can be tagged by colour (gallery groups) but swatch photos do not exist.
- **Principle:** Concreteness; a colour word is ambiguous, a photographed swatch on the actual wood is not.
- **Impact:** M. **Effort:** S. **Dependency:** owner: photograph each finish on each wood.
- **Approach:** Circular swatch thumbnails from real close-up photos; switching finish swaps the gallery (already supported per finish tag). Add "colour on screen varies" note.
- **Priority:** P2. **Status:** Open. **Later:** sample chip kit.

### CON-10 Care, wood guide and FAQs not at the point of doubt
- **Evidence:** "Material & Care" tab only when `fabric` or `careInstructions` set (`fabric` is the fashion-era field name and is labelled "Material"); product `faqs` tab only when data exists; site FAQ page has good content (grain variation, care) but is not linked from the PDP; blog has care guides (`how-to-care-for-solid-wood-furniture`) unlinked from PDP.
- **Principle:** Answer objections in place; each click to another page loses the mobile visitor.
- **Impact:** M. **Effort:** S. **Dependency:** copy.
- **Approach:** Under the CTA, 5 collapsed one-liners (Is it solid wood? How long to make? What if it does not fit? How do I clean it? Can I change size/finish?) with the answers from real policy. Category-level default FAQs so every product has them. Link the care guide.
- **Priority:** P1. **Status:** Open. **Later:** wood comparison page (sheesham vs mango vs teak vs acacia) reusing homepage "Know your wood".

### CON-11 Thumbnails are not keyboard/assistive-tech reachable; duplicated description text
- **Evidence:** thumbnail `Box onClick` with no role/tabIndex and `alt=""` (`ProductDetailClient.tsx` ~L552-567); QA doc "Product descriptions concatenate the structured fields, so some text repeats" (production product shows "Made to order. Ships in approximately 6 days." inside the description as well as in the PDP line).
- **Principle:** Accessibility and perceived polish.
- **Impact:** L-M. **Effort:** S. **Dependency:** none.
- **Approach:** Buttons with aria-label "Show photo N"; stop concatenating structured fields into `description`.
- **Priority:** P2. **Status:** Open. **Later:** full WCAG 2.1 AA pass (see XCT-03).

### CON-12 Fashion-era copy leftovers
- **Evidence:** PDP section "Featured Picks - Handpicked by our stylists"; "Material & Care" tab reads `product.fabric`; footer "Trending", "Best Sellers", "Sale"; bottom nav links to `/account/wishlist`, `/account/profile` without country.
- **Principle:** Coherence; small mismatches reduce perceived expertise.
- **Impact:** L. **Effort:** S. **Dependency:** none.
- **Approach:** Rename ("Picked by our carpenters"), rename the field label, remove empty-signal footer links until they have content.
- **Priority:** P2. **Status:** Open. **Later:** copy audit against the brand voice guide.

### CON-13 Video and workshop proof absent from the PDP
- **Evidence:** No video component in `components/product/`; `WorkshopProcess.tsx` exists only on the homepage with stock photos.
- **Principle:** Costly signalling; a video of the actual piece being made is hard to fake.
- **Impact:** H. **Effort:** M. **Dependency:** owner video assets.
- **Approach:** Optional `videoUrl` per product (short vertical, autoplay muted on view, poster image); "Made in our Jodhpur workshop" strip with a real photo and the maker's name when known.
- **Priority:** P1 (after AWR-03). **Status:** Open. **Later:** live "video call showroom" (LOW-03).

---

## C. Customisation and quote flow

### CUS-01 Custom-order journey is undefined after the form submit
- **Evidence:** decision 0034: lead captured (`Lead`), admin email, WhatsApp; gaps listed: no lead-to-order link, no assignment UI, no reminder for uncontacted leads. No sketch/3D/quote document, no advance-payment step, no progress updates anywhere in storefront.
- **Principle:** Progress visibility and commitment; a buyer of a custom piece needs to see the steps (brief, sketch, quote, advance, build, deliver) and know what happens next.
- **Impact:** H. **Effort:** M (process + page) / L (portal). **Dependency:** owner: actual process, turnaround per step, advance %.
- **Approach:** Step 1: a "How custom orders work" strip on the PDP and thank-you screen with the real 5 steps and times. Step 2: quote sent as a WhatsApp/PDF with a payment link (Razorpay/Cashfree payment link for advance). Step 3: lead status visible to the customer (simple tracking page by reference id). Link lead to order in admin.
- **Priority:** P1. **Status:** Open. **Later:** customer portal with sketch approvals.

### CUS-02 Lead form success state and follow-up promise not verified end to end
- **Evidence:** `lead_response_promise` = "within 1 business day" (live), `lead_notification_email` empty (live), mail not configured (decision 0034: "untested end to end"), WhatsApp number placeholder.
- **Principle:** Response-time expectation; an unanswered lead after an explicit promise is worse than no promise.
- **Impact:** H. **Effort:** S. **Dependency:** owner: real number/email, someone assigned to reply, SMTP.
- **Approach:** Set real values, test a real lead on production (with owner present), add a daily "uncontacted leads over 2h" digest to the owner. Do not promise a window nobody staffs.
- **Priority:** P0. **Status:** Open. **Later:** auto-acknowledgement WhatsApp/email with the next steps.

### CUS-03 Customisation options are free text, not guided
- **Evidence:** Lead dialog captures room/style/needs (`QuoteLead.tsx`, decision 0034); `isCustomizable` + `customizationNotes` shown as one caption line; custom size builder exists only for admin (decision 0039).
- **Principle:** Reduce blank-page effort; choosing from options is easier than writing a brief.
- **Impact:** M. **Effort:** M. **Dependency:** owner: what is customisable per category (size, wood, finish, storage, headboard).
- **Approach:** "Customise" chips in the lead dialog per category (size in cm/ft, wood, finish, add drawers), upload a reference photo/sketch, and show indicative price bands ("custom sizes typically +10-20%") only if true.
- **Priority:** P2. **Status:** Open. **Later:** 3D/sketch preview (L).

### CUS-04 No price signal for custom work
- **Evidence:** Lead CTA "Get Best Quote & Price"; no "starting from" logic on custom-only items.
- **Principle:** Anchoring and qualification; total silence on price loses budget-sensitive visitors and wastes the carpenter team's time on mismatched budgets.
- **Impact:** M. **Effort:** S. **Dependency:** owner pricing bands.
- **Approach:** "Starting from Rs X for the standard size" plus the lead question "Approximate budget" (optional select).
- **Priority:** P2. **Status:** Open. **Later:** rules-based instant estimate.

---

## D. Contact and reassurance (low friction)

### LOW-01 WhatsApp/phone/Instagram are placeholders live; footer social links may go nowhere
- **Evidence:** live settings: `whatsapp_number` 919876543210, `site_phone` +91 98765 43210, `instagram_url`/`facebook_url`/`youtube_url` empty; `Footer.tsx` icons fall back to `href='#'` and show Twitter/YouTube/Pinterest icons regardless.
- **Principle:** Accessibility of a human; dead links on trust surfaces are a credibility hit.
- **Impact:** H. **Effort:** S. **Dependency:** owner numbers/URLs.
- **Approach:** Set real values in Admin > Settings; render only social icons with a real URL; show phone, hours (`contact_hours` exists) and email in the footer and on the cart/checkout.
- **Priority:** P0. **Status:** Open. **Later:** click-to-call in the mobile bottom nav.

### LOW-02 Support routed to Instagram only for returns/damage/cancellation
- **Evidence:** `return-policy`, `faq` ("Message us on Instagram at @thewoodvintage").
- **Principle:** Channel fit; a Rs 40k buyer expects phone/WhatsApp/email, and Instagram DMs are asynchronous and unauditable.
- **Impact:** M. **Effort:** S. **Dependency:** owner support channels.
- **Approach:** Replace with phone + WhatsApp + email and a service-request form; keep Instagram as an optional channel.
- **Priority:** P0 (part of CON-02). **Status:** Open. **Later:** ticket ID and status.

### LOW-03 No callback, video-call showroom, or scheduled consult
- **Evidence:** nothing in code; lead form only.
- **Principle:** Substituting for touch-and-feel; a live look at the piece is the best online proxy for a showroom.
- **Impact:** M-H for high-ticket. **Effort:** S (a WhatsApp video call link/Calendly) to M.
- **Dependency:** owner time.
- **Approach:** "Book a 15-minute video walk-through" option in the lead dialog choosing a time slot; owner does it by WhatsApp video; log outcome on the lead.
- **Priority:** P2. **Status:** Open. **Later:** scheduled slots and reminders.

### LOW-04 Floating WhatsApp disabled sitewide; no help on cart/checkout
- **Evidence:** `whatsapp_float_sitewide` = false (live); cart and checkout pages have no contact/help affordance.
- **Principle:** Help at the point of hesitation; cart and checkout are where doubts peak.
- **Impact:** M. **Effort:** S. **Dependency:** LOW-01.
- **Approach:** Small "Need help? Chat on WhatsApp" link under Proceed to Checkout and beside Place Order (not a floating overlay on checkout to protect the thumb zone).
- **Priority:** P1. **Status:** Open. **Later:** pre-filled cart summary message.

---

## E. Cart

### CRT-01 No free-shipping / lead-time / trust messaging in the cart
- **Evidence:** `cart/page.tsx`: subtotal, coupon, shipping, total, "Taxes calculated at checkout"; no progress to free shipping, no made-to-order lead time, no returns/repair summary, no help contact.
- **Principle:** Goal-gradient and reassurance at commitment.
- **Impact:** M. **Effort:** S. **Dependency:** CON-01/02 decisions.
- **Approach:** "Rs X more for free delivery" bar (true, from `free_shipping_threshold`), per-line "Ready in ~N days", 3 reassurance lines, contact link.
- **Priority:** P1. **Status:** Open. **Later:** "complete the set" upsell using existing combos.

### CRT-02 Cart order-of-operations hides real delivery date and cost until checkout
- **Evidence:** cart shows Standard Rs 79 or free; real per-product overrides applied at checkout only (decisions 0011, 0037 limits).
- **Principle:** No hidden costs.
- **Impact:** M-H. **Effort:** M. **Dependency:** CON-03.
- **Approach:** Pincode field in the cart driving both shipping and date range; same server quote used in cart and checkout.
- **Priority:** P1. **Status:** Open. **Later:** none.

### CRT-03 Wishlist requires login; no "save for later" for guests, no share-a-cart
- **Evidence:** `handleWishlist` toasts "Please login to add to wishlist" (`ProductDetailClient.tsx`).
- **Principle:** Friction at low-commitment intent; furniture purchases involve a partner/family decision.
- **Impact:** M. **Effort:** S-M. **Dependency:** none.
- **Approach:** Guest wishlist in localStorage merged on login; "Share this piece / my shortlist" via WhatsApp with a deep link (share button exists).
- **Priority:** P2. **Status:** Open. **Later:** shortlist page with notes ("for master bedroom").

---

## F. Checkout

### CHK-01 Login wall before the address form
- **Evidence:** `checkout/page.tsx` ~L118: `if (!isAuthenticated) dispatch(openLoginModal())`; orders require login (also coupons 0035).
- **Principle:** Friction and commitment; forced account creation is a top-cited abandonment reason.
- **Impact:** H. **Effort:** M. **Dependency:** backend guest-order path (order creation requires a user); phone-OTP or email magic link login exists (`PasswordlessAuth.tsx`).
- **Approach:** Keep login but make it a one-step phone/email verification embedded in the checkout, or support guest checkout with email + phone and create the account silently. Note OTP login "is broken in dev" (QA doc) and mail is not configured, so first confirm OTP delivery works in production **(unverified)**.
- **Priority:** P1. **Status:** Open. **Later:** guest order lookup by order no + phone.

### CHK-02 Address form is not mobile/India optimised
- **Evidence:** `checkout/page.tsx`: pincode validated as "required" only (account addresses page uses `^\d{6}$`); city/state typed manually; `country: 'India'` hard-coded default; phone only "required".
- **Principle:** Effort reduction; pincode-driven autofill removes 2-3 fields and an error class.
- **Impact:** M-H. **Effort:** S-M. **Dependency:** pincode lookup source (India Post API or static dataset).
- **Approach:** Pincode first -> auto city/state (editable), 6-digit numeric keyboard (`inputMode="numeric"`), phone validation by country (helper exists in `lib/phone.ts`), Google Places not needed. Country field follows geo-locked market.
- **Priority:** P1. **Status:** Open. **Later:** address autocomplete for US/UAE/UK.

### CHK-03 Payment step: two gateways side by side and the COD deposit model
- **Evidence:** checkout lists "Razorpay Secure" and "PhonePe Payment Gateway (Cashfree)" as separate radios, defaults to Cashfree; COD = pay delivery charge online (Rs 149) then cash on delivery (`SHIPPING_METHODS`, COD info banner), Cashfree `load({ mode: 'production' })` hard-coded; live keys not confirmed **(unverified whether production has real keys, TASKS lists them as the blocker)**.
- **Principle:** Choice overload and pay-in-two-steps confusion; UPI intent is the fastest path for Indian mobile buyers.
- **Impact:** H. **Effort:** M. **Dependency:** owner: which gateway, live keys, whether COD makes sense for Rs 20k+ items.
- **Approach:** One gateway button ("Pay securely - UPI, cards, netbanking, EMI"), UPI intent surfaced first on Android; drop COD for furniture or replace with "Pay 30-50% advance now, rest before dispatch" (fits made-to-order). Move the Cashfree mode to an env var.
- **Priority:** P0 (a working payment) / P1 (simplification). **Status:** Open. **Later:** Stripe/Razorpay international for US/UAE/UK (open question, TASKS).

### CHK-04 Advance-payment logic for made-to-order is missing
- **Evidence:** order model is pay-full-online or COD deposit; `manufacturingTimeDays` informative only.
- **Principle:** Commitment and fairness: the buyer pays part now, the maker is protected from cancellations of custom work; lowers the "all my money up-front" barrier.
- **Impact:** H. **Effort:** L. **Dependency:** backend (partial payments, balance payment link), policy.
- **Approach:** Per-product "advance %" and "balance due before dispatch" with a second payment link; order status "In production".
- **Priority:** P1-P2. **Status:** Open. **Later:** milestones payments.

### CHK-05 Payment failure recovery is basic
- **Evidence:** payment status modal has Verifying / Successful / Failed ("Try Again") / Pending; no "your order is saved, retry with another method", no WhatsApp help, stale PENDING online orders keep coupon redemption (decision 0035, no expiry job).
- **Principle:** Loss aversion in the moment of failure; keep momentum.
- **Impact:** M-H. **Effort:** M. **Dependency:** backend expiry job.
- **Approach:** Failed state offers "Try UPI / another card" retry on the same order without re-entering data, plus a "Pay by bank transfer / message us" fallback; auto-cancel PENDING online orders after N hours and release the coupon.
- **Priority:** P1. **Status:** Open. **Later:** abandoned-payment WhatsApp nudge (RET-01).

### CHK-06 Checkout reassurance is thin
- **Evidence:** summary card shows lines, totals and a static delivery estimate; no secure-payment badges beyond UPI/VISA/MC mini logos, no returns/repair line, no support contact, no GST invoice mention.
- **Principle:** Reassurance at the commitment point.
- **Impact:** M. **Effort:** S.
- **Approach:** Padlock line "Payments processed by Razorpay/Cashfree; we never see your card", 3 promise lines (CON-01), contact link, "GST invoice will be emailed" (needs POS-01).
- **Priority:** P1. **Status:** Open. **Later:** none.

### CHK-07 Shipping charge source-of-truth conflict
- **Evidence:** QA doc: FAQ/shipping policy 79/149/249 match code; admin settings `standard_shipping_rate` 199, `express_shipping_rate` 499 (live) unused by order service.
- **Principle:** Consistency (a price change nobody sees is a trust bug).
- **Impact:** M. **Effort:** S-M. **Approach:** one server-side quote used by cart, checkout, FAQ text. **Priority:** P1. **Status:** Open. **Later:** see engineering log OPN-03.

---

## G. Post-purchase

### POS-01 No order confirmation email/invoice
- **Evidence:** decision 0035 "No order confirmation email or invoice exists in this codebase yet"; SMTP placeholders (TASKS).
- **Principle:** Post-purchase reassurance; the first 5 minutes after paying determine buyer's remorse.
- **Impact:** H. **Effort:** M. **Dependency:** SMTP/Brevo keys, GST invoice format from owner/CA.
- **Approach:** Confirmation email + WhatsApp message with order summary, expected timeline, what happens next, contact. GST invoice PDF on dispatch.
- **Priority:** P0-P1. **Status:** Open. **Later:** shipping-dispatched email.

### POS-02 Order-success page promises the wrong timeline and links to a login-only tracker
- **Evidence:** `order-success/page.tsx`: "Shipped within 1-3 business days" (false for made-to-order), "Track your order in My Account" using a return icon, "Track Order" button `href="/account/orders"` (not country-prefixed); footer "Order Tracking" also `/account/orders`; the only public tracker is `/track/[waybill]`.
- **Principle:** Expectation accuracy; and keeping a first-time buyer oriented reduces "where is my order" contacts.
- **Impact:** H. **Effort:** S. **Dependency:** CON-02.
- **Approach:** Show real stage timeline (Confirmed -> In production (N days) -> Finishing -> Dispatch -> Delivered) with lead time from `manufacturingTimeDays`; "We will WhatsApp you photos"; a share-the-order link; `withCountry` fix.
- **Priority:** P0 (wrong claim), P1 (timeline). **Status:** Open. **Later:** order status page with guest lookup.

### POS-03 No production photos/updates or delivery scheduling
- **Evidence:** admin has status changes and waybill; no photo attach to orders, no delivery slot or assembly booking in storefront; FAQ mentions assembly only per product.
- **Principle:** Progress visibility, endowment (watching your piece being made increases attachment and lowers cancellations); reduces anxiety during a 3-5 week wait.
- **Impact:** H for retention/word-of-mouth. **Effort:** M. **Dependency:** admin upload UI on orders; owner discipline to take photos.
- **Approach:** "Production update" entries (photo + note) on the order, sent by WhatsApp/email; delivery date confirmation and "who will be home" step; assembly promise if true.
- **Priority:** P2. **Status:** Open. **Later:** customer-visible timeline in `/account/orders/[id]`.

### POS-04 No review/referral request after delivery
- **Evidence:** no review request flow, no referral code, no "share your photo" prompt in code; `Coupon` engine could support a referral code.
- **Principle:** Reciprocity at the moment of peak satisfaction; the first 100 orders are also the review and UGC seed.
- **Impact:** H for orders 20-100. **Effort:** M. **Dependency:** real orders, POS-01 channels.
- **Approach:** Day-10 message asking for a review + photo with a WhatsApp reply option; incentive for honest reviews only if disclosed; "Gift Rs X to a friend, get Rs X" via per-user coupon.
- **Priority:** P2. **Status:** Open. **Later:** UGC gallery.

### POS-05 Returns/damage flow exists in account but conflicts with policy wording
- **Evidence:** `app/(account)/account/returns/page.tsx` computes hours left in window; return policy says Instagram-only contact.
- **Impact:** M. **Effort:** S. **Approach:** align after CON-02; expose photo upload in the returns form. **Priority:** P1. **Status:** Open. **Later:** repair booking.

---

## H. Retention and recovery

### RET-01 No abandoned-cart, quote-follow-up or payment-abandon nudges
- **Evidence:** none in backend (`AnalyticsEvent` funnel only, decision 0025); leads have no reminder (decision 0034).
- **Principle:** Loss aversion / Zeigarnik effect; high-ticket buyers commonly return several times before buying, so a timely helpful nudge matters more than a discount.
- **Impact:** H. **Effort:** M. **Dependency:** WhatsApp Business API or approved templates, SMTP, consent.
- **Approach:** Manual first: daily admin list of leads/cart-adds >24h with one-click WhatsApp message using the lead's prefilled details. Automate later with consent-based templates. Do not add fake "someone else is looking at this".
- **Priority:** P1 (manual) / P3 (automated). **Status:** Open. **Later:** back-in-stock and price-drop alerts.

### RET-02 Newsletter form has no endpoint
- **Evidence:** decision 0030 "Newsletter form ... demo only (no subscribe endpoint exists)"; homepage `NEWSLETTER` band and footer form are inert.
- **Principle:** Any visible form that silently does nothing damages trust and wastes a capture opportunity.
- **Impact:** M. **Effort:** S. **Dependency:** provider decision (Brevo list) and consent copy.
- **Approach:** Either wire to Brevo/`Lead` (source NEWSLETTER) or remove the form until wired. Offer something concrete ("Our wood and care guide PDF").
- **Priority:** P0 (remove or wire; a dead form is deceptive). **Status:** Open. **Later:** segmented lists.

### RET-03 No back-in-stock / notify-me / price-drop
- **Evidence:** `/not-available` has no notify capture (decision 0036 follow-ups); product sold-out state disables options only.
- **Impact:** L now. **Effort:** M. **Priority:** P3. **Status:** Open. **Later:** for made-to-order most items are never "out of stock"; use "next slot" (CON-07) instead.

### RET-04 Abandoned PENDING online orders keep coupon redemption
- **Evidence:** decision 0035. **Impact:** L-M. **Effort:** S-M. **Approach:** expiry job (see CHK-05). **Priority:** P2. **Status:** Open. **Later:** none.

---

## I. Cross-cutting: mobile performance, accessibility, empty states

### XCT-01 Mobile thumb-zone and performance not measured on real devices
- **Evidence:** framer-motion is disabled below 900px (`MobileMotionConfig`); PDP first-load JS 267 kB and home 288 kB (decision 0033); production is a 2 vCPU/3.7 GB VPS with on-demand image encoding and no CDN (runbook, decision 0038); QA screenshots were headless, not real phones. The 390px screenshot of the PDP taken during this review showed the skeleton only after 9s **(single headless sample, cold cache, not a measurement)**.
- **Principle:** Speed and effort; Indian mobile traffic is often mid-range Android on 4G.
- **Impact:** H. **Effort:** M. **Dependency:** real-device test, CDN choice.
- **Approach:** Run Lighthouse mobile (throttled) on `/in`, PDP, cart; check LCP image is the hero (already `priority`), fix the worst offenders; put a CDN (Cloudflare) in front of `/img` (deferred since decision 0005) but note it changes the geo-lock header trust (runbook). Check CWV via existing reporter (`WebVitalsReporter`).
- **Priority:** P1. **Status:** Open. **Later:** performance budget in CI.

### XCT-02 Sticky quote bar + bottom nav + toasts: stacked fixed elements on small screens
- **Evidence:** decision 0034 (sticky bar sits above the 58px bottom nav); PDP bottom padding `pb: {xs: 18}`; bottom nav has `showLabels={false}` icon-only tabs.
- **Principle:** Thumb-zone hygiene; icon-only nav without labels hurts discoverability and accessibility.
- **Impact:** M. **Effort:** S. **Dependency:** real-device check.
- **Approach:** Add labels or `aria-label`s (verify existing), check small-height phones (SE), ensure the checkout hides the bottom nav.
- **Priority:** P2. **Status:** Open. **Later:** none.

### XCT-03 Accessibility not audited
- **Evidence:** QA doc lacks an accessibility pass; positives: reduced-motion policy (0033), focus-visible on gallery, alt text on images. Gaps: thumbnails (CON-11), colour contrast of `#A0693A` copper on cream for small text **(unverified, compute contrast)**, form labels on checkout (MUI floating labels OK), red `#c0392b` low-stock line.
- **Impact:** M. **Effort:** M. **Approach:** run the `design:accessibility-review` checklist on home/PDP/checkout; fix contrast, tap-target size (>=44px), focus order in dialogs. **Priority:** P2. **Status:** Open. **Later:** automated axe run in CI.

### XCT-04 Page-specific titles and empty states
- **Evidence:** QA doc "Cart, checkout and login pages use the default site title"; empty states exist for cart/wishlist/orders (0033) and admin.
- **Impact:** L. **Effort:** S. **Approach:** page titles for cart/checkout; empty search/category states that offer the quote CTA (AWR-08). **Priority:** P3. **Status:** Open. **Later:** none.

---

## J. Content gaps

### CNT-01 Buying guides and size guidance by category
- **Evidence:** `sizeChart` field exists on Product but no storefront size guide; decision 0039 removed "Size Guide"; blog has 3 seeded fictional posts (care, sheesham, Channapatna).
- **Principle:** Educate to build confidence and search visibility.
- **Impact:** M. **Effort:** M. **Dependency:** owner expertise.
- **Approach:** 5 evergreen guides written by the carpenter team: "Choosing a bed size (Indian mattress sizes)", "Sheesham vs mango vs teak vs acacia", "Dining table size for 4/6/8", "How to measure your room and doorways", "Solid wood vs engineered wood". Link from PDP FAQs and category pages.
- **Priority:** P2. **Status:** Open. **Later:** comparison table page.

### CNT-02 About/artisan pages use fictional people; credits page missing
- **Evidence:** decision 0029/0030 ("testimonials/artisans/blogs are fictional demo"; CC BY / CC BY-SA credits page not built; 9 Wikimedia photos need credits; possible stock/AI provenance of `Shixart1985` photos).
- **Principle:** Authenticity; legal compliance with licences.
- **Impact:** M-H. **Effort:** S-M. **Priority:** P0 (remove fictional artisans and unlicensed attributions before ads). **Status:** Open. **Later:** real artisan profiles with consent.

### CNT-03 Certifications and material claims unverified
- **Evidence:** "Managed orchards and seasoned, certified timber", "paid fairly and credited by name", "packed and insured" in `homepage.ts`.
- **Principle:** Only claim what you can document; consumer-protection and ASCI-style rules apply.
- **Impact:** M (risk). **Effort:** S. **Approach:** keep only true claims; add documentation if claiming certified timber (FSC/legal timber bills); state actual packaging method. **Priority:** P0. **Status:** Open. **Later:** sourcing page with invoices.

---

## K. Gifting, B2B, international

### GLB-01 Gifting
- **Evidence:** combos "Gifting Trio" exist (0037); no gift message, gift wrap, or delivery-to-another-address flow explained.
- **Impact:** L-M (Diwali/wedding). **Effort:** S-M. **Approach:** gift note field at checkout, "Ship to someone else" prompt, wedding-season landing page. **Priority:** P3. **Status:** Open. **Later:** gift cards.

### GLB-02 B2B / bulk / interior designers / hotels
- **Evidence:** lead form is consumer-oriented; no trade pricing or "for designers" page.
- **Impact:** M (high-value orders, low volume). **Effort:** S. **Approach:** one "Trade and bulk" page with a dedicated lead source and quantity field. **Priority:** P3. **Status:** Open. **Later:** trade accounts.

### GLB-03 Export markets: currency, tax, payments, language
- **Evidence:** online payment refused for non-INR (decision 0027); no per-country tax model (technical-debt); variant prices still base-currency (0032/0039); US preview market uses sample prices (0031); only English; production has India only; freight to US/UAE/UK undefined.
- **Impact:** L now. **Effort:** L. **Dependency:** payment vendor, tax rates, freight partner, owner decision (TASKS open questions 2-3).
- **Approach:** Do not open other markets until India converts; then start with UAE/US as quote-only (leads, no online payment), pricing in USD/AED via `ProductCountryPricing`, shipping quoted per order.
- **Priority:** P3. **Status:** Open. **Later:** see 0031, 0036.

### GLB-04 Geo lock may misroute real Indian buyers
- **Evidence:** decision 0036 honest limits: IP geolocation approximate, mobile carrier IPs, VPN; fail-open to default market; NRI buyers in the US cannot buy at India price and see the region page if no market. Crawlers exempt by UA.
- **Principle:** Do not turn away a paying visitor (NRIs are a natural early market for Indian handicraft).
- **Impact:** M. **Effort:** S. **Approach:** on the "not available" page capture a lead (already suggested, 0036 follow-up), and consider a contact-us quote path for NRIs rather than a dead end. **Priority:** P2. **Status:** Open. **Later:** notify-me.

---

## Top-15 quick wins (ordered by impact / effort for the first 100 orders)

| # | Gap | Impact | Effort | Why now |
|---|---|---|---|---|
| 1 | LOW-01 + CUS-02: set real WhatsApp, phone, email, Instagram, lead-notification email; test a real lead | H | S | Nothing else matters if the CTA goes to a stranger |
| 2 | AWR-01: hide fake testimonials and invented stats | H | S | Admin toggle, no deploy |
| 3 | AWR-02 + CNT-03: correct provenance/certification copy to the true Jodhpur story | H | S | Copy only |
| 4 | CON-02: rewrite returns/shipping/FAQ for made-to-order furniture (after owner decisions) | H | M | Removes the biggest contradiction |
| 5 | POS-02: fix "Shipped within 1-3 business days" and the tracker link on the success page | H | S | One file |
| 6 | RET-02: wire or remove the dead newsletter forms | M | S | Avoid a form that does nothing |
| 7 | AWR-09: launch only real, photographed products; deactivate placeholders | H | S | Toggle `isActive` |
| 8 | CON-01: replace PDP trust row with true returns/repair/advance/support lines | H | S | After decision in #4 |
| 9 | AWR-04: remove permanent strike-through/"Sale" where there was no real prior price | M | S | Honest anchoring |
| 10 | CHK-03: one payment button, UPI first; confirm live gateway keys work | H | M | Needed to take any money |
| 11 | CON-03 (MVP): pincode box giving delivery range and shipping cost | H | M | Removes top uncertainty |
| 12 | CON-10: 5 objection one-liners under the CTA (solid wood? lead time? fit? care? custom?) | M | S | Copy plus one component |
| 13 | LOW-04: WhatsApp help link in cart/checkout | M | S | Cheap rescue for hesitation |
| 14 | CRT-01: free-delivery progress and lead time in the cart | M | S | Truthful nudge |
| 15 | AWR-05: real-device check of the 390px header | H if real | S | Cheap verification |

## Needs owner input / assets

Photography and video
- Real photos per launch product (hero, in-room, 3 details, scale shot, finish swatches), workshop and team photos, one short workshop video and per-product clips.
- Real artisan names, portraits and permission to publish; founder story.

Facts and claims
- Where the wood is sourced, whether "certified/managed/seasoned" is documented, what packaging is used, whether insurance in transit exists.
- Real number of workshops/people/years; which cities (Jodhpur only?).

Policies and promises
- Made-to-order lead time per category; next production slot dates; monthly capacity.
- Advance % and balance timing; cancellation rules for custom pieces; damage-in-transit process and window; repair/warranty promise (years, what is covered); whether refunds (not only store credit) are given.
- Delivery method for large items, freight by zone/pincode, assembly service, delivery-attempt rules, whether GST is included and invoice details (GSTIN).
- Sample/swatch policy and price.

Channels and operations
- Real WhatsApp number, phone, support email, Instagram/Facebook URLs, business hours, who answers leads and in how long.
- SMTP/Brevo keys, Razorpay/Cashfree live keys and which gateway to keep, EMI availability on the merchant account.
- Real prices for the launch products and whether any true prior price exists for strike-through.
- Real reviews with written permission (collect from friends-and-family buyers only if they truly bought).

## Suggested measurement once traffic exists (no numbers assumed)

Use the existing funnel events (decision 0025/0026): `PRODUCT_VIEW -> QUOTE_CTA_CLICK -> LEAD_SUBMITTED / ADD_TO_CART -> CHECKOUT_STARTED -> ORDER_PLACED`, split by `utm_source` and device. Before/after each item above, record the stage rates so that impact ratings in this document can be replaced with measured values.
