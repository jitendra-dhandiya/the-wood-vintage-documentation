# 50 Diwali 2026 products — The Wood Vintage (India domestic)

Date: 2026-10-06. Diwali: **8 Nov 2026** (owner-stated; one low-quality blog found in research claimed
20 Oct 2026 — rejected as unreliable, not corroborated, and inconsistent with standard Panchang/Amavasya
sources). Navratri 11 Oct 2026 is the warm-up/content window only (too close to build net-new SKUs for — see
[../india-navratri-diwali-plan.md](../india-navratri-diwali-plan.md)). **~33 days of runway from today to Diwali.**

Built for workstream 1 of that plan. Sources read: local DB (backend was down at `:5000` on 2026-10-06, so
read `backend/prisma/seed-data/catalogue.ts` directly — 46 real seeded products, tagged `catalogue` below with
exact slug/SKU), [../../competitor-research/india-market-price-benchmark.md](../../competitor-research/india-market-price-benchmark.md)
(196-row table), [../../competitor-research/india-competitor-analysis.md](../../competitor-research/india-competitor-analysis.md),
[../positioning-and-usp.md](../positioning-and-usp.md), [../unit-economics-model.md](../unit-economics-model.md),
[../first-100/03-starter-catalogue.md](../first-100/03-starter-catalogue.md) (the India-first starter-catalogue plan,
S1-S16/Q1-Q4 — superseded for the US pivot but still the record of what was already *planned*, as opposed to
*seeded*), decisions 0028/0037/0039. Web research (4 searches, 2026-10-06, see citations inline) on genuine
Diwali demand signals — kept light per owner instruction ("be fast and decisive, do not over-research").

**Evidence tags:** VERIFIED (read live or in-repo 2026-10-06) · ESTIMATE (search snippet/blog, undated or
third-party, not independently verified) · ASSUMPTION (our judgement, owner to confirm). No sales data, review
counts or "bestseller" claims are invented anywhere below — "sellability signal" cites what the source actually
said, tagged.

## 0. Method and definitions (read before the table)

- **Source status:**
  - `catalogue` = one of the 46 products already seeded in `backend/prisma/seed-data/catalogue.ts` (exact
    slug/SKU given). Diwali relevance here is a *re-merchandising* case — same product, festive framing/combo,
    no new build.
  - `new SKU` = not in the 46-product seed; buildable now with capability already demonstrated elsewhere in the
    catalogue (same craft, different form — e.g. the Ganesha figure's lathe+lacquer process reused for a
    Lakshmi figure).
  - `stretch` = needs an explicit capability or capacity check before committing (multi-panel carved doors,
    branding/engraving for corporate bulk) — do not promise a ship date until checked.
- **Planning-doc flag** (separate from source status, per owner's request): some `new SKU` ideas below were
  already specified as S1-S16/Q1-Q4 in the superseded India starter-catalogue
  ([../first-100/03-starter-catalogue.md](../first-100/03-starter-catalogue.md)) — those get a note "(= S#
  in starter catalogue, spec reusable)". Everything else tagged `new SKU` is **genuinely new**, proposed here
  for the first time, specifically because Diwali research surfaced a demand signal the existing plans didn't
  cover (torans, wood-based diyas, pooja accessories, coasters, hampers, a Lakshmi companion figure).
- **Lead time class:** quick (≤7 working days) · standard (8-15 days) · intricate (16+ days, heavy carving/
  multi-step assembly). Catalogue items use the real `days` field from the seed data. New SKUs are estimated
  by analogy to the closest catalogue process (stated inline).
- **Price band:** INR, GST-inclusive, cited against the catalogue's actual seed price where `catalogue`, or
  against the India price benchmark / unit-economics launch-band tables where `new SKU`/`stretch`.
- **Diversity rule applied:** no sub-category has more than 6 items; price bands span ₹299 (coaster+keychain
  combo) to ₹16,900 (Kerala teak storage trunk) and ₹14,999-16,999+ (mandir).

## 1. Executive summary — top 10 hero SKUs

