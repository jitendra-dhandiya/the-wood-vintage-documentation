# Unit-economics model (template + worked examples)

Date: 2026-09-25. Purpose: answer "is a price ~30% below the brand tier still profitable for a Jodhpur factory-direct seller?" and give the owner a template to replace our guesses with real numbers.
Prices come from [../competitor-research/india-market-price-benchmark.md](../competitor-research/india-market-price-benchmark.md). **Every cost input below is an ASSUMPTION unless tagged otherwise - the owner's real numbers replace them.**
Tags: VERIFIED (source read 2026-09-25), ESTIMATE (blog/marketplace figure, not independently verified), ASSUMPTION (our placeholder).

## 1. Executive summary

1. **The answer depends mostly on the price of a cubic foot of timber and on CAC, not on the "30%".** Same product, same price: a queen bed goes from **+15% contribution (timber INR 900/cft) to -1% (INR 1,500) to -20% (INR 2,200)**; the 6-seater dining table from 32% to 21% to 7%.
2. **At the ladder prices in the benchmark (about -30% vs the brand-tier selling price):**
   - Healthy or workable (>= 15% after CAC at INR 1,500/cft timber): **jaali panel (24.5%), 6-seater dining table (20.8%), coffee table (15.6%), carved mandir (15.0%)**.
   - Thin or negative: **queen bed (-1.0%), 5 ft TV unit (-0.5%), bedside table (-14.9%), carved mirror (3.7%), serving tray (2.1%)**. They become viable only at timber near INR 900/cft, with organic/WhatsApp customer acquisition (CAC ~INR 500), or inside combos.
