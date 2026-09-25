# India market price benchmark (wooden furniture and décor)

Date: 2026-09-25. Owner: product research + pricing. Status: measured (first real benchmark). Part of the Phase 2 workstream in
[../marketing/marketing-workstream-plan.md](../marketing/marketing-workstream-plan.md); feeds [../marketing/unit-economics-model.md](../marketing/unit-economics-model.md)
and [../marketing/positioning-and-usp.md](../marketing/positioning-and-usp.md).
Evidence tags: **VERIFIED** = read on the live page or JSON feed on 2026-09-25; **ESTIMATE** = third-party/blog/search snippet, not re-verified;
**ASSUMPTION** = our reasoning, needs owner input. Prices are INR, GST-inclusive selling prices as shown to a shopper unless stated.

## 1. Executive summary (read this first)

1. **"30% below market" is not one number.** There are three different markets in India, and the owner's 30% lands in a different place against each:
   - **Brand tier** (Wooden Street, Urban Ladder, HomeTown; also Pepperfry): list prices carry an inflated MRP. Median discount shown: Wooden Street **50%** (up to 65%), HomeTown **58%** (up to 77%), Urban Ladder **40%** (VERIFIED, table 4.3). Their *selling* prices are the honest reference, never the MRP.
   - **Jodhpur/Rajasthan D2C makers** (Woodsala, The Timber Guy, Rajwada Furnish): sell at or slightly below the brand tier. Woodsala shows an MRP on only 17 of 1,575 products, so its prices are effectively "one price" (VERIFIED).
   - **Marketplace sellers** (Flipkart/Amazon: Kendalwood, Allie Wood, Taskwood and similar): sheesham furniture at **roughly 35-55% of brand-tier selling prices** (coffee table median INR 7,038 vs INR 18,999 = 37%; 6-seater dining INR 20,464 vs INR 45,900 = 45%; bed INR 24,089 vs 45,299 = 53% - VERIFIED, search-relevance sample, wood claims unverified).
2. **30% below the brand-tier SELLING price puts you about level with Woodsala/Timber Guy and 20-90% ABOVE the marketplace floor.** Example: coffee table brand-tier median INR 18,999 -> INR 13,299; Woodsala 18,999; Flipkart 7,038. So price alone will not win against marketplace sellers; the offer must be verified solid wood + customisation + service, at a price that is visibly below the brands and honest (no fake MRP).
3. **30% below the printed MRP is meaningless** (Wooden Street queen storage bed: sale INR 56,999 vs MRP 131,999 = 57% "off"). Do not ever quote a discount against an inflated MRP.
4. **Recommended reference and ladder:** price at roughly **-25% to -35% versus brand-tier selling price, and at or 5-20% below Woodsala for the same spec** ("value-premium", section 6). Launch bands per category are in section 5.
5. **Margin check** (details in unit-economics-model.md): at those ladder prices the healthier products are **jaali/carved panels (19-29% contribution after CAC), carved mandir units (5-23%), 6-seater dining tables (7-32%), coffee tables (5-25%)**; the **thin-margin** ones are **queen beds, TV units, bedside tables, carved mirrors** (freight + CAC dominate; often negative at INR 1,500/cft timber) and all sub-INR 2,000 kitchen items unless sold in combos (ranges = timber INR 2,200 down to 900 per cubic foot; every input is an ASSUMPTION). The result depends mostly on **timber cost per cubic foot** (asked from the owner: INR 900 vs 1,500 vs 2,200 swings a queen bed from +15% to -20% contribution).
6. **The demo catalogue prices are above market** (decision 0028 seed, fictional): 6-seater dining INR 57,900 vs Woodsala median 36,999; teak coffee table INR 15,900 vs brand-tier 18,999 / Woodsala 18,999 (OK) but serving tray INR 2,590 vs Wooden Street median 1,594. Re-price before real launch.

**Confidence:** high on the price levels we scraped (live pages, dated); medium on category classification (keyword-based); low on "what sells" (see best-selling doc); no data for Amazon.in, Pepperfry, Etsy India, Craftsvilla (blocked - see 8).

## 2. Method and limits (be honest about what this is)

- Sources fetched 2026-09-25: Shopify `products.json` feeds (Woodsala, The Timber Guy, Rajwada Furnish, JL Home Decor, Shekhawati Crafts, Ellementry, The Decor Kart, Tjori, HomeTown, Nilkamal): full catalogue price and compare-at price for every product (Woodsala capped at 2,000 = 8 pages, the site has more). Page HTML/embedded JSON: Wooden Street category pages (`/coffee-tables`, `/tv-units` etc.), Urban Ladder category pages (first 12 products each, ranked by their default sort which favours bestsellers), Flipkart search result pages (top ~40 for 25 queries such as "sheesham wood coffee table"). IKEA India via page fetch summary. Home Centre, Durian, Godrej Interio, Nilkamal, Pepperfry: search-engine snippets only (undated, ESTIMATE).
- **Price = lowest variant price of the product** for Shopify sites (a product with several sizes is shown at its cheapest size); Flipkart/WS/UL = the displayed selling price. Medians are used, not means.
- **Category assignment is keyword-based** (product type where the site has a clean one - Woodsala and Timber Guy - else title words), so some cells are noisy (e.g. "shelf/rack" mixes wall shelves and full bookcases; Woodsala "chair" uses arm chairs). Read the *n* in each cell.
- **Flipkart pricing on 2026-09-25 is festival-period pricing** (listings carry the label "Big Billion Days Price"), so it may be lower than off-season. Re-scrape after the festive sales end. Search results are relevance-ranked, not filtered for real sheesham; a "sheesham" listing is the seller's claim.
- Review counts on Flipkart are per listing family (shared across colour/size variants) and are used only as a popularity proxy.
- **Not fetched (blocked):** Amazon.in (HTTP 503), Pepperfry (403), Etsy (403), Trustpilot (403), Wayfair (429). Alternative used: search snippets and third-party review pages, always tagged ESTIMATE.

## 3. What the market looks like (medians of selling price, INR)

Cell = median selling price (n = number of products). "-" = fewer than 3 products. All VERIFIED 2026-09-25 unless the source is a snippet. Full row-level evidence is in section 9.

### 3.1 Jodhpur / Rajasthan-style D2C makers
| Category | Woodsala | The Timber Guy | Rajwada Furnish | Shekhawati Crafts | JL Home Decor |
|---|---|---|---|---|---|
| bed | 37,499 (n=148) | 36,999 (n=119) | 23,999 (n=229) | 30,950 (n=18) | 51,999 (n=134) |
| sofa | 44,999 (n=150) | 51,999 (n=27) | 22,499 (n=18) | - | 48,499 (n=73) |
| chair | 16,249 (n=40) | 8,999 (n=78) | 7,999 (n=37) | 6,800 (n=18) | 17,499 (n=79) |
| dining | 36,999 (n=148) | 30,499 (n=124) | 29,999 (n=107) | 17,250 (n=16) | 49,499 (n=64) |
| coffee table | 18,999 (n=38) | 9,999 (n=53) | 12,999 (n=11) | 15,700 (n=30) | 24,000 (n=184) |
| side/bedside table | 8,999 (n=133) | - | 5,999 (n=21) | 7,540 (n=23) | 14,999 (n=193) |
| console | 24,999 (n=40) | - | 15,999 (n=7) | 17,900 (n=9) | 32,999 (n=91) |
| tv unit | 28,999 (n=79) | 12,999 (n=23) | 18,999 (n=15) | 23,050 (n=16) | 37,499 (n=43) |
| shelf/rack | 6,999 (n=93) | 15,999 (n=27) | 14,999 (n=15) | 24,250 (n=28) | 29,999 (n=121) |
| cabinet/sideboard | 17,499 (n=44) | 18,999 (n=42) | 23,499 (n=46) | 26,800 (n=51) | 37,999 (n=279) |
| wardrobe | 37,999 (n=95) | 37,999 (n=13) | 26,999 (n=9) | 56,250 (n=8) | 48,749 (n=40) |
| desk | 32,899 (n=29) | 13,499 (n=12) | 19,499 (n=34) | 18,550 (n=11) | 21,000 (n=25) |
| bench/stool | 16,599 (n=100) | - | 5,999 (n=4) | 14,750 (n=10) | 11,500 (n=34) |
| mirror | 8,599 (n=69) | - | - | 5,200 (n=9) | 13,499 (n=210) |
| wall décor | 4,999 (n=46) | - | - | - | 61,000 (n=28) |
| jaali/panel | 18,999 (n=9) | 25,249 (n=4) | - | 16,100 (n=4) | 21,499 (n=72) |
| kitchen/tray | 4,199 (n=60) | - | - | - | 2,999 (n=35) |
| planter | - | - | - | - | 3,299 (n=19) |
| storage box | 3,899 (n=84) | - | 36,999 (n=11) | - | 24,999 (n=10) |
| toy/game | - | - | - | - | - |
| temple/mandir | 21,899 (n=55) | - | - | - | 13,499 (n=9) |
| swing | 25,399 (n=73) | - | - | - | - |
Notes: Woodsala and Timber Guy are Jodhpur makers (own sites: woodsala.com, thetimberguy.com). Rajwada Furnish, JL Home Decor and Shekhawati Crafts are Shopify D2C stores whose city/wood claims we did not verify (treat as "Rajasthan-style D2C", ASSUMPTION). Rajwada shows no compare-at price at all.