| # | Product | Price INR | Why it's a hero |
|---|---|---|---|
| 1 | Carved Solid Sheesham Mandir / Temple Unit (2.5 ft) | 14,999-16,999 | The single biggest white-space gap: positioning doc names "carved mandir" as *priority #1* white space (Woodsala ₹21,899 vs mass-market engineered ₹494 — real premium-solid-wood gap); already fully costed as S1 in the starter-catalogue plan (floor ₹14,050, 15% margin) — **but it does not exist in the 46-seed catalogue yet. `stretch`: urgent decision needed, see §4.** |
| 2 | Hand-Carved Jharokha Mirror (catalogue: `hand-carved-jharokha-mirror`, WV-WAL-001) | 11,900 | Already flagged Best Seller + Trending in the seed; festival housewarming/entryway gift; no new build needed |
| 3 | Jaali Carved Wall Panel (catalogue: `jaali-carved-wall-panel`, WV-WAL-002) | 10,400 | Healthiest margin in the whole model (24.5% after CAC, unit-economics table); Instagram-photogenic; works as a door/room-divider décor too |
| 4 | Lakshmi-Ganesha Figure Pair (Ganesha = catalogue `lacquered-ganesha-figure` WV-FIG-004 ₹4,790; Lakshmi = new companion SKU, same lathe+lacquer process) | ~9,000-9,900 for the pair | "Laxmi-Ganesh idols" named explicitly as a top Diwali gift in research (TheWeek, 13 Oct 2025); we have Ganesha but not Lakshmi — a one-SKU gap closes a pair that's searched as a unit |
| 5 | Hoshiarpur Inlay Serving Tray (catalogue: `hoshiarpur-inlay-serving-tray`, WV-SRV-003) | 5,290 | Premium personal/corporate gifting tray, brass inlay differentiates vs mass acacia trays everywhere |
| 6 | Hand-Carved Sheesham Door Toran with Brass Bells (new SKU) | 1,499-1,999 | Torans are literally "at the forefront of Diwali purchases" (Shiprocket, "best selling products on Diwali", 2026 blog) — every competitor sells fabric/marigold torans; a hand-carved wood one with real bells is genuinely differentiated and currently a **zero-SKU gap** |
| 7 | Diwali Hamper — Premium (Inlay Tray + Lakshmi-Ganesha Pair + Dry-Fruit Box) | 7,999-9,999 | Corporate gifting research (EnKash/Vantage Circle, 2025-26) names personalisation + craft + "a sense of occasion" as what's replacing plain dry-fruit boxes — a combo (decision 0037 combo engine) is the right wrapper, not a single SKU |
| 8 | Carved Wooden Elephant Pair (catalogue: `carved-wooden-elephant-pair`, WV-FIG-002) | 5,590 | Already Best Seller + Trending flagged; "good luck" gifting language already matches Diwali framing with zero new work |
| 9 | Jaali Tealight Lantern, hanging sheesham (new SKU) | 899-1,299 | Research: "diyas are the heart of Diwali... trend is about craft and customisation" (radhakrishnatemple.net, 2025) — a pierced-wood hanging tealight holder is the wood-housing answer to that trend without becoming a generic clay-diya SKU |
| 10 | Hoshiarpur Inlay Chess Set (catalogue: `hoshiarpur-inlay-chess-set`, WV-TOY-003) | 7,290 | Family-gathering gift for the Diwali long weekend; premium personal/corporate gift; zero new work |

**Catalogue vs new vs stretch across all 50:** 27 `catalogue` (re-merchandised, zero build work) · 21 `new SKU`
(buildable now, same craft repertoire) · 2 `stretch` (mandir unit — carved multi-panel doors not yet
demonstrated at this scale in the seed catalogue; corporate bulk branded gifting — needs an engraving/branding
capability check). See §4 for the one urgent go/no-go.

## 2. The 50, grouped by category

Columns: Name · Diwali relevance · Uniqueness angle · Price band (INR) · Source status · Lead time · Sellability signal + source.

### 2.1 Mandir & Pooja Accessories (6)

1. **Carved Solid Sheesham Mandir / Temple Unit (2.5 ft)** — `stretch` (= S1 in starter catalogue, spec
   reusable) — intricate (~20-25 days by analogy to the 9-day 75×120cm jaali panel scaled to a full carved,
   doored unit; **not yet attempted at this scale** — verify with the workshop before promising a date) —
   ₹14,999-16,999. *Relevance:* the pooja-room centrepiece bought for Diwali/housewarming. *Uniqueness:* solid
   carved wood vs the mass engineered/laminate mandirs that dominate Flipkart (median ₹494, ESTIMATE,
   india-market-price-benchmark.md §3.2) — genuine premium-solid-wood white space per positioning-and-usp.md §9.1
   priority 1. *Signal:* Woodsala sells carved mandirs at ₹21,899 median (VERIFIED, benchmark §3.1) — real paying
   demand at this tier exists; we have zero live SKUs in this category.