3. **Maximum all-in ex-factory cost** (wood + labour + finish + hardware) for a 20% contribution margin after CAC is **~42-50% of the GST-exclusive price for beds, dining tables, TV units, coffee tables, mandir units and jaali panels; 28-33% for bedside tables and carved mirrors; 20% for a serving tray** (table in section 5). This is the number to check against the workshop's real costing: if a queen bed costs more than ~INR 14,000 to make, it does not clear 20% at INR 34,999.
4. **Freight is a first-order cost for beds, dining tables and TV units** (INR 1,100-2,420 per order in our assumptions, in the INR 1,700-4,300 palletised range quoted by freight blogs, ESTIMATE). Charging freight or setting a pincode-based bulky-goods rule (decision 0015) matters more than any discount.
5. **US pilot:** shipping single small décor by express from India loses money at USD 25-39 retail (section 6). Use B2B/consolidated freight, or price parcels at about USD 50+ (hand-painted/personalised).
6. The "30% cost advantage" is **not proven**: it exists versus retailers with showrooms and marketing (Wooden Street's median list discount is 50% and its 2020 reported EBITDA margin about 5%, ESTIMATE Inc42), but **not versus other factories** (Flipkart factory sellers price sheesham at 35-55% of the brand tier).

**Confidence:** medium on structure and orders of magnitude; low on any absolute margin because the cost inputs are placeholders.

## 2. Model structure (one product, one order)

All prices GST-inclusive as shown to the customer (B2C India). Let P = selling price.

```
Coupon/combo allowance      = coupon% x P / (1+GST)                     # discounts given away (default 5%)
Net revenue N               = P/(1+GST) - coupon allowance             # GST is a pass-through, not revenue
Ex-factory cost F           = timber_cft x (1+wastage) x timber_rate + labour + finish + hardware
Packaging                   = fixed_pack + 3% x F                       # corner guards, foam, carton, wrap
Freight (forward)           = max(min_freight, weight_kg x rate_per_kg)  # or volumetric weight, whichever is higher
Payment cost                = prepaid_share x 2.36% x P  +  (1-prepaid_share) x COD_fee
RTO/return allowance        = rto_rate x (2 x freight + packaging + 10% x F)   # forward + return freight + repack + re-polish
Damage allowance            = damage_rate x (F + freight)               # replacement parts/pieces
Warranty allowance          = warranty_rate x N
Contribution before CAC     = N - F - packaging - freight - payment - RTO - damage - warranty
CAC                         = ad spend / orders  (blended; organic orders pull it down)
Contribution after CAC      = Contribution before CAC - CAC
Margin %                    = Contribution after CAC / N
```
Overheads (rent, salaries beyond factory labour, software, owner's time) are NOT in this contribution margin; a business needs roughly 10-15 points left after CAC to cover them (ASSUMPTION). Input GST credit on timber/hardware is ignored (conservative). Not modelled: interest on advance payments, inventory carrying cost.

## 3. Inputs, with sources and tags

| Input | Value used | Tag | Source / note |
|---|---|---|---|
| GST rate, furniture (HSN 9403) | 18% (price is GST-inclusive; net = P/1.18) | ESTIMATE | https://razorpay.com/learn/gst-rate-on-furniture/ , https://tallysolutions.com/gst/hsn-code-9403-product-classification-gst-rate-business-filing-guide/ (2026). Wooden décor HSN 4420 quoted as 5% and as 12% by different sites; kitchenware 4419 5% -> **owner's CA must confirm**; the demo catalogue (0028) uses 12% for décor |
| Payment gateway | 2% + 18% GST on fee = 2.36% of P on prepaid orders | VERIFIED | https://razorpay.com/blog/razorpay-payment-gateway-pricing-explained/ (Razorpay 2026 pricing). Actual contract may differ (Cashfree also configured) |
| COD handling fee | INR 60 per COD order | ASSUMPTION | courier/COD fee not verified; ask the courier |
| Prepaid share | 70% (30-50% advance on custom + balance prepaid/COD) | ASSUMPTION | policy choice |
| COD share of Indian e-commerce | ~58-65% of orders; COD 76-83% of RTO volume | ESTIMATE | https://trackvid.in/blogs/how-to-reduce-rto-in-ecommerce.html , https://codcourierservice.com/blog/what-is-rto-in-ecommerce/ |
| RTO rate | Base 5% (made-to-order with advance); stress 15% | ASSUMPTION | market ESTIMATE: furniture RTO 15-20%; prepaid 4-8%, COD 28-40% (same sources); furniture return rate 15-23% (icarry blog in in.md). Stress at 15% costs about 2-3 points of margin on heavy items |
| RTO cost per order | INR 150-300 typical for parcels | ESTIMATE | same sources; bulky items cost far more (2 x freight in our formula) |
| Damage allowance | 3% of (F + freight) | ASSUMPTION | in.md cites ~7.6% of pieces arriving scuffed (ESTIMATE): packaging investment reduces this |
| Warranty allowance | 1.5% of N | ASSUMPTION | 1-year warranty like Woodsala |
| Coupon/combo allowance | 5% of price | ASSUMPTION | seed coupons WELCOME10 (10%), FREESHIP, HANDMADE500 exist (0028); combos 0037 |
| Timber (sheesham) rate | INR 900 / 1,500 / 2,200 per cubic foot (scenarios) | ESTIMATE | IndiaMART/TradeIndia listings 2026: INR 600-2,500/cft depending on grade/cut (e.g. INR 1,500/cft 1 Jul 2026, 2,200/cft 24 Aug 2026, wholesale from INR 607) https://dir.indiamart.com/impcat/sheesham-wood.html . **Owner: your real purchase price** |
| Wastage | 40% of finished volume | ASSUMPTION | |
| Finished-wood volume, labour, finish, hardware per product | see section 4 table A | ASSUMPTION | volumes back-derived from typical dimensions; density 22 kg/cft assumed |
| Freight rate | INR 20-25/kg bulky; INR 60/kg for a 1-2 kg parcel; minimum per order shown in table A | ESTIMATE | freight blogs quote INR 50-150/kg or INR 1,700-4,300 per palletised furniture shipment; Shiprocket Cargo from INR 6/kg; Delhivery accepts up to 300 kg https://www.shipmozo.com/blog/best-courier-service-for-heavy-bulky-products . Local Jodhpur transport INR 1,700-3,100 (in.md). **Owner: get quotes for Jodhpur -> Delhi NCR, Mumbai, Bengaluru, Hyderabad** |
| CAC (blended) | INR 3,000 bed, 2,500 dining, 2,200 TV, 1,800 coffee, 1,200 bedside, 2,000 mandir, 900 mirror/jaali, 450 tray | ASSUMPTION | reasoning: India Meta CPM is USD 1.36-2.60 (about INR 120-230) https://lebesgue.io/facebook-ads/facebook-cpm-by-country (ESTIMATE); at a 1% click-through rate that is about INR 12-23 per click; at 0.5-1% site conversion on high-ticket custom furniture that is INR 1,200-4,600 per order (bot/low-quality traffic in India pushes this up); small home-décor converts better. No furniture-specific CPC found (gap) |

## 4. Worked examples (nine products)

Timber INR 1,500/cft, base RTO 5%, prepaid 70%, coupon 5%. Prices are the launch bands from the benchmark (section 5.2), **not** the current demo-catalogue prices.

### Table A - inputs per product (ASSUMPTIONS to replace)
| # | Product (solid sheesham unless noted) | Price INR (GST incl.) | Wood cft finished | Labour + carving INR | Finish + hardware INR | Ship weight kg | Pack fixed INR | Freight rate INR/kg | Min freight INR | CAC INR |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Queen sheesham bed (no storage) | 34,999 | 5.0 | 6,500 | 2,500 | 110 | 900 | 22 | 1,800 | 3,000 |
| 2 | 6-seater sheesham dining table (no chairs) | 29,999 | 3.1 | 4,500 | 1,500 | 70 | 700 | 20 | 1,500 | 2,500 |
| 3 | 5 ft sheesham TV unit | 17,999 | 2.5 | 3,000 | 1,200 | 55 | 500 | 20 | 900 | 2,200 |
| 4 | Sheesham coffee table 90x50 | 11,999 | 1.0 | 1,800 | 800 | 22 | 300 | 20 | 600 | 1,800 |
| 5 | Sheesham bedside table | 5,499 | 0.6 | 1,000 | 500 | 13 | 250 | 20 | 450 | 1,200 |
| 6 | Carved-frame wall mirror 60x90 | 4,999 | 0.25 | 900 | 600 | 6 | 250 | 25 | 350 | 900 |
| 7 | Carved solid mandir 2.5 ft | 15,999 | 1.2 | 3,500 | 800 | 28 | 400 | 20 | 700 | 2,000 |
| 8 | Jaali wall panel 60x90 | 6,999 | 0.3 | 1,200 | 500 | 7 | 250 | 25 | 350 | 900 |
| 9 | Sheesham serving tray (2 kg pack) | 1,499 | 0.04 | 250 | 120 | 1.2 | 60 | 60 | 110 | 450 |
### Table B - line-by-line result (INR per order)
| # | Product | Net revenue (ex GST, after 5% coupon) | Factory cost | of which timber | Packing | Freight | Gateway/COD | RTO allowance | Damage allowance | Warranty allowance | Contribution before CAC | CAC | Contribution after CAC | % of net |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Queen sheesham bed (no storage) | 28,177 | 19,500 | 10,500 | 1,485 | 2,420 | 567 | 414 | 658 | 423 | 2,711 (10%) | 3,000 | -289 | -1.0% |
| 2 | 6-seater sheesham dining table (no chairs) | 24,152 | 12,510 | 6,510 | 1,075 | 1,500 | 489 | 266 | 420 | 362 | 7,529 (31%) | 2,500 | 5,029 | 20.8% |
| 3 | 5 ft sheesham TV unit | 14,491 | 9,450 | 5,250 | 784 | 1,100 | 300 | 196 | 316 | 217 | 2,126 (15%) | 2,200 | -74 | -0.5% |
| 4 | Sheesham coffee table 90x50 | 9,660 | 4,700 | 2,100 | 441 | 600 | 206 | 106 | 159 | 145 | 3,303 (34%) | 1,800 | 1,503 | 15.6% |
| 5 | Sheesham bedside table | 4,427 | 2,760 | 1,260 | 333 | 450 | 104 | 75 | 96 | 66 | 542 (12%) | 1,200 | -658 | -14.9% |
| 6 | Carved-frame wall mirror 60x90 | 4,025 | 2,025 | 525 | 311 | 350 | 96 | 61 | 71 | 60 | 1,050 (26%) | 900 | 150 | 3.7% |
| 7 | Carved solid mandir 2.5 ft | 12,881 | 6,820 | 2,520 | 605 | 700 | 269 | 134 | 226 | 193 | 3,934 (31%) | 2,000 | 1,934 | 15.0% |
| 8 | Jaali wall panel 60x90 | 5,635 | 2,330 | 630 | 320 | 350 | 128 | 63 | 80 | 85 | 2,279 (40%) | 900 | 1,379 | 24.5% |
| 9 | Sheesham serving tray (2 kg pack) | 1,207 | 454 | 84 | 74 | 110 | 42 | 17 | 17 | 18 | 476 (39%) | 450 | 26 | 2.1% |
Reading example 4 (coffee table): customer pays INR 11,999 -> GST and a 5% coupon leave INR 9,660 net; making it costs INR 4,700 (timber INR 2,100); packing, freight and payment take INR 1,247; risk allowances INR 410; that leaves INR 3,303 (34%) before marketing and INR 1,503 (15.6%) after a INR 1,800 CAC.

### Table C - sensitivity: contribution % of net (INR per order in brackets)
| # | Product | Timber INR 900/cft | INR 1,500/cft | INR 2,200/cft | INR 1,500 with organic CAC INR 500 |
|---|---|---|---|---|---|
| 1 | Queen sheesham bed (no storage) | 15% (4,190) | -1% (-289) | -20% (-5,515) | 8% (2,211) |
| 2 | 6-seater sheesham dining table (no chairs) | 32% (7,806) | 21% (5,029) | 7% (1,789) | 29% (7,029) |
| 3 | 5 ft sheesham TV unit | 15% (2,166) | -1% (-74) | -19% (-2,686) | 11% (1,626) |
| 4 | Sheesham coffee table 90x50 | 25% (2,399) | 16% (1,503) | 5% (458) | 29% (2,803) |
| 5 | Sheesham bedside table | -3% (-121) | -15% (-658) | -29% (-1,285) | 1% (42) |
| 6 | Carved-frame wall mirror 60x90 | 9% (374) | 4% (150) | -3% (-111) | 14% (550) |
| 7 | Carved solid mandir 2.5 ft | 23% (3,009) | 15% (1,934) | 5% (680) | 27% (3,434) |
| 8 | Jaali wall panel 60x90 | 29% (1,648) | 24% (1,379) | 19% (1,066) | 32% (1,779) |
| 9 | Sheesham serving tray (2 kg pack) | 5% (62) | 2% (26) | -1% (-16) | -2% (-24) |
Stress test (not in the table): RTO at 15% instead of 5% lowers margin by about 3 points on the queen bed and 2 points on the coffee table.

## 5. What the owner's cost must be (break-even view)

For each product: the **highest all-in ex-factory cost** (timber + labour + finish + hardware) that still leaves 20% (or 10%) contribution after CAC at the launch price. If the workshop's real cost is below the column, the product is a "yes" at that price.
| # | Product | Price | Assumed all-in ex-factory cost (timber 1,500) | Max cost for 20% margin (CAC as listed) | Max cost for 20% margin (CAC INR 500) | Max cost for 10% margin (CAC as listed) | Max cost as % of GST-ex price (20%, CAC listed) |
|---|---|---|---|---|---|---|---|
| 1 | Queen sheesham bed (no storage) | 34,999 | 19,500 | 13,945 | 16,289 | 16,587 | 47% |
| 2 | 6-seater sheesham dining table (no chairs) | 29,999 | 12,510 | 12,696 | 14,571 | 14,961 | 50% |
| 3 | 5 ft sheesham TV unit | 17,999 | 9,450 | 6,664 | 8,258 | 8,022 | 44% |
| 4 | Sheesham coffee table 90x50 | 11,999 | 4,700 | 4,298 | 5,517 | 5,204 | 42% |
| 5 | Sheesham bedside table | 5,499 | 2,760 | 1,313 | 1,969 | 1,728 | 28% |
| 6 | Carved-frame wall mirror 60x90 | 4,999 | 2,025 | 1,411 | 1,786 | 1,788 | 33% |
| 7 | Carved solid mandir 2.5 ft | 15,999 | 6,820 | 6,218 | 7,624 | 7,425 | 46% |
| 8 | Jaali wall panel 60x90 | 6,999 | 2,330 | 2,567 | 2,942 | 3,095 | 43% |
| 9 | Sheesham serving tray (2 kg pack) | 1,499 | 454 | 252 | 205 | 365 | 20% |
How to use: ask the carpenter team for the real cost of the products in this table; compare with columns 5-7. **If cost > column 7 (10% margin), do not launch the product at this price**: raise the price toward Woodsala parity or drop it from the first 100 orders.

### 5.1 What the "30% below market" claim implies
- If you sell at 0.7 x brand-tier selling price and cost is 40% of the GST-exclusive price, contribution before CAC is roughly 30-35% (coffee table row); if cost is 55% it is single digits. So "30% cheaper than Wooden Street/Urban Ladder" is credible only if your all-in cost is **below ~40-45% of your selling price net of GST** on furniture, and lower on small items.
- Versus Woodsala the target price is 0-30% lower on coffee tables, side tables, consoles and TV units, but **higher than Flipkart factory sellers on everything** - you are not the price floor and must not claim to be.

## 6. USA pilot micro-model (small décor, under 10 kg, express courier)

> **Superseded 2026-09-25** by [export-b2c-logistics-and-landed-cost.md](export-b2c-logistics-and-landed-cost.md) (DHL rate card, sea-freight + US 3PL model, 12 SKUs). Kept for history; its conclusion that single-piece courier fails is confirmed and extended to all furniture.

All ASSUMPTION/ESTIMATE, illustrative. FX INR 88 per USD (ASSUMPTION - owner to update). Retail anchor: World Market India-made mango-wood tray USD 24.99 (medium) - 34.99 (large) (VERIFIED, https://www.worldmarket.com/p/mango-wood-footed-serving-tray-113191.html).

**Case A - Etsy DTC, hand-painted mango-wood tray set of 2, 2.5 kg chargeable, retail USD 39, seller pays shipping (free-shipping expectation USD 35+):**

| Line | USD | Source/tag |
|---|---|---|
| Ex-factory (2 trays, INR 1,000) | 11.4 | ASSUMPTION (INR 454 each from section 4 model, plus painting) |
| Export packing (INR 150) | 1.7 | ASSUMPTION |
| Etsy fees: USD 0.20 listing + 6.5% transaction (2.54) + 3% + USD 0.25 processing (1.42) | 4.16 | ESTIMATE https://printify.com/blog/how-much-does-etsy-take-per-sale/ ; offsite ads +12-15% if triggered (not included) |
| Courier from India, 2.5 kg x INR 918-1,118/kg (us.md, DHL) | 26.1-31.8 | ESTIMATE (us.md) |
| US duty: Section 301 +10% and a base rate (unknown, assume 3-5%) on the declared value; de minimis suspended (us.md) | 2.6-5.5 | ASSUMPTION + FAST-changing |
| **Total cost** | **~46-55** | |
| **Result at USD 39** | **about -7 to -16 per set** | |

Break-even retail is about **USD 47-56 per shipped parcel**. Only hand-painted, inlay or personalised pieces (Etsy personalised boards USD 45-120, blog ESTIMATE) can carry that; plain trays at USD 25-35 cannot.

**Case B - B2B sample/container route (illustrative, ESTIMATE):** FOB price to a US importer about USD 7-8 per tray (cost USD 5.7 plus ~30%); LCL sea freight USD 70-150 per CBM (us.md) with about 10 trays per 0.06 CBM carton = USD 0.4-0.9 per tray; duty about 13-16% -> landed about USD 9-10 per tray; the importer's retail anchor is USD 25-35. That works economically, but needs an importer, a customs broker, ISF/Lacey Act paperwork and 28-42 days transit (broker/3PL fees not researched - gap).

**Conclusion:** first US step = one B2B sample shipment or a marketplace consolidation programme (Amazon Global Selling referral fees generally 8-15%, ESTIMATE https://www.worldwidexporter.com/blog/amazon-global-selling-india-2026-guide), not single-piece express to consumers.

## 7. Template to copy into a spreadsheet

Columns (one row per SKU/size/finish). Formulas in Google-Sheets style; replace the named inputs on a separate sheet.

```
A sku | B price_incl_gst | C timber_cft | D timber_rate | E waste | F labour | G finish_hw | H weight_kg | I pack_fixed | J freight_rate | K min_freight | L cac
M net        = B/(1+GST) - B*coupon/(1+GST)
N factory    = C*(1+E)*D + F + G
O packing    = I + 0.03*N
P freight    = MAX(K, H*J)
Q payment    = prepaid*0.0236*B*(1-coupon) + (1-prepaid)*cod_fee
R rto        = rto_rate*(2*P + O + 0.10*N)
S damage     = dmg_rate*(N + P)
T warranty   = warr_rate*M
U contrib_pre= M-N-O-P-Q-R-S-T
V contrib    = U-L
W margin_pct = V/M
```
Named inputs: GST 0.18; coupon 0.05; prepaid 0.7; cod_fee 60; rto_rate 0.05; dmg_rate 0.03; warr_rate 0.015. Add a US sheet with FX, Etsy fee lines and courier per kg.

## 8. Owner must replace these assumptions (priority order)
1. **Real ex-factory cost per SKU** (timber, labour, carving, polish, hardware) - the single biggest driver; or at least: timber INR/cft purchased, timber cft per product, wastage.
2. **Freight quotes** Jodhpur -> Delhi NCR/Mumbai/Bengaluru/Hyderabad for 7 kg, 25 kg, 70 kg and 110 kg crated items; whether you will charge freight or bake it in.
3. **Packaging cost per product** (corner guards, foam, cartons, crate) and damage history from any past shipments.
4. **CAC**: first 2-4 weeks of Meta/Instagram/WhatsApp spend versus orders; share of organic/referral orders.
5. **Payment mix and policy**: advance % on custom orders, COD allowed or not, courier COD fee, actual gateway contract.
6. **GST rate per product family** (CA): 18% furniture vs 5%/12% décor and kitchenware.
7. **Warranty/repair cost expectation** and whether you will give free repair for 1 year.
8. **Target margin**: what contribution after CAC do you need to fund the business (we used 15-20% as "healthy", 10% as minimum, ASSUMPTION).
9. FX rate and export costing if you continue with the US/UAE.

## 9. Data gaps
No real cost data; no furniture-specific Meta CPC; no verified courier COD fee; no verified Jodhpur freight rates; GST on décor conflicting; US duty base rates and customs-broker costs not researched.