### 3.2 Brand tier, mass tier and marketplace sellers
| Category | Wooden Street | Urban Ladder | HomeTown | Nilkamal | Flipkart (marketplace sellers) |
|---|---|---|---|---|---|
| bed | 32,999 (n=6) | 45,299 (n=12) | 59,900 (n=55) | 19,490 (n=43) | 24,089 (n=40) |
| sofa | - | 52,499 (n=12) | 39,999 (n=160) | 22,000 (n=39) | 14,566 (n=40) |
| chair | 19,499 (n=12) | 10,999 (n=24) | 14,600 (n=43) | 3,240 (n=249) | 6,844 (n=40) |
| dining | 55,849 (n=6) | - | 35,950 (n=56) | 7,520 (n=23) | 20,464 (n=80) |
| coffee table | 18,999 (n=38) | 15,499 (n=12) | 23,490 (n=17) | 3,395 (n=18) | 7,038 (n=40) |
| side/bedside table | 7,999 (n=47) | 10,999 (n=12) | 8,595 (n=10) | - | 3,490 (n=39) |
| console | 14,499 (n=6) | 31,499 (n=12) | - | - | 9,238 (n=40) |
| tv unit | 24,499 (n=12) | 25,999 (n=12) | 12,400 (n=4) | - | 14,330 (n=39) |
| shelf/rack | 13,499 (n=61) | 7,499 (n=24) | 7,794 (n=32) | 3,495 (n=30) | 7,919 (n=117) |
| cabinet/sideboard | 32,999 (n=11) | 28,999 (n=24) | 19,340 (n=10) | 6,310 (n=78) | 20,793 (n=39) |
| wardrobe | 29,499 (n=28) | 39,499 (n=12) | 31,920 (n=41) | 15,190 (n=19) | 22,799 (n=39) |
| desk | - | 11,499 (n=12) | 6,840 (n=16) | 6,790 (n=12) | 11,830 (n=40) |
| bench/stool | 14,999 (n=15) | 11,249 (n=24) | 12,495 (n=4) | 770 (n=16) | 4,244 (n=80) |
| mirror | 3,449 (n=6) | 8,749 (n=12) | 25,900 (n=19) | 15,220 (n=42) | 344 (n=40) |
| wall décor | 2,799 (n=4) | 2,599 (n=12) | 4,699 (n=159) | - | - |
| jaali/panel | - | - | - | - | 216 (n=40) |
| kitchen/tray | 1,594 (n=6) | 8,149 (n=12) | 2,065 (n=76) | - | 294 (n=38) |
| planter | 409 (n=6) | 1,549 (n=12) | - | - | 342 (n=38) |
| storage box | - | - | 1,120 (n=15) | 1,359 (n=3) | 422 (n=39) |
| toy/game | - | - | 1,800 (n=12) | - | 328 (n=40) |
| temple/mandir | - | - | - | - | 494 (n=40) |
| swing | 30,999 (n=6) | - | - | - | 879 (n=40) |
Notes: Wooden Street and Urban Ladder rows show the first 6-44 (WS) or 12 (UL) products per category as ranked by the site - a bestseller-biased sample, not the full catalogue. Nilkamal is mostly engineered/plastic/metal (mass tier); HomeTown includes engineered "sheesham colour" finishes, so its medians are not all solid wood. Flipkart column = top ~40 results for "sheesham wood <category>" or "wooden <category>" searches; for décor items (mirror, tray, planter, jhula, jaali) the cheap fillers dominate the median and it is not comparable to a solid-wood carved piece.

### 3.3 Décor D2C brands (small items)
| Category | Ellementry | The Decor Kart | Tjori |
|---|---|---|---|
| wall décor | 1,250 (n=14) | 4,140 (n=165) | 869 (n=9) |
| jaali/panel | 9,350 (n=8) | - | - |
| kitchen/tray | 1,890 (n=422) | 1,476 (n=233) | 579 (n=5) |
| planter | 1,550 (n=7) | 3,800 (n=9) | - |
| storage box | 2,390 (n=51) | 2,860 (n=17) | 1,519 (n=22) |
| toy/game | - | 3,720 (n=20) | - |
| temple/mandir | - | 8,800 (n=19) | 1,037 (n=20) |
| mirror | 6,554 (n=8) | 4,395 (n=18) | 459 (n=13) |
Ellementry, The Decor Kart, Tjori are décor-first D2C brands (many items are not wood - table includes all categories they sell under those keywords).

### 3.4 Single-source reference points (search snippets, undated - ESTIMATE)
| Source | Item | Price INR | URL |
|---|---|---|---|
| Home Centre | Helios Liser sheesham coffee table | 9,999 | https://www.homecentre.in/in/en/c/livingroom-tables (snippet) |
| Home Centre | Helios Besta sheesham coffee table | 13,330 | https://www.homecentre.in/in/en/HC-HHLINK-09AUG2023/HOMECENTRE-Helios-Besta-Sheesham-Wood-Coffee-Table--Brown/p/1000010141542 |
| Home Centre | Adana mango wood coffee table | 9,997 | https://www.homecentre.in/in/en/Living-Room/Tables/Center-Tables/HOMECENTRE-Adana-Mango-Wood-Coffee-Table--Brown/p/1000012511088 |
| Home Centre | Veda sheesham 6-seater dining table | 47,998 | https://www.homecentre.in/in/en/Dining-Room/Dining-Tables/6-Seater-Tables/HOMECENTRE-Veda-Sheesham-Wood-6-Seater-Dining-Table--Brown/p/1000008372938 |
| IKEA India (fetched 2026-09-25, VERIFIED via page summary) | KRAGSTA coffee table, mango wood | 12,990 | https://www.ikea.com/in/en/cat/coffee-tables-10705/ |
| IKEA India | NORRVAGA coffee table, mango wood | 8,990 | same |
| IKEA India | LACK coffee table 90x55 (particleboard) | 3,490 | same |
| Pepperfry (snippet) | Sleepyhead sheesham king bed, honey finish, "MRP 32,499, 24% off" | ~24,700 implied | https://www.pepperfry.com/product/sheesham-wood-king-size-bed-in-honey-brown-finish-2051899.html |
| Nilkamal (snippet) | Queen bed solid wood with hydraulic storage | up to ~70,000; queen beds from ~18,000 (metal) | https://www.nilkamalfurniture.com/collections/queen-size-beds |
| Durian (snippet) | Cambert engineered-wood bedside table | 17,940 | https://www.durian.in/product/cambert-brown-engineered-wood-bed-side-table |
| Godrej Interio | Utopia king solid-wood bed (sheesham) | price not visible in snippets | https://www.godrejinterio.com/furniture-wooden-beds |
| Amazon.in (snippet, listing pages blocked) | Sheesham coffee tables | 5,895 - 11,799, ratings 4.2-4.6 (46-647 reviews) | https://www.amazon.in/sheesham-wood-coffee-table/s?k=sheesham+wood+coffee+table |

Home Centre's mango/sheesham coffee tables at INR 9,997-13,330 and IKEA's mango-wood KRAGSTA at 12,990 are important anchors: a solid-wood coffee table sold by big-box retailers sits around INR 10-13k, so a INR 11,999-13,999 launch price is in line with them.

## 4. MRP versus selling price: the discount reality