2. **Sheesham Bajot / Chowki (Pooja-Idol Platform Stool)** — `new SKU`, genuinely new — standard (~10 days,
   turning + carving, analogous to the bedside table at 14 days scaled down) — ₹1,999-2,999. *Relevance:*
   the low wooden platform every pooja corner needs for the idol/thali during Lakshmi puja. *Uniqueness:*
   distinct from the existing Rattan-Seat Mudha (a seat) — this is explicitly pooja furniture, a category none
   of our 46 seed products cover. *Signal:* ASSUMPTION — no direct citation found, but pooja-room furniture is
   a named segment in positioning-and-usp.md §9.2 ("housewarming/puja-corner buyers").
3. **Panch-Diya Wooden Aarti Stand (5-cup brass + turned sheesham)** — `new SKU`, genuinely new — standard
   (~10 days, turning + brass fitting, analogous to the Kerala Teak Floor Lamp's brass-cap process at 12 days)
   — ₹1,499-1,999. *Relevance:* the aarti/diya stand used every evening through the 5 days of Diwali.
   *Uniqueness:* wood-housed, reusable brass-cup design vs disposable clay diyas. *Signal:* ESTIMATE — "diyas
   are the heart of Diwali... trend is about craft and customisation" (radhakrishnatemple.net, "Diwali 2025
   decoration ideas", accessed 2026-10-06).
4. **Wall-Mount Wooden Pooja Shelf / Mini Mandir Corner** — `new SKU`, genuinely new — standard (~10 days,
   analogous to the Teak Corner Étagère's 12-day stepped-shelf build) — ₹2,499-3,499. *Relevance:* small-flat
   solution — apartment buyers who can't fit a full mandir unit still buy a pooja corner for Diwali.
   *Uniqueness:* no compact wall-mount pooja option exists in the seed catalogue (the only mandir-adjacent gap
   besides item 1); fills the "first-time flat owner" segment named in positioning-and-usp.md §9.2.
   *Signal:* ASSUMPTION, logical complement to item 1 for smaller homes — flag for owner validation, not
   independently verified by search.
5. **Kutch Lacquer Kumkum-Haldi Box (Set)** — `new SKU`, genuinely new — standard (~10-12 days, same
   bow-lathe lacquer process as the catalogue's `kutch-lacquer-spice-box`, WV-SPC-002, at 12 days) —
   ₹899-1,299. *Relevance:* kumkum/haldi/akshat are used in every Lakshmi puja and gifted alongside sweets.
   *Uniqueness:* reuses Ravji's Kutch lacquer craft (already a catalogue material story) in a new,
   Diwali-specific form factor. *Signal:* ASSUMPTION — a logical line extension of an existing craft, not
   independently search-verified.
6. **Sheesham Mini Temple Bell (Ghanti) Stand** — `new SKU`, genuinely new — quick (~5-6 days simple turnery,
   analogous to the mango wood plant stand at 7 days) — ₹399-599. *Relevance:* a small bell is rung at aarti;
   a wood stand version is a true budget gifting entry point. *Uniqueness:* almost nobody sells a *wood-stand*
   bell — most are plain brass on no stand. *Signal:* ASSUMPTION, budget-tier filler, not independently verified.

### 2.2 Diyas & Candle Holders — wood-based (4)

7. **Jaali Tealight Lantern, hanging sheesham** — `new SKU`, genuinely new — standard (~9 days, same piercing
   process as `jaali-carved-wall-panel`'s 9-day 75×120cm panel, scaled down) — ₹899-1,299. *Relevance:*
   direct answer to the "craft and customisation" diya trend without being a disposable clay diya.
   *Uniqueness:* wood housing + pierced shadow pattern is not sold at this craft level by Pepperfry's listed
   "wooden Om shadow decorative tea light candle holder diya stand" (ESTIMATE, Pepperfry festive-decor
   category page, accessed 2026-10-06) — ours is hand-pierced jaali, theirs reads as a simpler turned shape.
8. **Turned Wood Pillar Candle Stand (Set of 2, brass accent)** — `new SKU`, genuinely new — quick (~5-7 days,
   same turning process as the mango wood serving bowls at 6 days) — ₹999-1,499. *Relevance:* festive table/
   mantel styling through the Diwali week. *Uniqueness:* turned-wood + brass inlay accent vs the glass/metal
   pillar holders that dominate Amazon/Pepperfry listings. *Signal:* ASSUMPTION.
9. **Mango Wood Diya Tray with 9 Brass Diya Cups** — `new SKU`, genuinely new — standard (~10 days, tray
   turning + brass cup fitting) — ₹1,799-2,499. *Relevance:* a reusable, higher-ticket alternative to buying
   9 disposable clay diyas every year — explicit sustainability angle research flagged for 2025 ("handmade
   products and eco-friendly Diwali essentials... trend is about craft and customization", ESTIMATE,
   radhakrishnatemple.net). *Uniqueness:* the tray-plus-cups format (reusable, gift-boxable) vs loose clay
   diyas sold by the dozen everywhere.
10. **Carved Wooden Diya Stand Tower (3-tier, mandala motif)** — `new SKU`, genuinely new — standard
    (~12-14 days, carving-heavy, analogous to the Sun Mandala Wall Art's carving work at 10 days) —
    ₹2,299-2,999. *Relevance:* a statement centrepiece for balcony/entrance diya displays. *Uniqueness:*
    tiered wood sculpture vs the single-level diya trays sold as mass décor. *Signal:* ASSUMPTION.

### 2.3 Torans & Door Décor (4)

11. **Hand-Carved Sheesham Door Toran with Brass Bells** — `new SKU`, genuinely new — standard (~10 days,
    carving + bell assembly) — ₹1,499-1,999. *Relevance:* "Torans are at the forefront of Diwali purchases...
    it's a ritual to replace them every Diwali" (Shiprocket, "best selling products on Diwali", accessed
    2026-10-06) — this is the single most-cited Diwali purchase category in our research and we currently
    have **zero** SKUs for it. *Uniqueness:* carved wood + real bells vs the ubiquitous fabric/marigold/plastic
    torans every retailer and street stall sells — see hero #6.
12. **Jaali Wood Door Toran Panel (horizontal strip + tassels)** — `new SKU`, genuinely new — standard
    (~9 days, same jaali piercing process) — ₹1,299-1,799. *Relevance:* same occasion as #11, lighter/flatter
    alternative for narrower doorframes. *Uniqueness:* pierced-wood strip is a distinct silhouette from #11's
    carved-bell toran — gives two price/style points in the category without duplicating the exact product.
13. **Mango Wood "Shubh Labh" Hanging Plaque** — `new SKU`, genuinely new — quick (~6-7 days, simple relief
    carving + hand-painted lettering, analogous to the Sawantwadi wall plates' 10-day hand-painting but
    simpler/smaller) — ₹599-899. *Relevance:* "Shubh Labh" (auspiciousness and profit) is the standard
    Diwali door/shop greeting; a budget-tier door décor entry point. *Uniqueness:* hand-carved wood vs the
    printed/acrylic versions that dominate online listings.
14. **Carved Wood Ganesha Door Hanging** — `new SKU`, genuinely new — quick-standard (~7-9 days) —
    ₹799-1,199. *Relevance:* Ganesha at the threshold is a standard Diwali welcome motif, distinct occasion
    from the door toran (this hangs flat against the door, not across the top). *Uniqueness:* carved relief
    vs the painted terracotta/resin versions that are everywhere.

### 2.4 Wall Art, Mirrors & Frames (6)

15. **Hand-Carved Jharokha Mirror** — `catalogue` (`hand-carved-jharokha-mirror`, WV-WAL-001) — standard
    (14 days, seed data) — ₹11,900. Re-merchandised: Rajasthani jharokha framing reads directly as festive
    entryway décor; no build work. Already flagged Best Seller/Trending/Featured in the seed.
16. **Jaali Carved Wall Panel** — `catalogue` (`jaali-carved-wall-panel`, WV-WAL-002) — standard (14 days) —
    ₹10,400. Highest-margin item in the whole unit-economics model (24.5% after CAC) — push this hard in the
    Diwali push for margin, not just story.
17. **Hand-Carved Krishna Panel** — `catalogue` (`hand-carved-krishna-panel`, WV-WAL-005) — intricate
    (16 days) — ₹10,490. Direct puja-room/reading-nook relevance; already `featured` + `isNew` flagged.
18. **Carved Sun Mandala Wall Art** — `catalogue` (`carved-sun-mandala-wall-art`, WV-WAL-004) — standard
    (10 days) — ₹6,290 (sizes ₹4,690-10,290 Ø45-90cm). Photogenic statement piece, flexible price points via
    the existing size variants.
19. **Sawantwadi Hand-Painted Wall Plates (Set of 3)** — `catalogue` (`sawantwadi-hand-painted-wall-plates-set-of-3`,
    WV-WAL-003) — standard (10 days) — ₹5,490. Bright festive palette (madder red, indigo, ochre) reads as
    Diwali colour directly; zero rework needed.
20. **Sheesham Jaali Photo Frame (Set of 2)** — `new SKU`, genuinely new — quick (~6-7 days, small-scale
    piercing) — ₹699-1,299. *Relevance:* family-photo gifting is a Diwali/housewarming staple; nothing in the
    46-seed catalogue covers photo frames at all — a genuine zero-SKU gap. *Uniqueness:* pierced jaali border
    vs plain wood/plastic frames sold everywhere. *Signal:* ASSUMPTION, no direct citation, but "personalised
    home décor" is named as a 2026 Diwali gifting theme (azafashions.com, "Diwali 2026 gift ideas", accessed
    2026-10-06, ESTIMATE).

### 2.5 Figurines & Idols — gifting (5)

21. **Lacquered Ganesha Figure** — `catalogue` (`lacquered-ganesha-figure`, WV-FIG-004) — standard (10 days) —
    ₹4,790. Already positioned as a "housewarming gift with heart" in the seed copy — directly reusable for
    Diwali gifting with zero changes.
22. **Lacquered Lakshmi Figure** (companion to #21) — `new SKU`, genuinely new — standard (~10 days, identical
    bow-lathe + friction-lacquer process to the Ganesha) — ₹4,790-5,200 solo, or ~₹9,000-9,900 as a pair with
    #21 (hero #4). *Relevance:* "Laxmi-Ganesh idols thought to bring abundance and remove hurdles" are named
    directly as a top Diwali gift (The Week, "The Ultimate List of Best Diwali Gifts for 2025", 13 Oct 2025,
    ESTIMATE) — we sell half of the pair today. *Uniqueness:* completing a named, searched pairing is lower
    risk than inventing a new motif.
23. **Carved Wooden Elephant Pair** — `catalogue` (`carved-wooden-elephant-pair`, WV-FIG-002) — standard
    (10 days) — ₹5,590. Already Best Seller + Trending flagged; "good luck" framing in the seed copy maps
    directly onto Diwali prosperity gifting.
24. **Kondapalli Dashavatara Set** — `catalogue` (`kondapalli-dashavatara-set`, WV-FIG-001) — standard
    (15 days) — ₹7,190. GI-craft badge already present; religious-gift framing needs no rework.
25. **Sheesham Horse Sculpture** — `catalogue` (`sheesham-horse-sculpture`, WV-FIG-003) — standard
    (12 days) — ₹7,900. Re-merchandise as a "prosperity/new-beginnings" desk gift for Diwali corporate
    recipients — currently positioned as generic desk décor in the seed; Diwali framing is new copy only.

### 2.6 Serving Ware, Trays & Coasters (6)

26. **Hoshiarpur Inlay Serving Tray** — `catalogue` (`hoshiarpur-inlay-serving-tray`, WV-SRV-003) — standard
    (12 days) — ₹5,290. Premium personal/corporate gifting tray; brass-inlay border already differentiates vs
    plain acacia trays.
27. **Acacia Serving Tray with Handles** — `catalogue` (`acacia-serving-tray-with-handles`, WV-SRV-001) —
    quick (5 days) — ₹2,590. Festive tea/mithai service tray; Best Seller + Trending flagged already.
28. **Mango Wood Serving Bowls (Set of 3)** — `catalogue` (`mango-wood-serving-bowls-set-of-3`, WV-SRV-002) —
    quick (6 days) — ₹2,990. Namkeen/mithai nesting bowls for guest entertaining through the festival.
29. **Sheesham & Brass Inlay Coaster Set (Set of 6)** — `new SKU`, genuinely new — quick (~5-6 days, same
    inlay process as the Hoshiarpur tray, scaled down to coaster size) — ₹499-799. *Relevance:* a true
    budget-gifting entry point (task brief explicitly calls for a ₹299-ish low band) and a natural combo
    component. *Uniqueness:* brass inlay vs the plain-wood or cork coasters that dominate this price tier.
    *Caution:* unit-economics modelling flags small kitchen-wood items (tray/board/dabba) as thin-to-negative
    margin standalone (2.1-9.1% before CAC-heavy items, unit-economics-model.md §4 table B/C) — **sell this in
    combos (§2.10), not as a cold-traffic standalone SKU.**
30. **Mini Wooden Coaster + Keychain Ganesha Combo** — `new SKU`, genuinely new (combo of two small turned
    pieces) — quick (~5 days) — ₹299-349. *Relevance:* the explicit ₹299 budget-gifting floor the brief asks
    for — bulk corporate "thank you" giveaway tier. *Uniqueness:* none on its own (it's a small turned good) —
    the value is hitting a genuine sub-₹350 price point without going into mass-market clay/plastic. *Caution:*
    same thin-margin warning as #29 — viable mainly at bulk-order volume or bundled, not as a single-unit
    paid-ad product.
31. **Acacia Round Chopping Board** — `catalogue` (`acacia-round-chopping-board`, WV-CUT-001) — quick
    (5 days) — ₹1,790 (sizes ₹1,390-2,390). Re-merchandise as a festive kitchen/housewarming gift; zero
    build changes.

### 2.7 Sweet / Dry-Fruit Boxes & Spice Boxes (4)

32. **Kutch Lacquer Spice Box** — `catalogue` (`kutch-lacquer-spice-box`, WV-SPC-002) — standard (12 days) —
    ₹3,590. Bright festive lacquer colours (vermilion/saffron/indigo) read directly as Diwali-appropriate;
    zero rework.
33. **Sheesham Masala Dabba** — `catalogue` (`sheesham-masala-dabba`, WV-SPC-001) — quick (6 days) — ₹2,690.
    Already Best Seller flagged; kitchen-gifting staple.
34. **Sheesham & Brass Inlay Dry-Fruit / Mithai Box (compartmentalised)** — `new SKU`, genuinely new —
    standard (~10-12 days, inlay work analogous to the Hoshiarpur tray) — ₹1,999-2,999. *Relevance:*
    corporate gifting research explicitly flags a move *away* from plain dry-fruit boxes toward more
    premium/personalised versions ("the trend is moving away from the mundane dry-fruit boxes", enkash.com,
    "corporate Diwali gifting trends", accessed 2026-10-06, ESTIMATE) — a brass-inlay wood box with
    compartments is the premium answer, not a generic cardboard hamper box. *Uniqueness:* reusable wood vs
    one-use cardboard/foil boxes everyone else ships.
35. **Handcrafted Wooden Kitchen Utensil Set (7 pieces)** — `catalogue` (`handcrafted-wooden-kitchen-utensil-set`,
    WV-SRV-004) — quick (6 days) — ₹2,290. Re-merchandise as a festive housewarming/kitchen-refresh gift.

### 2.8 Small Furniture Accents — "festive refresh" (5)

36. **Teak Round Coffee Table** — `catalogue` (`teak-round-coffee-table`, WV-TBL-003) — standard (12 days) —
    ₹15,900. Statement/furniture price band for the "home refresh before Diwali guests arrive" purchase
    occasion; already `isNew`/`trending` flagged.
37. **Kerala Teak Storage Trunk** — `catalogue` (`kerala-teak-storage-trunk`, WV-CAB-005) — standard
    (14 days) — ₹16,900. Doubles as a coffee table and a gifting-box aesthetic (pettagam trunks are
    traditionally used for valuables/jewellery, a natural Diwali-gold association); highest price point in
    the 50.
38. **Mango Wood Bar Stool** — `catalogue` (`mango-wood-bar-stool`, WV-CHR-003) — quick (7 days) — ₹5,400.
    Mid-tier accent furniture for festive entertaining spaces.
39. **Rattan-Seat Mudha Stool** — `catalogue` (`rattan-seat-mudha-stool`, WV-CHR-005) — quick (7 days) —
    ₹2,990. Affordable accent seating/footrest, good combo-filler weight (3 kg) for bundling with décor.
40. **Mango Wood Plant Stand** — `catalogue` (`mango-wood-plant-stand`, WV-PLT-002) — quick (7 days) —
    ₹2,990. Re-merchandise for marigold/tulsi pots at the festive entryway.

### 2.9 Kids & Toy Gifting (3)

41. **Channapatna Toy Set (Classic 8-Piece)** — `catalogue` (`channapatna-toy-set-classic-8-piece`, WV-TOY-001)
    — standard (8 days) — ₹2,990. GI-craft + child-safe badges already present; classic Diwali gift for
    young relatives, zero rework.
42. **Channapatna Stacking Rings** — `catalogue` (`channapatna-stacking-rings`, WV-TOY-002) — quick (6 days)
    — ₹1,090. Budget-tier baby/toddler gift, child-safe lacquer already verified in the seed description.
43. **Hoshiarpur Inlay Chess Set** — `catalogue` (`hoshiarpur-inlay-chess-set`, WV-TOY-003) — standard
    (15 days) — ₹7,290. Family-gathering gift for the Diwali long weekend; premium personal/corporate tier.

### 2.10 Lighting (3)

44. **Kerala Teak Floor Lamp** — `catalogue` (`kerala-teak-floor-lamp`, WV-LMP-001) — standard (12 days) —
    ₹9,790. "Warm light for reading corners" copy extends naturally to festive evening ambience.
45. **Jaali Carved Table Lamp** — `catalogue` (`jaali-carved-table-lamp`, WV-LMP-002) — standard (10 days) —
    ₹4,690. Pierced-shadow ambient lighting doubles as pooja-room/living-room festive lighting; already
    `isNew`/`trending` flagged.
46. **Woven Cane Pendant Light** — `catalogue` (`woven-cane-pendant-light`, WV-LMP-003) — quick (7 days) —
    ₹3,690. Dining-table festive ambience for Diwali entertaining.

### 2.11 Corporate & Personal Gift Hampers — combos (4)

Built on the live combo engine (decision 0037) — bundling existing/new line items rather than inventing
single new SKUs for the hamper tier itself.

47. **Diwali Hamper — Starter** (Coaster Set #29 + Mini Keychain Ganesha from #30) — `new SKU`, genuinely new
    combo — quick (components quick) — ₹799-999. *Relevance:* bulk corporate "thank you" / vendor gifting at
    volume. *Uniqueness:* wood+brass vs the plastic giveaway tchotchkes typical at this price. *Margin note:*
    combo wrapper is exactly how the unit-economics model says thin-margin small items become viable — do not
    sell these two components as standalone cold-traffic SKUs (see #29/#30 cautions).
48. **Diwali Hamper — Classic** (Sheesham Masala Dabba #33 + Acacia Serving Tray #27 + Panch-Diya Aarti
    Stand #3) — `new SKU`, genuinely new combo — standard — ₹2,999-3,999. *Relevance:* the personal-gifting
    mid-tier — kitchen + pooja, the two most Diwali-relevant rooms.
49. **Diwali Hamper — Premium** (Hoshiarpur Inlay Tray #26 + Lakshmi-Ganesha Pair #21+#22 + Inlay Dry-Fruit
    Box #34) — `new SKU`, genuinely new combo — standard — ₹7,999-9,999. *Relevance:* hero #7 — the premium
    personal/corporate tier research flags as the growing segment ("premium, memorable solutions... average
    spend is steadily rising", vantagecircle.com, "corporate Diwali gifts for employees 2025", ESTIMATE).
50. **Corporate Bulk Gifting Set — Branded** (Hoshiarpur Inlay Chess Set #43 + Hoshiarpur Inlay Tray #26 +
    engraved branding card/plate) — `stretch` — needs an explicit check of engraving/laser-branding capacity
    and MOQ/lead time at 25+ unit bulk orders before quoting any client — ₹6,999-8,999/unit at bulk pricing.
    *Relevance:* B2B/corporate bulk is an explicit occasion in the brief; personalisation with the recipient's
    name/company branding is repeatedly named as the differentiator corporates want in 2025-26 gifting
    research (bombaysweetshop.com, "2026 guide to corporate Diwali gifting", enkash.com — both ESTIMATE).
    *Caution:* do not commit a bulk corporate quote until the branding capability and timeline are confirmed —
    this is the second item needing an owner/ops decision (lower urgency than the mandir, see §4).

## 3. Skip / avoid section — what NOT to make, and why

| Item | Why avoid |
|---|---|
| **Generic clay/terracotta diyas** | Not a wood product at all (explicitly out of scope per the brief's craft constraints); it's the single most saturated SKU in the entire festival (every retailer, every street stall) — zero differentiation, zero margin headroom. We cover the *occasion* instead via wood-housed tealight/candle holders (§2.2) that keep the craft in scope. |
| **Rangoli stencils/kits** | Brief explicitly flags these as oversaturated unless "genuinely elevated" — wood is not a strong material edge for rangoli (acrylic/plastic stencils dominate for a reason: flexibility and washability); no elevated wood version earns its place here. Skipped entirely rather than forced. |
| **Electric diyas / LED string lights / any electrical décor** | Brief explicitly excludes electric unless it's a wood housing for a simple non-electrical candle/tealight — true electric lighting brings safety certification (BIS) and liability exposure the Jodhpur carving team has no reason to take on for a 33-day window. |
| **Glass/ceramic puja thalis, idols, or lamps** | Out of material scope per the brief; also a crowded, low-differentiation category (Pepperfry/Amazon are full of them) where our carving-team edge doesn't apply. |
| **Queen/king beds, wardrobes/almirahs, upholstered sofas, large jhula/swings** | Positioning-and-usp.md §9.4 already flags these as "avoid as first products" for weight/freight/margin reasons (95+ kg wardrobes, negative-to-thin contribution margin on beds/TV units/bedside tables per unit-economics-model.md §4) — doubly true in a 33-day festival sprint where production + shipping buffer is the binding constraint, not demand. A large jhula/swing specifically is also 40-60 kg and would not reliably arrive before 8 Nov even if ordered this week. |
| **Large wall mirrors (>36") as a Diwali-rush SKU** | Breakage risk in peak-season courier volume is real (packaging investment cited at ~7.6% of furniture pieces arriving scuffed, ESTIMATE, export-b2c-logistics doc referenced in unit-economics-model.md) — keep mirror offerings at the existing Jharokha size (#15), don't add a larger one for this window. |
| **New wooden toy forms beyond the existing Channapatna line (until safety-labelling is checked)** | Positioning-and-usp.md §9.4 flags "wooden toys (until safety standards are checked)" as a compliance gap (BIS/CPSIA not researched) for *new* toy SKUs — the three toy items we do list (§2.9) are the *existing*, already-GI-certified, already-described-as-child-safe Channapatna/Hoshiarpur lines, not new toy designs. Do not add a new toy shape for Diwali without that compliance check first. |
| **Sub-₹1,000 standalone "gateway" décor sold on cold paid ads** | Unit-economics-model.md §4 shows trays/boards/dabbas at 2-9% contribution before CAC even *before* paid acquisition cost is subtracted (and negative after, at a typical blended CAC) — items #29/#30/#33 above are listed because they're genuinely Diwali-relevant and needed for price-band diversity and combos, but they should be sold through hampers/combos or organic/WhatsApp channels, never as the hero creative in a paid Diwali ad. |
| **Large-format, fully bespoke "customer's exact room" furniture orders placed after ~20 Oct** | Not a product-line issue but a timing one: any `standard`/`intricate` lead-time item (8-25 days) ordered by a customer in early November has no shipping buffer left before 8 Nov. Flag this on the site copy for the whole catalogue during the Diwali window, not just this list. |

## 4. Decisions the owner needs now (urgency-ordered)

1. **URGENT — start or skip the carved mandir unit (item #1) this week.** It is the single highest-impact
   white-space hero (see §1) but also `intricate` lead time (estimated 20-25 days for a multi-panel carved,
   doored unit the team has not built at this scale before, by analogy to the 9-day *flat* 75×120cm jaali
   panel). At 33 days to Diwali, that leaves almost no shipping/QA buffer if the first attempt needs rework.
   **Decide by ~9-10 Oct 2026**: either commit the carving team to start now (accept schedule risk), cap the
   first batch at 2-3 units with a hard cutoff for new orders by ~20 Oct, or demote it to "launch in the
   starter catalogue post-Diwali" and lead the Diwali push with hero #2 (Jharokha Mirror, already in stock
   process) instead.
2. **Lower urgency — confirm engraving/branding capability for the Corporate Bulk Gifting Set (#50)** before
   quoting any B2B client; if there's no in-house or partner engraving capacity, drop the branding promise and
   sell #49 (Premium hamper, unbranded) as the corporate SKU instead.
3. **Not urgent but needed before go-live:** confirm GST rate per new décor SKU with the CA (12% vs 5% HSN
   question already open in the price-benchmark doc, §9) and the usual "no fake MRP / no invented reviews"
   rules apply unchanged to all Diwali marketing copy (positioning-and-usp.md §6).

## 5. Data gaps / confidence notes

- No access to Amazon.in, Pepperfry or Flipkart live Diwali category pages this session (search snippets only,
  tagged ESTIMATE throughout) — a follow-up session with working WebFetch access to those specific category
  pages would sharpen the "uniqueness vs what's already everywhere" claims with live screenshots.
- No sales/order data exists for The Wood Vintage yet (pre-launch) — every "sellability signal" above cites
  third-party research about the *category*, never an invented claim about our own past sales.
- Lead-time estimates for all `new SKU`/`stretch` items are ASSUMPTION by analogy to the closest seed-catalogue
  process; none have been test-built. Confirm with the Jodhpur workshop before publishing delivery-date
  promises (per the "a delivery date we keep" USP in positioning-and-usp.md §3).