### 4.1 How deep the discounting is (products showing a compare-at/MRP price)
| Source | Products seen | With MRP > price | Median discount | 90th percentile |
|---|---|---|---|---|
| Woodsala | 1,575 | 17 | 30% | 40% |
| The Timber Guy | 522 | 522 | 35% | 35% |
| Rajwada Furnish | 582 | 0 | none shown | - |
| Shekhawati Crafts | 260 | 53 | 20% | 30% |
| JL Home Decor | 1,788 | 1,689 | 33% | 54% |
| Wooden Street | 308 | 308 | 50% | 65% |
| Urban Ladder | 240 | 227 | 40% | 50% |
| HomeTown | 1,201 | 547 | 58% | 77% |
| Nilkamal | 651 | 650 | 24% | 53% |
| Flipkart (marketplace sellers) | 988 | 988 | 55% | 75% |
| Ellementry | 1,162 | 77 | 20% | 30% |
| The Decor Kart | 2,000 | 1,206 | 40% | 40% |
| Tjori | 2,000 | 1,945 | 37% | 73% |
- The Timber Guy shows **exactly 35% off on 522 of 522 products** - a formula-driven compare-at price, not a real former price (VERIFIED). Buyers learn to ignore it.
- Wooden Street sheesham beds (`/sheesham-wood-beds`, page dated "Last Updated on September 25, 2026"): Allure poster king INR 58,999 vs MRP 118,999 (50%); Adolph king INR 32,999 vs 66,999 (51%); Walken queen with drawer storage INR 56,999 vs 131,999 (57%, 1,050 ratings); Brixton king INR 24,999 vs 65,999 (62%); Hout single INR 16,999 vs 30,999 (45%). URL: https://www.woodenstreet.com/sheesham-wood-beds
- Urban Ladder beds (https://www.urbanladder.com/beds, 1,701 products, banner "Additional up to INR 10,000 off. Use code EXTRA10K"): median 36% off in the 12 shown; e.g. Takai solid queen bed INR 54,999 (MRP 74,999, 27%), Raynor solid queen INR 32,999 (MRP 54,999, 40%), Fidora solid queen with drawer storage INR 49,999 (MRP 70,599, 29%), engineered Amy queen INR 16,999 (MRP 30,699, 45%).
- Woodsala: prices without MRP for 98% of products - the honest-pricing model; the closest comparable to what we should do.

### 4.2 Consequence
A "70% off" sticker is normal in this market and buyers know it is theatre; several complaint threads mention price/quality mismatch (see competitor analysis). Our credibility play is **one honest price** and an explanation of why it is lower (positioning doc). Whether a compare-at price may be shown at all is a legal question (Consumer Protection Act / CCPA misleading-advertising guidelines) - **owner to confirm with a lawyer; we do not quote it here**.

## 5. Target price ladder (what "30% below" actually means)

Definitions, in priority order:

- **Reference price R = the brand-tier median SELLING price** (Wooden Street, Urban Ladder, HomeTown; median of source medians).
- **Target price T = 0.70 x R**, then sanity-checked against Woodsala/Timber Guy (parity zone) and the marketplace median (floor).
- Never define the discount against MRP.

### 5.1 Numbers (INR, GST-inclusive, VERIFIED inputs 2026-09-25; T and bands are our calculation)
| Category | Brand-tier median sale (WS/UL/HT) | Jodhpur D2C median (Woodsala; Timber Guy) | Marketplace median (Flipkart) | T = -30% vs brand tier | T vs Woodsala | T vs Flipkart | Comparable? |
|---|---|---|---|---|---|---|---|
| Bed (queen/king mix) | 45,299 | 37,499; 36,999 | 24,089 | 31,709 | -15% | +32% | yes (mix of storage/no storage) |
| Dining table / set | 45,900 | 36,999; 30,499 | 20,464 | 32,130 | -13% | +57% | yes |
| Coffee table | 18,999 | 18,999; 9,999 | 7,038 | 13,299 | -30% | +89% | yes |
| Side / bedside table | 8,595 | 8,999; n/a | 3,490 | 6,016 | -33% | +72% | yes |
| Console table | 22,999 | 24,999; n/a | 9,238 | 16,099 | -36% | +74% | yes |
| TV unit | 24,499 | 28,999; 12,999 | 14,330 | 17,149 | -41% | +20% | yes |
| Cabinet / sideboard | 28,999 | 17,499; 18,999 | 20,793 | 20,299 | +16% | -2% | mixed sizes - T is NOT below D2C |
| Wardrobe | 31,920 | 37,999; 37,999 | 22,799 | 22,344 | -41% | -2% | brand tier includes engineered |
| Study desk | 9,170 | 32,899; 13,499 | 11,830 | 6,419 | -80% | -46% | no (brand tier is engineered desks) |
| Bench / stool | 12,495 | 16,599; n/a | 4,244 | 8,746 | -47% | +106% | partly |
| Mirror | 8,749 | 8,599; n/a | 344 | 6,124 | -29% | n/a | Flipkart median is cheap frames - not comparable |
| Tray / kitchen wood | 2,065 | 4,199; n/a | 294 | 1,446 | -66% | n/a | no (Flipkart is mass, WS/UL differ) |
| Mandir / temple | n/a | 21,899; 23,999 | 494 | n/a | - | n/a | Flipkart is cheap engineered |
| Jhula / swing | 30,999 | 25,399; n/a | 879 | 21,699 | -15% | n/a | Flipkart is fabric hammocks |

### 5.2 Recommended launch bands (GST-inclusive; decision inputs, ASSUMPTION until owner confirms cost)
| Product (solid sheesham unless noted) | Launch band INR | Why this band |
|---|---|---|
| Queen bed, carved headboard, no storage | 32,999-36,999 | Level with/below Woodsala 37,499 and Timber Guy 36,999; -25% vs UL 45,299; +37% vs Flipkart 24,089 -> must justify with carving + custom size |
| 6-seater dining table (table only) | 27,999-32,999 | Woodsala dining set median 36,999; Flipkart 20,464-27,353; brand 45,900 |
| Coffee table 90x50 | 11,999-13,999 | Home Centre 9,997-13,330; IKEA mango 8,990-12,990; brand 18,999 |
| Bedside table (single) | 5,499-5,999; pair 9,999-10,999 | Woodsala 8,999; WS 7,999; Flipkart 3,490 |
| Console table | 15,999-17,999 | Woodsala 24,999; Rajwada 15,999; Flipkart 9,238 |
| TV unit 5 ft | 16,999-18,999 | Woodsala 28,999; WS 24,499; Flipkart 14,330 |
| Bookshelf 5-tier | 12,999-14,999 | WS median across shelves 11,999; Woodsala book rack 28,999; Timber Guy 16,499 |
| Carved-frame wall mirror 60x90 | 4,999-5,999 | Woodsala 8,599; UL 8,749 |
| Jaali / carved wall panel 60x90 | 5,999-8,999 | Woodsala 18,999; Ellementry 9,350; Timber Guy 25,249 (larger sizes) |
| Mandir / temple 2-3 ft | 14,999-17,999 | Woodsala 21,899; JL Home Decor 13,499 |
| Serving tray with handles | 999-1,499 | WS 1,594; HomeTown 2,065; UL 8,149 (outlier); Woodsala 4,199 (larger) |
| Cutting board (round, 30 cm) | 999-1,299 | HomeTown/Ellementry kitchen wood 1,890-2,065 (mixed) |
| Planter / plant stand | 799-1,999 | WS 409 (small), UL 1,549, Decor Kart 3,800 |
| Wardrobe / almirah | AVOID first (see white space) | Woodsala 37,999, brand 31,920, Flipkart 22,799 - heavy, high freight |

## 6. Feature comparison: wood, size, warranty, delivery, assembly, returns, reviews

VERIFIED = read on brand site 2026-09-25; snippet = search result, ESTIMATE.

| Brand | Wood claimed | Warranty | Delivery time | Assembly | Returns | Ratings / reviews (where we saw them) | Top complaints |
|---|---|---|---|---|---|---|---|
| Wooden Street | Sheesham, mango, teak + engineered (all mixed on site) | "Best Warranty*" (asterisk, terms not shown); mattress 5-10 yr; warranty ends if the product is moved from delivery address | Dispatch aim 5-7 days; "Ships in 2 days" on some SKUs; custom made from scratch; customers report 5-9 weeks | Free installation | Only if damaged/defective/different, report within 3 days, request within 7 days, original packaging | Per-product counts 42-1,050 (e.g. Walken queen bed 1,050). SmartCustomer aggregator: 176 reviews, 2.2/5 on the fetched page (search snippet said 1.7/5 - unresolved) | Delays, damaged items, no replacement, unresponsive support, wood not cured (swelling/jammed drawers) - see competitor doc |
| Urban Ladder | Solid + engineered, clearly named in titles | Varies per product; e.g. 3 years on some | Not shown on listing | Must be unboxed/assembled by UL experts or warranty/returns void | 7 days for damaged/defective; cancellation until shipped | Trustpilot 1.5/5 from 69 reviews (snippet, ESTIMATE) | Delivery delays, missing parts, sagging sofas, poor support |
| Pepperfry | Third-party brands (Woodsworth, Sleepyhead etc.) | 3 years on "King Size Beds" category page (snippet) | Not verified | Installation offered; delays reported | Cancellation fee 2.5% reported | Trustpilot complaints (snippet) | Delayed delivery/assembly, refunds slow, replacement quality |
| Woodsala (Jodhpur) | "Total wood", teak and solid wood, no MDF except behind mirrors/upholstery | 1 year on wooden products | 18-30 days custom per policy; reviews say 4-6+ weeks | Separate assembly service page | No return/exchange; wrong-spec replaced if reported within 72 h; cancellation 50% after 24 h | 1,225 reviews on own site (claimed); Justdial 408 ratings | Delivery time, weak status updates, occasional quality inconsistency; packaging praised |
| The Timber Guy (Sunrise Intl., Jodhpur) | Sheesham; mango/acacia/teak on request; "CCA-treated, kiln dried 30 days to 8-12% moisture" | Not stated on About page | Not stated | n/a | Domestic policy page exists (not read) | Not fetched | Not fetched |
| IKEA India | Mostly particleboard/fibreboard; few solid (mango KRAGSTA) | Not read | Not read | Flat-pack, customer assembles | Not read | Ratings visible per SKU (e.g. LACK 4.5, 4,143 reviews) | n/a |
| Flipkart marketplace sellers | "Sheesham/rosewood" per seller listing (unverified) | Per seller | Marketplace estimates | Often DIY | Marketplace policy | Typically 3.8-4.6 stars; e.g. Allie Wood 6-seater dining 4.0 (3,961), Kendalwood sofa 4.1 (1,514) | Not analysed (Flipkart reviews not fetched) |

Size: our own size system (decision 0039) uses Single/Double/Queen/King (3x6, 4x6, 5x6.5, 6x6.5 ft) and Small/Medium/Large; competitors quote Queen/King with the same sizes.

## 7. Seasonality pricing note
Large online sale events run late Sept-Oct (Flipkart Big Billion Days label seen on 2026-09-25 listings; Amazon Great Indian Festival) and Diwali; wedding season is Nov-Feb (India recorded 35 lakh+ weddings in 2024, ESTIMATE via a retailer blog). Competitors run "Navratri furniture sale" campaigns (e.g. https://www.nismaayadecor.in/collections/navratri-furniture-sale). Expect marketplace prices in our scrape to be at a seasonal low; expect brand sale banners ("up to 70% off") to persist.

## 8. Data gaps (what we could not get)
- Amazon.in listings/best-seller ranks (503), Pepperfry catalogue (403), Etsy India (403), Craftsvilla (not found in search), Trustpilot/Justdial full text (403 or snippet only).
- Godrej Interio, Durian, @home, Home Centre catalogue prices: only snippets; @home site unreachable.
- Wood authenticity: no lab test of any competitor; "solid sheesham" claims are unverified.
- Weight/dimension of competitor items (size normalisation) - not captured; medians mix sizes.
- Actual sales volumes: none of these sites publish them; review counts are proxies.
- Owner's cost: unknown (needed for the margin check).

## 9. Owner must replace these assumptions (checklist)
1. Ex-factory cost of each product (or timber INR/cubic foot, labour, finish, hardware).
2. Whether the workshop uses its own timber stock (price paid per cubic foot, sheesham vs mango vs acacia).
3. Real available sizes and made-to-order lead time (Woodsala claims 18-30 days; reviews show 4-6+ weeks).
4. Whether you can promise a warranty (1 year like Woodsala? longer?) and a repair policy.
5. Legal position on showing any compare-at price; GST rates for each product family with your CA (furniture HSN 9403 = 18% per sources, décor rates conflicting: HSN 4420 quoted 5% and 12%, HSN 4419 5% - ESTIMATE).
6. Launch price per SKU (section 5.2 is our proposal).

## 10. Row-level observed prices (CSV-like)

One representative (median-priced) product per source per category, scraped 2026-09-25. `sale` and `mrp` in INR GST-inclusive; `off` = discount versus the site's own MRP/compare-at; `reviews` = rating count where the source shows it. Category pages for Wooden Street and Urban Ladder are the listing pages the row came from; Flipkart URL = the search page.

| category | source | product | sale | mrp | off | reviews | url |
|---|---|---|---|---|---|---|---|
| bed | Woodsala | Full Cane Panel Bed with Contemporary Frame | 36,999 | - | - | - | https://www.woodsala.com/products/full-cane-panel-bed-with-contemporary-frame |
| bed | The Timber Guy | Wooden Four Poster Bed with Carving – Mango Wood King & Queen | 36,999 | 56,922 | 35% | - | https://thetimberguy.com/products/jodhpur-wooden-queen-or-king-size-poster-bed-with-carving |
| bed | Rajwada Furnish | Tejas Solid Wood Queen Size Bed With Storage Drawers | 23,999 | - | - | - | https://www.rajwadafurnish.com/products/tejas-solid-wood-queen-size-bed-with-storage-drawers-1 |
| bed | Shekhawati Crafts | Brassico Sheesham Wood King Size Bed | 32,000 | 38,000 | 16% | - | https://www.shekhawaticrafts.com/products/brassico-king-size-bed |
| bed | JL Home Decor | Rattan Headboard Bed - Queen/King/Cal King - Mango Wood & Charcoal | 51,999 | 95,999 | 46% | - | https://jlhomedecorin.com/products/rattan-headboard-bed-queen-king-cal-king-mango-wood-charcoal |
| bed | Wooden Street | Adolph Sheesham Wood King Size Bed Without Storage (Honey Finish) | 32,999 | 66,999 | 51% | 817 | https://www.woodenstreet.com/sheesham-wood-beds |
| bed | Urban Ladder | Scott Storage Bed Bed Size king Storage Type box Finish californian wa | 40,599 | - | - | - | https://www.urbanladder.com/beds |
| bed | HomeTown | Woodrow Sheesham Wooden Rosewood Queen Bed in Honey Colour with Box St | 59,900 | 139,900 | 57% | - | https://www.hometown.in/products/woodrow-sheesham-wooden-rosewood-queen-bed-in-honey-colour-with-box-storage |
| bed | Nilkamal | Nilkamal Bruce Queen Bed with Box Storage (Walnut & Cappuccino) | 19,490 | 62,000 | 69% | - | https://www.nilkamalfurniture.com/products/nilkamal-bruce-queen-bed-with-box-storage-walnut-cappucino |
| bed | Flipkart (marketplace sellers) | CLANECRAFT Solid Sheesham Wood Queen Size Bed Without M... | 24,089 | 51,999 | 54% | 99 | https://www.flipkart.com/search?q=sheesham+wood+bed+queen |
| sofa | Woodsala | The Artisan’s Retreat sofa cum bed | 44,999 | - | - | - | https://www.woodsala.com/products/the-artisan-s-retreat-sofa-cum-bed |
| sofa | The Timber Guy | Contemporary Wooden Sofa set  - Choose your combination | 51,999 | 79,999 | 35% | - | https://thetimberguy.com/products/contemporary-wooden-sofa-set-with-1-center-table |
| sofa | Rajwada Furnish | Moscow Solid Sheesham Wood 2 Seater Sofa | 21,999 | - | - | - | https://www.rajwadafurnish.com/products/moscow-solid-sheesham-wood-2-seater-sofa |
| sofa | JL Home Decor | CARVED CANE SOFA | 48,499 | 74,999 | 35% | - | https://jlhomedecorin.com/products/carved-cane-sofa |
| sofa | Urban Ladder | Ronan 3 Seater Fabric Sofa In Rust Colour | 49,999 | 66,599 | 25% | - | https://www.urbanladder.com/sofas |
| sofa | HomeTown | Bellrose Velvet Fabric Sofa in Brown Color / 2 Seater | 39,999 | 199,900 | 80% | - | https://www.hometown.in/products/bellrose-velvet-fabric-sofa-in-brown-color-2-seater |
| sofa | Nilkamal | Nilkamal Bradd 2 Seater Sofa (Black) | 22,000 | 32,000 | 31% | - | https://www.nilkamalfurniture.com/products/nilkamal-bradd-2-seater-sofa-black-lbradsofa2sblk |
| sofa | Flipkart (marketplace sellers) | Taskwood Furniture Solid Wood Sheesham Wood 2 Seater So... | 14,517 | 24,999 | 42% | 24 | https://www.flipkart.com/search?q=sheesham+wood+sofa |
| chair | Woodsala | Classic Curved Back Wooden Handmade Chair Set of 2  for Home | 16,499 | - | - | - | https://www.woodsala.com/products/classic-curved-back-metallic-leg-wooden-handmade-chair-set-for-home |
| chair | The Timber Guy | Mid Century wooden Kangaroo lounge chair - Rattan cane Style Chandigar | 8,999 | 13,845 | 35% | - | https://thetimberguy.com/products/mid-century-wooden-kangaroo-lounge-chair-rattan-cane-style-chandigarh-chair-with-seat-cushion |
| chair | Rajwada Furnish | Jenine Solid Sheesham Wood Dining Chair (Set Of 2) | 7,999 | - | - | - | https://www.rajwadafurnish.com/products/jenine-solid-sheesham-wood-dining-chairs |
| chair | Shekhawati Crafts | Anvi Sheesham Wood Rattan Cane Chair | 6,800 | 8,600 | 21% | - | https://www.shekhawaticrafts.com/products/anvi-sheesham-wood-rattan-cane-chair |
| chair | JL Home Decor | Chandigarh Teak & Rattan Armchair with Cushion – Solid Acacia Wood Lou | 17,499 | 24,999 | 30% | - | https://jlhomedecorin.com/products/chandigarh-teak-rattan-armchair-with-cushion-solid-acacia-wood-lounge-chair |
| chair | Wooden Street | Claudia High Back Lounge Chair (Cotton, Magnolia Beige) | 18,999 | 33,999 | 44% | 34 | https://www.woodenstreet.com/lounge-chairs |
| chair | Urban Ladder | Diner Solid Wood Dining Chair in Dark Walnut Finish & Grey Colour - Se | 10,999 | 13,099 | 16% | - | https://www.urbanladder.com/dining-chairs |
| chair | HomeTown | Oren Dining Chair Set of 2 Beige | 14,600 | 51,900 | 72% | - | https://www.hometown.in/products/oren-dinning-chair-set-of-2-beige |
| chair | Nilkamal | Nilkamal Crystal Polypropylene Premium Chair (Weather Brown) | 3,240 | 4,200 | 23% | - | https://www.nilkamalfurniture.com/products/nilkamal-crystal-pp-polypropylene-chair-weather-brown-chrcrystalppwbn |
| chair | Flipkart (marketplace sellers) | MAA LAXMI Solid Wood Dining Chair/Dining Chair Set Of 2... | 6,799 | 11,599 | 41% | 288 | https://www.flipkart.com/search?q=sheesham+wood+chair |
| chair | Ellementry | Farmhouse flair chair | 15,750 | - | - | - | https://www.ellementry.com/products/farmhouse-flair-chair-wdfna2810 |
| chair | The Decor Kart | Rocking Chair Desk Clock | 4,600 | - | - | - | https://www.thedecorkart.com/products/rocking-chair-desk-clock |
| dining | Woodsala | Minimalist Rectangular Dining Table with Low Round Seating | 36,999 | - | - | - | https://www.woodsala.com/products/minimalist-rectangular-dining-table-with-low-round-seating |
| dining | The Timber Guy | 4 Seater Wooden Dining Table Set with Rattan Cane Chairs | 30,999 | 47,691 | 35% | - | https://thetimberguy.com/products/contemporary-wooden-dining-table-with-4-chair-furniture-set-with-rattan-cane-work |
| dining | Rajwada Furnish | Haveli Solid Wood 6 Seater Dining Table Set With Bench | 29,999 | - | - | - | https://www.rajwadafurnish.com/products/haveli-solid-wood-6-seater-dining-table-set-with-bench |
| dining | Shekhawati Crafts | Nexus Sheesham Wood 6 Seater Dining Table | 17,600 | 27,540 | 36% | - | https://www.shekhawaticrafts.com/products/nexus-sheesham-wood-6-seater-dining-table |
| dining | JL Home Decor | Regent Classico Solid Wood Dining Table – Brown Finish, Contemporary D | 48,999 | 98,499 | 50% | - | https://jlhomedecorin.com/products/regent-classico-solid-wood-dining-table-brown-finish-contemporary-design-by-rivo-homes |
| dining | Wooden Street | Janet Premium Sheesham Wood 6 Seater Dining Set with Janet Table and H | 51,999 | 94,999 | 45% | 62 | https://www.woodenstreet.com/sheesham-wood-dining-table-sets |
| dining | HomeTown | Oren Sintered Stone 6 Str Dining Table | 36,500 | 143,900 | 75% | - | https://www.hometown.in/products/oren-sintered-stone-6-str-dinning-table |
| dining | Nilkamal | Nilkamal Meridian 4 Seater Dining Set | 7,520 | 9,900 | 24% | - | https://www.nilkamalfurniture.com/products/nilkamal-meridian-4-seater-dining-set |
| dining | Flipkart (marketplace sellers) | Kendalwood Furniture Premium Dining Room Furniture Wood... | 20,360 | 40,000 | 49% | 20 | https://www.flipkart.com/search?q=sheesham+wood+dining+table+6+seater |
| dining | Ellementry | West Village Four Seater Oval Dining Table | 42,500 | 50,000 | 15% | - | https://www.ellementry.com/products/west-village-wooden-four-seater-oval-dining-table-wdfna2823 |
| dining | The Decor Kart | Rooster Egg Basket - Green Wings | 1,640 | - | - | - | https://www.thedecorkart.com/products/rooster-egg-basket-green-wings |
| coffee table | Woodsala | Geometric Round Coffee Table - Contemporary Indian Design | 18,999 | - | - | - | https://www.woodsala.com/products/geometric-round-coffee-table-contemporary-indian-design |
| coffee table | The Timber Guy | Wooden Oval Coffee Table with Bottom Shelf | 9,999 | 15,383 | 35% | - | https://thetimberguy.com/products/wooden-oval-coffee-center-table-with-bottom-shelf |
| coffee table | Rajwada Furnish | Shashwat Sheesham Solid Wood Coffee Table | 12,999 | - | - | - | https://www.rajwadafurnish.com/products/shashwat-sheesham-solid-wood-coffee-table |
| coffee table | Shekhawati Crafts | Mehraab Solid Wood Coffee Table | 14,900 | - | - | - | https://www.shekhawaticrafts.com/products/mehraab-solid-wood-coffee-table |
| coffee table | JL Home Decor | Plinth Center Table-Mango Wood Off-White Stain Concave Edge Design 107 | 24,000 | 30,000 | 20% | - | https://jlhomedecorin.com/products/plinth-center-table-mango-wood-off-white-stain-concave-edge-design-107x107x44cm-modern-coffee-table-living-room-display |
| coffee table | Wooden Street | Alanis Coffee Table (Honey Finish) | 18,999 | 30,999 | 39% | 101 | https://www.woodenstreet.com/product/alanis-coffee-table-honey-finish |
| coffee table | Urban Ladder | Kaya Solid Wood Coffee Table In Danish Walnut Finish | 15,999 | 20,999 | 24% | - | https://www.urbanladder.com/coffee-tables |
| coffee table | HomeTown | Oren Sintered Stone Top Coffee Table | 23,490 | 67,900 | 65% | - | https://www.hometown.in/products/oren-sintered-stone-top-coffee-table |
| coffee table | Nilkamal | Nilkamal Baron Coffee Table (New Wenge) | 3,690 | 5,000 | 26% | - | https://www.nilkamalfurniture.com/products/nilkamal-baron-coffee-table-new-wenge |
| coffee table | Flipkart (marketplace sellers) | LOONART Solid Wood Coffee Table / Wooden Center Table /... | 6,649 | 15,999 | 58% | 5 | https://www.flipkart.com/search?q=sheesham+wood+coffee+table |
| coffee table | Ellementry | Metal Coffee Table & Nested Drum | 29,280 | 36,600 | 20% | - | https://www.ellementry.com/products/metal-coffee-table-nested-drum-wdfna3298 |
| coffee table | The Decor Kart | Gear Fusion Coffee Table with Clock Top - Large | 48,000 | - | - | - | https://www.thedecorkart.com/products/gear-fusion-coffee-table-with-clock-top-large |
| side/bedside table | Woodsala | Heritage Tile Inlay Pedestal Stand | 8,999 | - | - | - | https://www.woodsala.com/products/heritage-tile-inlay-pedestal-stand |
| side/bedside table | Rajwada Furnish | Anamika Solid Sheesham Wood Side Table | 5,999 | - | - | - | https://www.rajwadafurnish.com/products/anamika-solid-sheesham-wood-bedside-table |
| side/bedside table | Shekhawati Crafts | Orion Mango Wood Bedside Table | 7,540 | - | - | - | https://www.shekhawaticrafts.com/products/orion-mango-wood-bedside-table |
| side/bedside table | JL Home Decor | Stylish Metal Bedside Locker | 14,999 | 24,999 | 40% | - | https://jlhomedecorin.com/products/stylish-and-metal-bedside-locker-perfect-addition-to-your-bedroom |
| side/bedside table | Wooden Street | Adolph Bedside Table (Walnut Finish) | 7,999 | 17,999 | 56% | 440 | https://www.woodenstreet.com/product/adolph-bedside-table-walnut-finish |
| side/bedside table | Urban Ladder | Toledo Solid Wood Bedside Table in Danish Walnut Finish | 10,999 | 18,999 | 42% | - | https://www.urbanladder.com/bedside-tables |
| side/bedside table | HomeTown | Gloria Bedside Table Design with 2 Drawer in Sebastian Oak | 8,290 | 9,498 | 13% | - | https://www.hometown.in/products/grace-bed-side-table-sebastain-oak |
| side/bedside table | Flipkart (marketplace sellers) | NK Furniture Solid Sheesham Wood Bedside Table for Bedr... | 3,490 | 5,000 | 30% | 5 | https://www.flipkart.com/search?q=sheesham+wood+side+table |
| side/bedside table | Ellementry | Old World ready-to-assemble bedside drawer | 16,600 | - | - | - | https://www.ellementry.com/products/old-world-ready-to-assemble-bedside-drawer-wdfna2788 |
| side/bedside table | The Decor Kart | Golden Bloom Accent Side Table - Small | 11,160 | 18,600 | 40% | - | https://www.thedecorkart.com/products/golden-bloom-accent-side-table-small |
| console | Woodsala | Aurivelle Artisan Luxury Brass finish-Top Console Table with Sculpted  | 24,999 | - | - | - | https://www.woodsala.com/products/aurivelle-artisan-luxury-brass-top-console-table-with-sculpted-solid-wood-frame |
| console | Rajwada Furnish | Rudra Luxury Console Table Solid Wood | 15,999 | - | - | - | https://www.rajwadafurnish.com/products/rudra-luxury-console-table-solid-wood |
| console | Shekhawati Crafts | Ayaan sheesham wood console table with 3 drawers | 17,900 | - | - | - | https://www.shekhawaticrafts.com/products/ayaan-sheesham-wood-console-table-with-3-drawers |
| console | JL Home Decor | Medusa Console Table-Mango Wood  Tan White Wash 36x173x86cm 2-Drawer S | 32,999 | 40,000 | 18% | - | https://jlhomedecorin.com/products/medusa-console-table-mango-wood-painted-tan-white-wash-36x173x86cm-2-drawer-storage-shelf-entryway-hallway-rustic-traditional |
| console | Wooden Street | Brighton Mango Wood 2 Door Sideboard and Cabinet (Teak Finish) | 15,999 | 38,999 | 59% | 32 | https://www.woodenstreet.com/console-tables |
| console | Urban Ladder | Tavo Solid Wood and Toronto Console Table In Antique Amber Finish | 32,999 | 54,999 | 40% | - | https://www.urbanladder.com/console-tables |
| console | Flipkart (marketplace sellers) | Furnisquare solid wood console table sheesham furniture... | 9,017 | 22,999 | 61% | 25 | https://www.flipkart.com/search?q=sheesham+wood+console+table |
| console | Ellementry | autumn dusk console table | 24,590 | - | - | - | https://www.ellementry.com/products/autumn-dusk-console-table-wdfra4145 |
| console | The Decor Kart | Golden Garden Console Table - Large | 14,760 | 24,600 | 40% | - | https://www.thedecorkart.com/products/golden-garden-console-table-large |
| tv unit | Woodsala | Modern Two-Tone TV Stand - White Top Entertainment Console with Storag | 28,999 | - | - | - | https://www.woodsala.com/products/modern-two-tone-tv-stand-white-top-entertainment-console-with-storage |
| tv unit | The Timber Guy | Low Height Wooden TV Cabinet Stand (3 drawers) !! | 12,999 | 19,999 | 35% | - | https://thetimberguy.com/products/low-height-wooden-tv-cabinet-stand-3-drawers |
| tv unit | Rajwada Furnish | Kanishka Solid Wood TV Units | 18,999 | - | - | - | https://www.rajwadafurnish.com/products/kanishka-solid-wood-tv-units-1 |
| tv unit | Shekhawati Crafts | Aarika Solid Wood TV Cabinet | 22,800 | - | - | - | https://www.shekhawaticrafts.com/products/aarika-tv-cabinet |
| tv unit | JL Home Decor | Hand‑Carved Solid Mango Wood TV Unit — Distressed White Finish, Lattic | 37,499 | 74,999 | 50% | - | https://jlhomedecorin.com/products/hand-carved-solid-mango-wood-tv-unit-distressed-white-finish-lattice-drawers-doors-170-60-37-cm |
| tv unit | Wooden Street | Natalia Sheesham Wood Tv Unit with Shelf Storage (Honey Finish) | 23,999 | 34,999 | 31% | 341 | https://www.woodenstreet.com/sheesham-wood-tv-units |
| tv unit | Urban Ladder | Nura Solid Wood TV Cabinet In Danish Walnut Finish | 27,999 | 54,999 | 49% | - | https://www.urbanladder.com/tv-units |
| tv unit | HomeTown | Opus TV Unit in White & Walnut Colour | 9,900 | 29,900 | 67% | - | https://www.hometown.in/products/opus-tv-unit |
| tv unit | Flipkart (marketplace sellers) | JeenWood Sheesham Wooden TV Unit for Living Room / TV C... | 14,330 | 30,998 | 54% | 2 | https://www.flipkart.com/search?q=sheesham+wood+tv+unit |
| shelf/rack | Woodsala | Versatile Wall Rack - Traditional Indian Design | 6,999 | - | - | - | https://www.woodsala.com/products/versatile-wall-rack-traditional-indian-design |
| shelf/rack | The Timber Guy | Wooden Shoe Rack cabinet stand cum Bench with coat hanger option ! | 15,999 | 24,614 | 35% | - | https://thetimberguy.com/products/wooden-shoe-rack-cabinet-stand-cum-bench-with-coat-hanger-option |
| shelf/rack | Rajwada Furnish | Acro Solid Wood Shoe Rack | 14,999 | - | - | - | https://www.rajwadafurnish.com/products/acro-solid-wood-shoe-rack |
| shelf/rack | Shekhawati Crafts | Nivar Bookshelve | 24,500 | - | - | - | https://www.shekhawaticrafts.com/products/nivar-bookshelve |
| shelf/rack | JL Home Decor | Sable Shelf Rack – Mango Wood & Cane Five-Tier Open Display Shelf, Nat | 29,999 | 36,000 | 17% | - | https://jlhomedecorin.com/products/sable-shelf-rack-mango-wood-cane-five-tier-open-display-shelf-natural-finish-161-3-x-38-1-x-151-8-cm |
| shelf/rack | Wooden Street | Vespera 24 Pair Wooden Shoe Cabinet (Gothic Grey Finish) | 13,499 | 33,999 | 60% | 297 | https://www.woodenstreet.com/product/vespera-24-pair-engineered-wood-shoe-rack-gothic-grey-finish |
| shelf/rack | Urban Ladder | Alex 21 Pair Shoe Cabinet in Classic Walnut Finish | 7,999 | 15,999 | 50% | - | https://www.urbanladder.com/shoe-racks |
| shelf/rack | HomeTown | Crony Engineered Wood Medium Book Shelf in Wenge Colour | 7,590 | 11,500 | 34% | - | https://www.hometown.in/products/crony-engineered-wood-medium-book-shelf-in-wenge-colour |
| shelf/rack | Nilkamal | Nilkamal Kubo 6 Tier Storage Shelf | 3,490 | 4,999 | 30% | - | https://www.nilkamalfurniture.com/products/nilkamal-kubo-6-tier-storage-shelf |
| shelf/rack | Flipkart (marketplace sellers) | CLANECRAFT Solid Sheesham Wood Book Shelf For Study Roo... | 7,919 | 17,999 | 56% | 75 | https://www.flipkart.com/search?q=sheesham+wood+bookshelf |
| shelf/rack | Ellementry | Cubette Wooden Wall Shelf | 5,550 | - | - | - | https://www.ellementry.com/products/cubette-wooden-wall-shelf-wddea4810 |
| shelf/rack | The Decor Kart | Crackle Glaze Carafe & Cup Set - Soft Mustard | 1,260 | - | - | - | https://www.thedecorkart.com/products/crackle-glaze-carafe-cup-set-soft-mustard |
| cabinet/sideboard | Woodsala | Artisan Wall Cabinet - Heritage Indian Storage | 16,999 | - | - | - | https://www.woodsala.com/products/artisan-wall-cabinet-heritage-indian-storage |
| cabinet/sideboard | The Timber Guy | Designer Solid Acacia wood sideboard cabinet with metal legs ! | 18,999 | 29,229 | 35% | - | https://thetimberguy.com/products/designer-solid-acacia-wood-sideboard-cabinet-with-metal-legs |
| cabinet/sideboard | Rajwada Furnish | Niware Solid Wood Tall Bar Cabinet | 22,999 | - | - | - | https://www.rajwadafurnish.com/products/niware-solid-wood-bar-units |
| cabinet/sideboard | Shekhawati Crafts | Gavin Solid Sheesham Wood Sideboard | 26,800 | - | - | - | https://www.shekhawaticrafts.com/products/gavin-sideboard |
| cabinet/sideboard | JL Home Decor | Carved Three Cabinet Door Grey Cabinet | 37,999 | 57,999 | 34% | - | https://jlhomedecorin.com/products/intricately-carved-three-cabinet-door-grey-cabinet |
| cabinet/sideboard | Wooden Street | Hazeline 3-Drawer Wooden Chest Of Drawers (Walnut Finish) | 32,999 | 77,999 | 58% | 148 | https://www.woodenstreet.com/chest-of-drawers |
| cabinet/sideboard | Urban Ladder | Ohio Chest of Drawer in Amber Walnut Finish | 28,999 | 40,899 | 29% | - | https://www.urbanladder.com/chest-of-drawers |
| cabinet/sideboard | HomeTown | Diago Dresser in Natural Teak Color | 21,590 | 75,600 | 71% | - | https://www.hometown.in/products/diago-dresser-in-natural-teak-color-copy |
| cabinet/sideboard | Nilkamal | Nilkamal Freedom Mini Shoe Cabinet 18 (Rust and Weathered Brown) | 6,310 | 8,200 | 23% | - | https://www.nilkamalfurniture.com/products/nilkamal-freedom-mini-shoe-cabinet-18-rust-and-weathered-brown-fmsc18-rst-wbn |
| cabinet/sideboard | Flipkart (marketplace sellers) | Only few left | 20,793 | 37,200 | 44% | - | https://www.flipkart.com/search?q=mango+wood+sideboard+cabinet |
| cabinet/sideboard | Ellementry | Old World double drawer cabinet | 38,800 | - | - | - | https://www.ellementry.com/products/old-world-double-drawer-cabinet-wdfna2790 |
| cabinet/sideboard | The Decor Kart | Obsidian Nest Display Cabinet | 13,560 | 22,600 | 40% | - | https://www.thedecorkart.com/products/obsidian-nest-display-cabinet |
| wardrobe | Woodsala | Bellarco Heritage European Luxury Wardrobe with Arched Open Shelving a | 37,999 | - | - | - | https://www.woodsala.com/products/bellarco-heritage-european-luxury-wardrobe-with-arched-open-shelving-and-elegant-drawer-storage |
| wardrobe | The Timber Guy | RAF Range Furniture - Wooden 2 door Cupboard / Wardrobe !! | 37,999 | 58,460 | 35% | - | https://thetimberguy.com/products/raf-range-furniture-wooden-2-door-cupboard-wardrobe |
| wardrobe | Rajwada Furnish | Anamika Sheesham Wood 2 Door Wardrobe | 26,999 | - | - | - | https://www.rajwadafurnish.com/products/anamika-sheesham-wood-1-door-wardrobe |
| wardrobe | Shekhawati Crafts | Mirra Wooden Wardrobe | 49,900 | - | - | - | https://www.shekhawaticrafts.com/products/mirra-wardrobe |
| wardrobe | JL Home Decor | Natural Solid Wood White HandCarved Wardrobe | 48,499 | 84,799 | 43% | - | https://jlhomedecorin.com/products/natural-solid-wood-white-hand-carved-wardrobe-bespoke-woodcrafts |
| wardrobe | Wooden Street | Cambrey 1 Door With 3 Drawers Wooden Wardrobe (Honey Finish) | 29,999 | 52,999 | 43% | 20 | https://www.woodenstreet.com/product/cambrey-1-door-with-3-drawers-wardrobe-honey-finish |
| wardrobe | Urban Ladder | Miller 4 Doors 4 Drawers Wardrobe With Mirror and Lock in Two Tone Fin | 39,999 | 56,599 | 29% | - | https://www.urbanladder.com/wardrobes |
| wardrobe | HomeTown | Cascade 3 Door Wardrobe Without Miror New | 31,920 | 60,000 | 47% | - | https://www.hometown.in/products/cascade-3door-wardrobe-without-miror-new |
| wardrobe | Nilkamal | Nilkamal Joyce 3 Door Wardrobe (Frosty White) | 15,190 | 41,900 | 64% | - | https://www.nilkamalfurniture.com/products/nilkamal-joyce-3-door-wardrobe-frosty-white |
| wardrobe | Flipkart (marketplace sellers) | Wooden Street Mahin Engineered Wood 5 Door Wardrobe Wit... | 22,799 | 49,998 | 54% | 193 | https://www.flipkart.com/search?q=sheesham+wood+wardrobe |
| desk | Woodsala | Secretary Desk with Drop-Front Writing Surface & Cubbyholes - Espresso | 32,899 | - | - | - | https://www.woodsala.com/products/secretary-desk-with-drop-front-writing-surface-cubbyholes-espresso |
| desk | The Timber Guy | Wooden Writing - laptop table - Desk  - study table design with Rattan | 13,999 | 21,537 | 35% | - | https://thetimberguy.com/products/wooden-writing-laptop-table-desk-study-table-design-with-rattan-cane-work |
| desk | Rajwada Furnish | Penza Solid Wood Study Tables | 19,999 | - | - | - | https://www.rajwadafurnish.com/products/penza-solid-wood-study-tables |
| desk | Shekhawati Crafts | Cairo Study Table | 18,550 | - | - | - | https://www.shekhawaticrafts.com/products/cairo-study-table |
| desk | JL Home Decor | Walnut Desks, Computer Desk Walnut, Walnut Wooden Desk | 21,000 | 29,000 | 28% | - | https://jlhomedecorin.com/products/walnut-desks-computer-desk-walnut-walnut-wooden-desk |
| desk | Urban Ladder | Larsson Study Table in Danish Walnut Finish | 11,999 | 21,499 | 44% | - | https://www.urbanladder.com/study-tables |
| desk | HomeTown | Learnix Study Table | 6,290 | 11,999 | 48% | - | https://www.hometown.in/products/learnix-study-table |
| desk | Nilkamal | Nilkamal Dalton Desk with Bookshelf (Teak) | 6,290 | 7,900 | 20% | - | https://www.nilkamalfurniture.com/products/nilkamal-dalton-desk-with-bookshelf-teak-mdaltonwbsfntk |
| desk | Flipkart (marketplace sellers) | Floresta Wud Solid Wood Study Table / Wooden Office Tab... | 11,860 | 25,999 | 54% | 485 | https://www.flipkart.com/search?q=sheesham+wood+study+table |
| desk | The Decor Kart | Aves 2-Bird Ambient Desk Lamp | 4,080 | 6,800 | 40% | - | https://www.thedecorkart.com/products/aves-2-bird-ambient-desk-lamp |
| bench/stool | Woodsala | Elegant Teal Upholstered Wooden Bench | 16,599 | - | - | - | https://www.woodsala.com/products/sfs |
| bench/stool | Rajwada Furnish | Moscow Solid Wood Traditional Bar Stools | 5,999 | - | - | - | https://www.rajwadafurnish.com/products/moscow-solid-wood-traditional-bar-stools |
| bench/stool | Shekhawati Crafts | Velora Classic Ottoman Bench | 13,100 | - | - | - | https://www.shekhawaticrafts.com/products/velora-classic-ottoman-bench |
| bench/stool | JL Home Decor | Manasa Bar Stool | 11,000 | 12,800 | 14% | - | https://jlhomedecorin.com/products/manasa-bar-stool |
| bench/stool | Wooden Street | Jade Bench With Storage (Cream Robins) | 14,999 | 27,999 | 46% | 190 | https://www.woodenstreet.com/benches |
| bench/stool | Urban Ladder | Latt Solid Wood Bench In Teak Finish | 9,499 | 15,499 | 39% | - | https://www.urbanladder.com/benches |
| bench/stool | HomeTown | Woodrow Sheesham Wood Rosewood Bar Stool in Honey Colour | 19,990 | 34,900 | 43% | - | https://www.hometown.in/products/woodrow-sheesham-wood-rosewood-bar-stool-in-honey-colour |
| bench/stool | Nilkamal | Nilkamal Floral Top Plastic Stool | 740 | 1,000 | 26% | - | https://www.nilkamalfurniture.com/products/nilkamal-plastic-stool-floral |
| bench/stool | Flipkart (marketplace sellers) | Only few left | 4,228 | 8,999 | 53% | - | https://www.flipkart.com/search?q=sheesham+wood+stool |
| bench/stool | Ellementry | Walnut Haze Upholstered Bench- 1 | 15,112 | 18,890 | 20% | - | https://www.ellementry.com/products/walnut-haze-upholstered-bench-1-wdfra3991 |
| bench/stool | The Decor Kart | Sky Blossom Garden Stool | 7,680 | 12,800 | 40% | - | https://www.thedecorkart.com/products/sky-blossom-garden-stool |
| mirror | Woodsala | Vintage Arched Wall Mirror with Distressed Carved Frame | 8,599 | - | - | - | https://www.woodsala.com/products/vintage-arched-wall-mirror-with-distressed-carved-frame |
| mirror | Shekhawati Crafts | Sasimo Mirror Frame | 5,200 | - | - | - | https://www.shekhawaticrafts.com/products/sasimo-mirror-frame |
| mirror | JL Home Decor | Hand Painted Vintage Wooden Window Door / Antique Indian Doors – Flora | 13,499 | 18,499 | 27% | - | https://jlhomedecorin.com/products/hand-painted-vintage-wooden-window-door-floral-grid-97x107cm |
| mirror | Wooden Street | Bohemian Set of 3 Mirror with Frame (Honey Finish) | 3,999 | 5,999 | 33% | 231 | https://www.woodenstreet.com/mirrors |
| mirror | Urban Ladder | Petra Metal Mirror in MS Antique Finish | 8,999 | 17,999 | 50% | - | https://www.urbanladder.com/mirrors |
| mirror | HomeTown | Molly Engineered Wood 4 Door Wardrobe with Mirror in Walnut Finish | 25,900 | 35,300 | 27% | - | https://www.hometown.in/products/molly-engineered-wood-four-door-wardrobe-with-mirror-in-walnut-finish |
| mirror | Nilkamal | Nilkamal Freedom Big 1 (FB1M) Plastic Storage Cabinet with Mirror (Dee | 15,220 | 19,500 | 22% | - | https://www.nilkamalfurniture.com/products/nilkamal-freedom-big-1-fb1m-plastic-storage-cabinet-with-mirror-deep-blue-grey-fb1mdbl-gry |
| mirror | Flipkart (marketplace sellers) | Kraftaura Wooden Wall Hanging Art Decorative Home Plaqu... | 329 | 899 | 63% | 6 | https://www.flipkart.com/search?q=wooden+wall+mirror |
| mirror | Ellementry | Wooden Wall Shelf With Mirror | 7,217 | 8,490 | 15% | - | https://www.ellementry.com/products/wooden-wall-shelf-with-mirror-wddea3303 |
| mirror | The Decor Kart | Sunburst Illuminated Mirror Wall Light - Yellow | 4,800 | 6,400 | 25% | - | https://www.thedecorkart.com/products/sunburst-illuminated-mirror-wall-light |
| mirror | Tjori | Blue Color Raw Silk Mirror Work Blouse | 459 | 1,399 | 67% | - | https://tjori.com/products/blue-color-raw-silk-mirror-work-blouse-mk334-26 |
| wall décor | Woodsala | Traditional Haveli Double Door Wooden Wall Panel - Rajasthani Heritage | 4,999 | - | - | - | https://www.woodsala.com/products/traditional-haveli-double-door-wooden-wall-panel-rajasthani-heritage-design |
| wall décor | JL Home Decor | Ancestral Frame Door – Deeply Chiseled Geometric/Floral Hand-Carved Fr | 60,000 | 65,000 | 8% | - | https://jlhomedecorin.com/products/ancestral-frame-door-deeply-chiseled-geometric-floral-hand-carved-frame-killi-horizontal-paneled-leaves-with-iron-patis-rivets-150-cm-200-cm-15-cm |
| wall décor | Wooden Street | Miller Cycle Shaped Analog Metal Wall Clock | 2,799 | 3,969 | 29% | 107 | https://www.woodenstreet.com/wall-decor |
| wall décor | Urban Ladder | The Castle Decor 3D Green Flower Tree Wall Art Set of 5 27x48 Inch | 2,199 | 5,499 | 60% | - | https://www.urbanladder.com/wall-decor |
| wall décor | HomeTown | Vedas W Cora Ginko Leaf Wall Decor | 4,699 | - | - | - | https://www.hometown.in/products/vedas-w-cora-ginko-leaf-wall-decor |
| wall décor | Ellementry | Aria Photo Frame Large | 1,250 | - | - | - | https://www.ellementry.com/products/aria-photo-frame-large-wddea3330 |
| wall décor | The Decor Kart | Blue & White Framed Wall Art - 12"x12" | 4,140 | 6,900 | 40% | - | https://www.thedecorkart.com/products/blue-white-40 |
| wall décor | Tjori | Florentina Double Macrame Wall Hanging | 869 | 2,999 | 71% | - | https://tjori.com/products/florentina-double-macrame-wall-hanging-home2025 |
| jaali/panel | Woodsala | Solid wide Jali temple with 2 Drawers & 2 Tray | 18,999 | - | - | - | https://www.woodsala.com/products/solid-teak-wide-jali-temple-with-2-drawers-2-tray |
| jaali/panel | The Timber Guy | Sunrise Indian Jali Furniture - Wooden Dining Set ( 1 Square table ,4  | 24,999 | 38,460 | 35% | - | https://thetimberguy.com/products/sunrise-indian-jali-furniture-wooden-dining-set-1-square-table-4-chairs |
| jaali/panel | Shekhawati Crafts | Shekhawati Iron Jali Bedside Table | 6,300 | 7,300 | 14% | - | https://www.shekhawaticrafts.com/products/shekhawati-iron-jali-bedside |
| jaali/panel | JL Home Decor | Distressed Hand Carved Wooden Jali Wall Panel / Wood Wall Decor – Arch | 21,499 | 27,999 | 23% | - | https://jlhomedecorin.com/products/distressed-hand-carved-wooden-jali-wall-panel-wood-wall-decor-arched-floral-design |
| jaali/panel | Flipkart (marketplace sellers) | 80% off | 225 | 999 | 77% | - | https://www.flipkart.com/search?q=wooden+jaali+wall+panel |
| jaali/panel | Ellementry | Izmil Carved Wooden Wall Panel 2 | 9,350 | - | - | - | https://www.ellementry.com/products/izmil-carved-wooden-wall-panel-2-wddea3356 |
| kitchen/tray | Woodsala | Quaint Wooden Stripe Tray Set - Set of 3 | 4,199 | - | - | - | https://www.woodsala.com/products/quaint-wooden-stripe-tray-set-set-of-3 |
| kitchen/tray | JL Home Decor | Brown Wood Matt Tray (L- 28in, W- 18in) | 2,999 | 7,499 | 60% | - | https://jlhomedecorin.com/products/brown-wood-matt-tray-l-28in-w-18in |
| kitchen/tray | Wooden Street | Add To Cart | 1,429 | 2,125 | 33% | - | https://www.woodenstreet.com/serving-trays |
| kitchen/tray | Urban Ladder | Tufted Ash Grey Tasseled Rug | 8,099 | - | - | - | https://www.urbanladder.com/trays |
| kitchen/tray | HomeTown | De Massion Stones Serving Ware Jet Black Enamle - Napkin Holder Silver | 2,065 | - | - | - | https://www.hometown.in/products/stones-serving-ware-jet-black-enamle-napkin-holder-silver |
| kitchen/tray | Flipkart (marketplace sellers) | Only few left | 298 | 750 | 60% | 117 | https://www.flipkart.com/search?q=wooden+serving+tray |
| kitchen/tray | Ellementry | Aamay Nut Bowl - Small | 1,890 | - | - | - | https://www.ellementry.com/products/aamay-nut-bowl-small-gsswa3289 |
| kitchen/tray | The Decor Kart | Blossom Charm Pasta Bowl - Set Of 4 Style - 2 | 1,476 | 2,460 | 40% | - | https://www.thedecorkart.com/products/blossom-charm-pasta-bowl-set-of-4-style-2 |
| kitchen/tray | Tjori | Naija Banjara Kurta | 579 | 2,799 | 79% | - | https://tjori.com/products/naija-banjara-kurta |
| planter | JL Home Decor | Fake Window Wall Decor | 3,299 | 7,000 | 53% | - | https://jlhomedecorin.com/products/fake-window-wall-decor |
| planter | Wooden Street | Bloomify Ceramic Pot With Artificial Flowers (White) | 409 | 579 | 29% | - | https://www.woodenstreet.com/planters |
| planter | Urban Ladder | Pot Stand Set Of 4 In Black Colour | 1,499 | 1,999 | 25% | - | https://www.urbanladder.com/planters |
| planter | Flipkart (marketplace sellers) | Only few left | 335 | 999 | 66% | - | https://www.flipkart.com/search?q=wooden+planter+stand |
| planter | Ellementry | Amber Love Ceramic Planter - curved | 1,550 | - | - | - | https://www.ellementry.com/products/amber-love-ceramic-planter-curved-swdea4124 |
| planter | The Decor Kart | Butterfly Cup & Saucer Planter | 3,800 | - | - | - | https://www.thedecorkart.com/products/butterfly-cup-saucer-planter |
| storage box | Woodsala | Simple Wooden Jewellery Box | 3,899 | - | - | - | https://www.woodsala.com/products/simple-wooden-jewellery-box |
| storage box | Rajwada Furnish | Moscow Indian Rosewood  Storage Beds | 36,999 | - | - | - | https://www.rajwadafurnish.com/products/moscow-indian-rosewood-queen-size-storage-beds |
| storage box | JL Home Decor | Beachcomber Trunks / Set of 3 Coastal Storage Trunks with White Shell  | 24,999 | 30,000 | 17% | - | https://jlhomedecorin.com/products/beachcomber-trunks-set-of-3-coastal-storage-trunks-with-white-shell-finish-54-0-x-79-4-x-47-6-cm |
| storage box | HomeTown | De Massion Gilded Hive Tissue Box | 1,120 | - | - | - | https://www.hometown.in/products/gilded-hive-tissue-box |
| storage box | Nilkamal | Nilkamal 50 Litre Multipurpose Storage Box with Lid (Blue and Red) | 1,359 | 1,600 | 15% | - | https://www.nilkamalfurniture.com/products/nilkamal-storage-box-50-ltr |
| storage box | Flipkart (marketplace sellers) | Only 1 left | 422 | 1,299 | 68% | - | https://www.flipkart.com/search?q=wooden+storage+box |
| storage box | Ellementry | Charcoal Brown Twine Wire Bread Box with Fabric and Lid | 2,390 | - | - | - | https://www.ellementry.com/products/charcoal-brown-twine-wire-bread-box-with-fabric-and-lid-mekea3273 |
| storage box | The Decor Kart | Star Bloom Tissue Holder | 2,860 | - | - | - | https://www.thedecorkart.com/products/star-bloom-tissue-holder |
| storage box | Tjori | Sunflower Yellow Brocade Box Clutchwith Sling (8 X 2 X 4.5) | 1,519 | 1,874 | 19% | - | https://tjori.com/products/sunflower-yellow-brocade-box-clutch-8-x-2-x-45 |
| toy/game | HomeTown | De Massion Chess Rook Over-size | 1,725 | - | - | - | https://www.hometown.in/products/chess-rook-over-size-2 |
| toy/game | Flipkart (marketplace sellers) | Big Billion Days Price | 333 | 549 | 39% | 88 | https://www.flipkart.com/search?q=wooden+toy |
| toy/game | The Decor Kart | Equestrian Chess Head Decorative Knight Figurine | 5,400 | - | - | - | https://www.thedecorkart.com/products/equestrian-chess-head-decorative-knight-figurine |
| temple/mandir | Woodsala | Traditional Temple Mandir Unit with Ornamental Arch Design | 21,899 | - | - | - | https://www.woodsala.com/products/traditional-temple-mandir-unit-with-ornamental-arch-design |
| temple/mandir | JL Home Decor | Rajasthani Heritage Carved Archway Wall Altar - Jodhpur Artisan Dark W | 13,499 | 21,499 | 37% | - | https://jlhomedecorin.com/products/rajasthani-heritage-carved-archway-wall-altar-jodhpur-artisan-dark-wood-display-temple-style |
| temple/mandir | Flipkart (marketplace sellers) | Gojeeva Engineered Wooden LED Temple Handcrafted Design... | 494 | 1,999 | 75% | 916 | https://www.flipkart.com/search?q=wooden+temple+for+home |
| temple/mandir | The Decor Kart | Trellis Medallion Ceramic Temple Jar | 8,800 | - | - | - | https://www.thedecorkart.com/products/trellis-medallion-ceramic-temple-jar |
| temple/mandir | Tjori | Vedhika Temple Heritage Kemp Necklace Set with Pearls | 1,037 | 1,799 | 42% | - | https://tjori.com/products/vedhika-temple-heritage-kemp-necklace-set-with-pearls-sgcm167-01 |
| swing | Woodsala | Vintage Style Wooden Peacock Premium Tiled Swing for Home | 25,399 | - | - | - | https://www.woodsala.com/products/vintage-style-wooden-peacock-premium-tiled-swing-for-home |
| swing | Wooden Street | Boho Wooden Swing Chair (Honey Finish) | 34,999 | 71,999 | 51% | 89 | https://www.woodenstreet.com/jhula |
| swing | Flipkart (marketplace sellers) | Swingzy Round Hanging Swing for Adults/Swing for Indoor... | 896 | 5,999 | 85% | 181 | https://www.flipkart.com/search?q=wooden+jhula+swing |