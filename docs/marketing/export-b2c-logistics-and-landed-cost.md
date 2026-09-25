# Export B2C logistics and landed-cost model (India to US customers, DHL as the carrier)

Date: 2026-09-25. Scope: the USA, B2C, shipped from Jodhpur by DHL. Development is on hold; this is a research/strategy document.
Supersedes the US pilot micro-model in [../marketing/unit-economics-model.md](unit-economics-model.md) section 6 (that model priced single-piece courier; this one prices the real routes). Market context: [../countries/market-selection.md](../countries/market-selection.md) (Revision 2026-09-25), [../countries/us.md](../countries/us.md). Prices to beat: [../competitor-research/us-b2c-price-benchmark.md](../competitor-research/us-b2c-price-benchmark.md).

Evidence tags: **VERIFIED** (read in the cited source on 2026-09-25), **ESTIMATE** (blog/vendor figure, or our arithmetic on a verified base), **ASSUMPTION** (our placeholder; the owner must replace). Facts that change fast are marked **(FAST)**. INR to USD = **88** (ASSUMPTION; the owner sets the real rate).

## 1. Verdict in ten lines

1. **DHL Express door-to-door (route a) is not viable for any of the 12 furniture/décor SKUs.** Even at a negotiated rate assumed at 50% of DHL's published rack rate, shipping alone costs 59% to 407% of the US retail price, and DDP admin fees add about USD 70 per parcel. It is a tool for samples, replacement parts and gifts of 2 kg or less priced at USD 250 or more.
2. **The viable model is route (b)/(c): consolidate in India, ship LCL (later FCL) by sea through DHL Global Forwarding (or another NVOCC), clear customs once per shipment, hold hero SKUs in a US warehouse and ship domestic ground to the customer.** Delivered cost is roughly half of negotiated-rate Express and about a quarter of rack-rate Express.
3. **With this model, 7 of 12 SKUs clear a 25% contribution margin (after CAC) at or below US market price:** carved mandir, carved mirror, coffee table, side table, bookshelf, console table, bench. The jaali panel, stool and personalised kitchen set are marginal; the storage trunk and plant stand are not viable.
4. **The "30% cheaper" claim does not survive at US retail.** At 30% below the US comparable price the margin falls to 5-12% on most SKUs (22% on the bookshelf) after CAC. The honest position is price parity to about 8% below comparable pieces, with a 25-32% margin (section 8).
5. **Last-mile is the single biggest cost** (USD 26-157 per unit, 41-47% of delivered landed cost) because US parcel carriers bill dimensional weight (cubic inches / 139) and add surcharges above 10,368 cubic inches. Flat-packing (legs off) and carton size discipline matter more than ocean rates.
6. **First shipment size: about 11 CBM of LCL (136 units, about USD 5,500 at ex-factory cost, about USD 9,900 landed at the US warehouse, about USD 43,000 retail value).** LCL beats FCL below about 12-15 CBM on this lane (ESTIMATE).
7. **Timing:** production 3-4 weeks + LCL 6-8 weeks door to warehouse. **Diwali (8 Nov 2026) cannot be served by sea**; the realistic first stock lands in early to mid December 2026 if the goods leave Jodhpur by about 20 October.
8. **Returns:** furniture return shipping costs as much as the outbound leg (USD 60-160 here), so the policy must be damaged/defective = free fix or replacement, made-to-order = final sale, stock items = buyer pays return shipping plus a restocking fee.
9. **Inventory in a US 3PL creates sales-tax nexus in that state** even before the USD 100k economic thresholds are reached (ASSUMPTION; get a tax advisor). Marketplaces (Amazon, Etsy) collect tax as facilitators.
10. **Customs value is much lower when we import our own stock (declared at transfer value) than when we sell DDP per parcel (declared at retail).** This alone is worth USD 25-60 per hero unit in duty (section 5.3); it needs a customs broker to confirm valuation.

## 2. DHL facts used (primary sources)

### 2.1 DHL Express India export rate card and rules (VERIFIED, 2026)
Source: DHL Express Service and Rate Guide 2026: India, https://mydhl.express.dhl/content/dam/downloads/in/en/rate-guide/service_and_rate_guide_in_en_2026.pdf.coredownload.pdf (downloaded and read 2026-09-25; "status as of October 2025" for service limits). **The USA is DHL rating Zone 8.** Rates are published INR rack rates, excluding surcharges, fuel, duties and GST; **the owner will pay a negotiated account rate, which we cannot see (gap).**

| Item | Published value | Note |
|---|---|---|
| Express Worldwide, Zone 8 (USA), non-document | 0.5 kg INR 6,044; 1 kg 6,984; 2 kg 8,867; 5 kg 14,213; 10 kg 21,600; 20 kg 34,150; 30 kg 49,031 | USD at 88: 69 / 79 / 101 / 162 / 245 / 388 / 557 |
| Above 30 kg | INR 1,624 per kg for 30.1-70 kg (whole shipment); INR 1,638 per kg for 70.1-300 kg | 40 kg = INR 64,960 (about USD 738) |
| Volumetric weight | L x W x H (cm) / 5,000 per piece; billing weight rounded up to 0.5 kg to 30 kg, then 1 kg | |
| Max piece | 70 kg (not on pallet), 120 x 80 x 80 cm; pieces up to 300 cm in one base length accepted "additional surcharges may apply"; above 70 kg on a pallet (pallet max 1,000 kg, 300 x 200 x 160 cm) | |
| Overweight piece | INR 9,200 per piece if scale or volumetric weight exceeds 70 kg | |
| Oversize piece | INR 1,900 per piece if longest side exceeds 100 cm or second-longest exceeds 80 cm | |
| Non-conveyable piece | INR 1,900 if actual weight is 25-70 kg, or packed in wood/plastic/foam/shrink-wrap, or not fully enclosed in corrugated cardboard | Wooden crates trigger it |
| Non-stackable pallet | INR 30,000 per pallet | |
| Remote area delivery/pickup | INR 50 per kg, minimum INR 2,500 per shipment | |
| Fuel surcharge | Percent of transport and surcharges, indexed weekly; reported 22-32% in 2026 (ClickPost, ESTIMATE) | We use 27% |
| Duty Tax Paid (DTP) billed to shipper | 2% of fiscal charges, **minimum INR 2,500** (India guide); the US guide shows minimum USD 17.00 | About USD 28 minimum on the India side |
| US-side customs services (US guide 2026) | Single Clearance USD 35; Merchandise Processing 0.3464% of entered value (min USD 33.58, max USD 651.50); Regulatory Charges USD 1.34; Non-Routine Entry USD 35; Permits and Licenses USD 28; Post Clearance Modification USD 90; Multiline USD 5 per line after 5 | https://mydhl.express.dhl/content/dam/downloads/us/en/rate-guide/service_and_rate_guide_us_en_2026.pdf.coredownload.pdf |
| Shipment Value Protection (declared-value insurance) | INR 1,200 or 1% of insured value if higher | So it costs INR 1,200 even on a USD 60 item |
| Other | Residential Address INR 500; Direct Signature INR 500; Extended Liability INR 500; Customs Physical Intervention INR 2,000; Export Declaration INR 3,000 | |
| Demand (peak) surcharges | Variable by lane and weight | Peak season on Express is Oct-Jan (FAST) |
| Transit | Express Worldwide 3-5 business days (ClickPost, ESTIMATE); Amazon SEND UPS 4-8 days | |

Other reported India-to-USA Express price levels (ESTIMATE; resellers and aggregators, 2026): DHL 5 kg INR 6,500-7,000, 10 kg INR 9,500-10,500, 30 kg INR 19,500-22,000 (ClickPost, https://www.clickpost.ai/blog/courier-charges-for-usa); "INR 870/kg above 20 kg" (ClickPost DHL page). That is about **45-55% of rack**, which is why we model a "negotiated" case at 50% of rack. Amazon Global Selling SEND UPS card for sellers (VERIFIED, https://sell.amazon.in/grow-your-business/amazon-global-selling/fulfillment/send): 1-10 kg USD 10.83/kg expedited; 11-30 kg USD 8.28; 31-50 kg USD 7.00; 51-100 kg USD 6.20 (Express USD 11.47 / 8.78 / 7.42 / 6.57), transit 4-8 business days; **only for inbound to Amazon fulfilment centres** and it also shows ocean LCL through MGH and Xhipment from Mumbai/Chennai. That card is the cheapest documented parcel-level India-to-US price (a 26 kg coffee table would be about USD 215 by air), still 43% of its comparable retail price.

### 2.2 DHL and US customs facts that decide the model
- **De minimis ended (FAST):** the USD 800 exemption is indefinitely suspended for all modes since 24 Jun 2026 (Federal Register 2026-12670, https://www.federalregister.gov/documents/2026/06/24/2026-12670/indefinite-suspension-of-the-de-minimis-exemption-for-merchandise-arriving-through-all-modes-other). Every parcel needs an entry, an HTS classification, declared value, origin and an importer of record.
- **Duty on India-origin wooden furniture (FAST):** MFN mostly 0% on non-upholstered wooden furniture (HTS 9403) plus the 10% Section 301 tariff in force since 24 Jul 2026 for India (IHFRA 2026-07-27, https://ihfra.org/2026/07/27/new-tariffs-keep-pressure-on-furniture-imports/; details in [../countries/market-selection.md](../countries/market-selection.md) section 4.2). Wooden ornaments HTS 4420.19 MFN 3.2%; other 4420.90 MFN 3.2%; tableware HTS 4419 quoted 3.2-5.3% (USITC via search snippets, ESTIMATE, broker to confirm) plus 10%. Framed mirrors (HTS 7009.92) 3.9% (ASSUMPTION from memory of the tariff schedule; not verified). We used total duty: furniture 10%, ornaments/panels/planters 13.2%, framed mirror 13.9%, kitchenware 15%. Upholstered wooden seating carries Section 232 (25%); we sell none. Cabinets/vanities 25% rising to 50% on 1 Jan 2027 (ghy.com): a "bookshelf" may be argued as furniture 9403; broker to classify.
- **Lacey Act plant declaration** (APHIS) is required for furniture (chapter 94) and, phased, other wood products: genus/species, country of harvest, quantity, value. DHL as broker needs this data on the invoice (see 2.4). **CITES:** sheesham (Dalbergia sissoo) items over 10 kg net timber weight need a permit or EPCH Vriksh certificate; under 10 kg per item need none (market-selection.md 4.1). The mandir (about 20+ kg of wood), coffee table, console and bench exceed 10 kg net if made of sheesham: **make the heavy SKUs from mango wood or documented reclaimed non-Dalbergia wood, or budget the permit (DHL charge INR 4,500 plus certificate cost per shipment, or USD 28 on the US side)**. Owner already holds export paperwork; species per SKU is the open input.
- **ISPM-15 / wood packaging:** any solid wood packaging over 6 mm (pallets, crates) must be heat-treated and stamped (APHIS, https://www.aphis.usda.gov/plant-imports/wood-packaging-material). **For DHL Express avoid wooden crates entirely** (also triggers the non-conveyable surcharge): use double-wall corrugated with honeycomb or foam corners. For LCL use cartons on ISPM-15 pallets or floor-loaded cartons.

### 2.3 DHL liability and claims (ESTIMATE where noted)
DHL Express default liability is small (search result: "limited to USD 100" for articles of extraordinary value; the Warsaw-style per-kg limit applies otherwise), so **buy Shipment Value Protection or third-party insurance for every Express parcel over about USD 150**. Claims must be notified within 30 calendar days of acceptance; photograph packaging, the item and the label; DHL then opens a trace and investigates (sources: https://www.dhl.com/discover/en-sg/ship-with-dhl/start-shipping/submit-claim-lost-damaged-shipment; https://mydhl.express.dhl/content/dam/downloads/us/en/claims/dhl_express_claim_form_us_en.pdf.coredownload.pdf). DHL states damage is "often due to lack of proper packaging" and can decline claims for inadequate packing (ESTIMATE from search summary). For ocean freight, cargo insurance (Institute Cargo Clauses A) is separate: about 0.3-0.5% of invoice value (ASSUMPTION).

### 2.4 What DHL (as customs broker) needs from us on every shipment
Complete commercial invoice: seller and consignee, full description in customs language ("hand-carved solid mango wood wall mirror", not "decor"), **HTS code (10-digit US)**, quantity, unit and total value, country of origin (India), wood species (genus and species), country of harvest, net timber weight, Lacey declaration data, importer of record (us as non-resident IOR with a US bond, or the customer for DAP), incoterm (DDP = we pay), IEC, GSTIN and LUT/export declaration, packing list with piece dimensions and weights, and (for CITES-covered sheesham) the permit. Missing data is what creates "Non-Routine Entry" (USD 35 / INR 4,500) and "Post Clearance Modification" (USD 90) charges. Fill an HS/HTS master sheet for the 12 SKUs before the first shipment.

### 2.5 DHL domestic and forwarding side (what we could and could not verify)
- **DHL Global Forwarding** (ocean LCL/FCL, air) India-to-US rates: **not published; not found.** We use market figures: LCL USD 70-150 per CBM base ocean with 1-2 CBM minimum, but "USD 80 quotes often land at USD 140-200 per CBM all-in" (Suaid Global 2026, https://suaidglobal.com/shipping/india-to-usa/lcl/), FCL 20 ft USD 2,500-4,000, 6-10 weeks (FreightAmigo). **We model USD 260 per CBM all-in from Jodhpur/ICD to a US warehouse door** (ocean + origin CFS + US devanning + delivery to an inland 3PL) plus USD 40 per CBM customs admin (ASSUMPTION; range 200-400). Consolidated air freight about USD 3-5 per kg for 150-500 kg (bifpl/Bonanza, ESTIMATE); we model USD 6 per kg door to warehouse.
- **DHL eCommerce Solutions US (domestic ground):** packages up to 70 lb on Parcel Plus, dimensional weight applies above 1 cubic foot (dhl.com/us-en/home/ecommerce; easyship guide says domestic up to 25 kg on some services). Not suitable alone for 30-40 kg furniture cartons. **FedEx 2026 (VERIFIED, redstagfulfillment.com/fedex-oversized-fees):** Additional Handling if longest side over 48 in, second side over 30 in, or cubic volume over 10,368 cubic inches: USD 29.50-40.75 (dimension-based) or USD 46-58.75 (weight over 50 lb); **Oversize Charge USD 255-330 per package if cubic volume exceeds 17,280 cubic inches (10 cubic ft), length over 96 in or weight over 110 lb, with a 90 lb minimum billable weight**; residential surcharge USD 6.45; UPS Ground fuel about 25.5%, residential USD 6.50 (2026). **This means every retail carton must stay under 17,280 cubic inches (0.283 CBM) or it goes by LTL/white-glove instead.** All 12 SKUs are below it in our packed dimensions; the bookshelf (185 cm) and trunk sit close.
- **DHL Supply Chain fulfilment (3PL) rates:** not published. Market: pallet storage USD 8-25 per pallet per month, B2C pick and pack USD 2-3 per order (survey average 3.20), higher for bulky (https://www.fulfill.com/3pl-pricing; redstagfulfillment.com/3pl-pricing-explained), 30-50% premium in Los Angeles/NJ versus Memphis/Indianapolis/Reno.

## 3. Route (a): DHL Express India to US door, DDP billed to the shipper

**How it works:** carpenter packs a made-to-order piece in export cartons; DHL collects in Jodhpur (remote-area check!), flies it, DHL clears customs as broker and bills duties and fees to us (DTP); customer receives it duty-free at the door in 3-6 days after production. Etsy has made this DDP flow mandatory for non-US sellers from **9 July 2026** to keep Etsy Purchase Protection (valueaddedresource.net 2026; Etsy handbook blocked 403).

**Model (per parcel, ASSUMPTIONS flagged):** shipping = DHL Zone 8 rate at billing weight max(actual, volumetric) + surcharge (non-conveyable INR 1,900 for 25-70 kg cartons; oversize INR 1,900 above 100 cm; overweight INR 9,200 above 70 kg) then fuel 27%; plus INR 500 residential, DTP minimum INR 2,500, US clearance USD 36.34 (single clearance + regulatory; ASSUMPTION that one paid entry step applies), export handling USD 4.50; duty paid on the retail price ex-shipping (the DDP declared value); insurance 1% only above USD 150 with a floor of INR 1,200; damage/loss allowance 9%; payment fee 5.5% (Stripe India 4.3% + 2% FX = 6.3%, PayPal similar; ESTIMATE); CAC as in table 1. Table below shows shipping only; "negotiated" = 50% of rack (ESTIMATE).

| # | SKU | DHL Express transport+surcharges+fuel: rack | negotiated (50% of rack, ESTIMATE) | Landed to door incl. DDP admin, neg. rate (before duty on price) | Duty at comp price | Shipping % of comp (neg.) | Price needed for 25% margin (neg.) | Price needed (rack) | Margin at comp price (neg.) | Verdict |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Carved mandir 2.5 ft | 965 | 496 | 657 | 65 | 76% | 1,344 | 2,217 | -39% | NOT viable |
| 2 | Jaali wall panel 60x90 | 312 | 156 | 261 | 20 | 104% | 601 | 903 | -144% | NOT viable |
| 3 | Carved mirror 60x90 | 384 | 192 | 294 | 42 | 64% | 692 | 1,068 | -48% | NOT viable |
| 4 | Coffee table 90x50 (KD) | 649 | 338 | 472 | 50 | 68% | 989 | 1,562 | -33% | NOT viable |
| 5 | Side table (KD) | 448 | 224 | 334 | 33 | 68% | 711 | 1,121 | -44% | NOT viable |
| 6 | Bookshelf 5-tier (185 cm) | 918 | 473 | 636 | 80 | 59% | 1,307 | 2,136 | -13% | NOT viable |
| 7 | Kitchen wood set (tray+board) | 167 | 83 | 172 | 9 | 139% | 398 | 565 | -259% | NOT viable |
| 8 | Plant stand / planter | 366 | 183 | 276 | 6 | 407% | 586 | 941 | -622% | NOT viable |
| 9 | Storage trunk 90x45 | 1,152 | 590 | 759 | 50 | 118% | 1,518 | 2,566 | -96% | NOT viable |
| 10 | Console table 120 (KD) | 735 | 381 | 536 | 60 | 64% | 1,107 | 1,762 | -25% | NOT viable |
| 11 | Bench 120 (KD) | 563 | 295 | 429 | 40 | 74% | 893 | 1,385 | -48% | NOT viable |
| 12 | Carved stool | 339 | 169 | 265 | 18 | 94% | 560 | 871 | -101% | NOT viable |

**Why it fails:** DHL Express prices by billing weight and our goods are heavy or bulky for their value. A 26 kg coffee table has billing weight 26 kg: rack shipping INR 43,079 (USD 490) before fuel, USD 649 with fuel; even at half of rack it is USD 338, which is 68% of its USD 500 comparable retail price. The cheapest documented parcel price (Amazon SEND UPS Expedited, USD 8.28 per kg for 11-30 kg) is still about USD 215.

**Where route (a) does make sense (use it, but only for these):**
- Samples for Instagram/Etsy photography, press and B2B prospects (a 1-3 kg piece costs about USD 50-77 shipping at negotiated rates plus about USD 70 DDP admin; treat as marketing spend).
- Replacement parts and resolved damage claims (a corner piece, a drawer, a 0.5-2 kg panel): USD 44-64 shipping at negotiated rates plus about USD 65-70 DDP admin. Tell customers it is a 4-7 day fix.
- Personalised or engraved 1-2 kg gift items priced USD 250 or more, or custom miniatures for the diaspora gifting segment: at a negotiated USD 50-64 shipping plus about USD 70 admin the item needs to sell for roughly USD 250-300 to leave 25%. We have not seen US comparables at that price for 1-2 kg wood gifts (Etsy personalised boards USD 45-180, ESTIMATE); treat as untested.
- Time-critical festive orders (Diwali, weddings) that a customer explicitly pays express for.

**Fixed per-parcel overhead is the killer for small items:** about USD 28 DTP minimum + USD 36 clearance + USD 6 residential + USD 5 export handling = about USD 75 before any freight. That is why the Etsy tray/board model in the earlier micro-model failed and still fails.

## 4. Route (b): consolidated ocean (DHL Global Forwarding or NVOCC) to a US warehouse, then domestic last mile

**How it works (the standard model for India-made furniture sold in the US):** 1) production in Jodhpur, flat-packed where possible (legs off, hardware bagged); 2) export packing at the factory with a photographed packing list; 3) road or the Jodhpur-Mundra "Furniture Express" rail (launched 28 Feb 2026, 2-3 rakes per week, indiashippingnews.com) to Mundra or Nhava Sheva; 4) LCL consolidation (FCL when a full 20 ft is ready); 5) ocean 28-42 days port to port (ESTIMATE) plus 1-2 weeks of consolidation and US devanning; 6) customs entry filed by a US broker with an ISF (importer security filing) 24 hours before loading, bond posted; 7) delivery to a 3PL (or Amazon FBA); 8) pick, pack and ship by ground to the consumer.

**Customs mechanics and costs (VERIFIED ranges from broker guides, 2026):** broker USD 100-250 per entry for simple entries and USD 150-800 for complex ones; ISF USD 30-75; continuous bond USD 300-600 a year (USD 400-1,200 including larger cargo) or single-entry bond USD 75-275; MPF 0.3464% of value (min USD 33.58, max USD 651.50); harbor maintenance 0.125% ocean (https://warehousingcosts.com/guides/customs-brokerage-fees; https://strixsmart.com/resources/blog/customs-broker-cost). We fold all this into USD 40 per CBM (about USD 450 per 11 CBM shipment: broker USD 250, ISF USD 50, MPF about USD 100, bond share), ASSUMPTION.

**Sales tax:** marketplaces (Etsy, Amazon) collect and remit as facilitators in all US states with sales tax (numeral.com/taxcloud 2026, ESTIMATE from search summary); on the own site we must register where we have nexus: **physical presence from inventory in a 3PL state** (Amazon FBA spreads inventory across several states, creating multi-state nexus) or economic nexus: USD 100,000 in 41 states, USD 250,000 in Alabama, USD 500,000 in California, Texas, New York (2026, ESTIMATE from the same sources). The first 100 orders (about USD 45,000) stay far below every economic threshold, but the 3PL-state registration would still apply (ASSUMPTION; tax advisor).

**Returns:** furniture online return rates run 19-23% (Eightx/ClaimLane 2026, ESTIMATE); a large return costs USD 55-108 to process and a sofa USD 150-300 reverse shipping (ClaimLane). Our policy (section 9) is designed to keep effective returns near 3-4% of orders (ASSUMPTION), with a 7% damage/claims allowance on landed cost in the model. Furniture damage rates 5-10% (ESTIMATE, industry blog), higher on long ocean routes without proper cartons.

**Packaging:** double-wall corrugated, edge protectors on all corners, foam or honeycomb on carved faces, polybag plus silica gel/desiccant against monsoon and container moisture (wood moisture content 8-12% at shipment; ASSUMPTION), no wooden crate unless ISPM-15 stamped. Budget INR 300-700 per SKU (table 1). Drop test one carton per SKU before the first shipment.

**Insurance:** ocean cargo insurance about 0.3-0.5% of invoice value (ASSUMPTION); domestic parcel declared value on every carton over USD 300; product liability insurance for US sales (USD 500-1,500 a year, ASSUMPTION; required by Amazon at higher volume).

**Timeline for a hero SKU:** production 3-4 weeks (batch), road/rail to port and consolidation 7-10 days, ocean 4-6 weeks, US devanning and drayage 5-10 days, receiving at 3PL 2-3 days = **about 9-12 weeks from order to shelf**; after that a customer order ships in 1-2 days and arrives in 3-7 days (ground). Air-freight batch option (route b-air) cuts the pipeline to about 4-5 weeks but destroys the margin (table 6).

## 5. Route (c): hybrid (recommended)

- **Ready-stock heroes** (mandir 2.5 ft, mirror, coffee table, side table, console, bench, bookshelf) pre-positioned in a US 3PL by LCL: **3-7 day delivery, free shipping included, DDP-free price**, honest "ships from our US warehouse" messaging.
- **Made-to-order customisation** (size, finish, carving, larger mandirs): sold at a 15-25% premium (ASSUMPTION; Etsy personalisation premium is 40-60% for boards, blog ESTIMATE) with an honest **10-12 week promise** if batched into the next LCL, or **5-8 weeks if air-batched** at a higher price (table 6 shows the air batch is only viable for the bookshelf at the ready-stock price, so charge a premium of about USD 100-150 on mandir/coffee table to use it). Quote through the existing quote flow (decision 0034).
- **Small, light, high-value items** (samples, replacement parts, gifts over USD 250) go by DHL Express DDP.
- Every sold SKU replenishes in monthly or bi-monthly LCL lots; when volume reaches about 12-15 CBM per lot switch to a 20 ft FCL.

### 5.3 Customs valuation: why importing our own stock beats DDP per parcel
For a DDP parcel sold to a US consumer, the dutiable value is the price the customer paid (excluding international freight if shown separately). For stock we import ourselves, the value is the transfer price of goods shipped to our own US stock account (ASSUMPTION: 1.25 x ex-factory cost + packaging; **CBP scrutinises related-party and consigned valuation, so the broker/customs counsel must set this**). For a coffee table this is 10% x about USD 74 versus 10% x USD 459: USD 7 versus USD 46 duty. If CBP rejects the low value, the hero duty rises about USD 25-40 per unit and margins fall by 5-8 points (sensitivity: add USD 30 to the duty column).

## 6. Landed-cost and margin model (12 SKUs)

Formulas (per unit, USD):
```
F = ex-factory INR / 88;   Pack = export packing INR / 88
LCL freight = packed CBM x (260 + 40 customs admin)              # ASSUMPTION USD/CBM
Duty = 1.25 x (F + Pack) x duty%                                  # hero stock imported by us
3PL = packed CBM x 18 x 3 months + 2 receiving + pick (4 if <10 kg, else 8)   # ASSUMPTION
Last mile = (0.55 x (13 + 1.6 x billable lb) + 6.5) x 1.255 + AHS 25 if oversize-type   # billable lb = max(actual lb, cubic in / 139)
Landed delivered cost = F + Pack + 2 (handling) + LCL + Duty + 3PL + Last mile
Allowance = 7% x landed (damage, replacements, refunds)
Price for margin m: P = (Landed x 1.07 + CAC + 0.30) / (1 - 5.5% payment fee - m)
Contribution margin = (P - all costs) / P        # sales tax excluded (pass-through)
```
Overheads (rent, software, salaries, owner time) are **not** in the contribution margin; a healthy business needs about 10-15 points left over (ASSUMPTION).

### Table 1: inputs per SKU (ASSUMPTIONS to replace; sources in column notes below)
| # | SKU | Ex-factory INR (F) | Export pack INR | Gross kg | Packed cm | Packed CBM | DHL billing kg (divisor 5000) | Duty % (MFN + S301) | US comp median USD | Comp range USD |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Carved mandir 2.5 ft | 6,820 | 700 | 32 | 80x55x45 | 0.198 | 40 | 10.0% | 650 | 410-900 |
| 2 | Jaali wall panel 60x90 | 2,330 | 300 | 9 | 95x65x8 | 0.049 | 10.0 | 13.2% | 150 | 60-320 |
| 3 | Carved mirror 60x90 | 2,025 | 350 | 8.5 | 100x70x10 | 0.070 | 14.0 | 13.9% | 300 | 104-576 |
| 4 | Coffee table 90x50 (KD) | 4,700 | 450 | 26 | 95x55x22 | 0.115 | 26.0 | 10.0% | 500 | 217-824 |
| 5 | Side table (KD) | 2,760 | 350 | 15 | 60x45x32 | 0.086 | 17.5 | 10.0% | 330 | 150-662 |
| 6 | Bookshelf 5-tier (185 cm) | 7,200 | 600 | 38 | 185x40x25 | 0.185 | 38 | 10.0% | 800 | 800-1609 |
| 7 | Kitchen wood set (tray+board) | 1,100 | 120 | 3.5 | 40x30x12 | 0.014 | 3.5 | 15.0% | 60 | 25-180 |
| 8 | Plant stand / planter | 1,400 | 200 | 5.5 | 40x40x40 | 0.064 | 13.0 | 13.2% | 45 | 30-80 |
| 9 | Storage trunk 90x45 | 7,600 | 700 | 30 | 95x50x50 | 0.237 | 48 | 10.0% | 500 | 400-600 |
| 10 | Console table 120 (KD) | 6,500 | 550 | 30 | 118x42x28 | 0.139 | 30.0 | 10.0% | 600 | 345-1200 |
| 11 | Bench 120 (KD) | 4,700 | 450 | 22 | 118x42x20 | 0.099 | 22.0 | 10.0% | 400 | 200-620 |
| 12 | Carved stool | 1,650 | 200 | 6 | 45x35x35 | 0.055 | 11.5 | 10.0% | 180 | 170-350 |
Notes: ex-factory cost INR for the mandir, jaali panel, mirror, coffee table and side table comes from [unit-economics-model.md](unit-economics-model.md) table A at timber INR 1,500/cft (kitchen set = tray INR 454 + board + spoon; bedside table used for the side table); bookshelf, trunk, console, bench, stool and planter are our estimates scaled from wood volume (ASSUMPTION; **owner: real cost sheet**). Packed dimensions and weights are our guesses for knock-down (legs off) packing (ASSUMPTION; **owner: actual carton sizes**). US comp = median of the price observations in [us-b2c-price-benchmark.md](../competitor-research/us-b2c-price-benchmark.md). The mirror (USD 300) and bookshelf (USD 800) comps are deliberately the low end of thin samples (observed USD 152-1,172 and USD 800-1,609), and the jaali (USD 150), planter (USD 45) and trunk (USD 500) comps are thin or ASSUMPTION; treat those rows with caution.

### Table 2: route (a) DHL Express DDP, shipping cost versus US price
| # | SKU | DHL Express transport+surcharges+fuel: rack | negotiated (50% of rack, ESTIMATE) | Landed to door incl. DDP admin, neg. rate (before duty on price) | Duty at comp price | Shipping % of comp (neg.) | Price needed for 25% margin (neg.) | Price needed (rack) | Margin at comp price (neg.) | Verdict |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Carved mandir 2.5 ft | 965 | 496 | 657 | 65 | 76% | 1,344 | 2,217 | -39% | NOT viable |
| 2 | Jaali wall panel 60x90 | 312 | 156 | 261 | 20 | 104% | 601 | 903 | -144% | NOT viable |
| 3 | Carved mirror 60x90 | 384 | 192 | 294 | 42 | 64% | 692 | 1,068 | -48% | NOT viable |
| 4 | Coffee table 90x50 (KD) | 649 | 338 | 472 | 50 | 68% | 989 | 1,562 | -33% | NOT viable |
| 5 | Side table (KD) | 448 | 224 | 334 | 33 | 68% | 711 | 1,121 | -44% | NOT viable |
| 6 | Bookshelf 5-tier (185 cm) | 918 | 473 | 636 | 80 | 59% | 1,307 | 2,136 | -13% | NOT viable |
| 7 | Kitchen wood set (tray+board) | 167 | 83 | 172 | 9 | 139% | 398 | 565 | -259% | NOT viable |
| 8 | Plant stand / planter | 366 | 183 | 276 | 6 | 407% | 586 | 941 | -622% | NOT viable |
| 9 | Storage trunk 90x45 | 1,152 | 590 | 759 | 50 | 118% | 1,518 | 2,566 | -96% | NOT viable |
| 10 | Console table 120 (KD) | 735 | 381 | 536 | 60 | 64% | 1,107 | 1,762 | -25% | NOT viable |
| 11 | Bench 120 (KD) | 563 | 295 | 429 | 40 | 74% | 893 | 1,385 | -48% | NOT viable |
| 12 | Carved stool | 339 | 169 | 265 | 18 | 94% | 560 | 871 | -101% | NOT viable |

### Table 3: route (b) LCL + US 3PL + ground last mile, delivered landed cost, price needed and verdict
| # | SKU | Ex-factory+pack | LCL + customs admin | Duty (on 1.25x cost) | 3PL store+recv+pick | Last-mile (ground, ESTIMATE) | Landed delivered cost | Price for 25% margin | US comp | Margin at comp | Margin at 0.7x comp (30% cheaper) | Verdict |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Carved mandir 2.5 ft | 85 | 61 | 11 | 21 | 138 | 316 | 589 | 650 | 32% | 5% | VIABLE (launch) |
| 2 | Jaali wall panel 60x90 | 30 | 17 | 5 | 9 | 41 | 101 | 215 | 150 | -5% | -47% | MARGINAL (only as premium carved, price >= 219) |
| 3 | Carved mirror 60x90 | 27 | 23 | 5 | 10 | 51 | 116 | 251 | 300 | 37% | 12% | VIABLE (launch) |
| 4 | Coffee table 90x50 (KD) | 59 | 36 | 7 | 16 | 105 | 224 | 432 | 500 | 35% | 9% | VIABLE (launch) |
| 5 | Side table (KD) | 35 | 28 | 4 | 15 | 59 | 141 | 283 | 330 | 35% | 9% | VIABLE (launch) |
| 6 | Bookshelf 5-tier (185 cm) | 89 | 58 | 11 | 20 | 135 | 312 | 582 | 800 | 44% | 22% | VIABLE (launch) |
| 7 | Kitchen wood set (tray+board) | 14 | 6 | 3 | 7 | 26 | 55 | 108 | 60 | -29% | -83% | MARGINAL (personalised gift set only; not stand-alone) |
| 8 | Plant stand / planter | 18 | 21 | 3 | 9 | 48 | 100 | 176 | 45 | -177% | -294% | NOT viable |
| 9 | Storage trunk 90x45 | 94 | 73 | 12 | 23 | 157 | 359 | 641 | 500 | 6% | -33% | NOT viable |
| 10 | Console table 120 (KD) | 80 | 44 | 10 | 17 | 115 | 266 | 497 | 600 | 37% | 12% | VIABLE (launch) |
| 11 | Bench 120 (KD) | 59 | 32 | 7 | 15 | 71 | 184 | 356 | 400 | 33% | 6% | VIABLE (launch) |
| 12 | Carved stool | 21 | 19 | 3 | 9 | 44 | 95 | 190 | 180 | 21% | -10% | MARGINAL (test/bundle) |

### Table 4: recommended launch price (shipping included, DDP-free) and contribution
Recommended price = the higher of "cost-plus at 25% contribution" and 92% of the US comparable median, rounded to x9 (so we sit slightly under the comparable). **Only the SKUs marked VIABLE or MARGINAL in table 3 should be listed;** for the NOT viable SKUs the price shown is what they would have to sell for and is above the market.
| # | SKU | Recommended list price USD (shipping included, DDP-free for US customer) | Landed cost + allowances | Payment fee 5.5% | CAC | Contribution USD | Contribution % |
|---|---|---|---|---|---|---|---|
| 1 | Carved mandir 2.5 ft | 599 | 339 | 33 | 70 | 157 | 26% |
| 2 | Jaali wall panel 60x90 | 219 | 108 | 12 | 40 | 58 | 27% |
| 3 | Carved mirror 60x90 | 279 | 124 | 15 | 50 | 90 | 32% |
| 4 | Coffee table 90x50 (KD) | 459 | 240 | 25 | 60 | 134 | 29% |
| 5 | Side table (KD) | 309 | 151 | 17 | 45 | 95 | 31% |
| 6 | Bookshelf 5-tier (185 cm) | 739 | 334 | 41 | 70 | 294 | 40% |
| 7 | Kitchen wood set (tray+board) | 109 | 59 | 6 | 15 | 29 | 26% |
| 8 | Plant stand / planter | 179 | 107 | 10 | 15 | 47 | 26% |
| 9 | Storage trunk 90x45 | 649 | 385 | 36 | 60 | 168 | 26% |
| 10 | Console table 120 (KD) | 559 | 285 | 31 | 60 | 183 | 33% |
| 11 | Bench 120 (KD) | 369 | 196 | 20 | 50 | 102 | 28% |
| 12 | Carved stool | 189 | 102 | 10 | 30 | 47 | 25% |

### Table 5: sensitivity of the contribution margin (route b, at the recommended price)
Each column changes one input.
| # | SKU | Base | Last-mile -30% | Last-mile +30% | LCL $180/CBM | LCL $400/CBM | INR cost +20% | INR cost -20% | FX 84 | FX 92 |
|---|---|---|---|---|---|---|---|---|---|---|
| 1 | Carved mandir 2.5 ft | 26% | 34% | 19% | 29% | 21% | 23% | 30% | 25% | 27% |
| 2 | Jaali wall panel 60x90 | 27% | 33% | 21% | 28% | 23% | 23% | 30% | 26% | 27% |
| 3 | Carved mirror 60x90 | 32% | 38% | 26% | 34% | 28% | 30% | 35% | 32% | 33% |
| 4 | Coffee table 90x50 (KD) | 29% | 37% | 22% | 31% | 25% | 26% | 32% | 28% | 30% |
| 5 | Side table (KD) | 31% | 37% | 25% | 33% | 27% | 28% | 34% | 30% | 31% |
| 6 | Bookshelf 5-tier (185 cm) | 40% | 46% | 34% | 42% | 36% | 37% | 43% | 39% | 40% |
| 7 | Kitchen wood set (tray+board) | 26% | 34% | 19% | 27% | 24% | 23% | 29% | 25% | 27% |
| 8 | Plant stand / planter | 26% | 35% | 18% | 29% | 21% | 24% | 29% | 26% | 27% |
| 9 | Storage trunk 90x45 | 26% | 34% | 18% | 29% | 20% | 22% | 29% | 25% | 27% |
| 10 | Console table 120 (KD) | 33% | 39% | 26% | 35% | 29% | 29% | 36% | 32% | 33% |
| 11 | Bench 120 (KD) | 28% | 34% | 21% | 30% | 24% | 24% | 31% | 27% | 28% |
| 12 | Carved stool | 25% | 32% | 17% | 27% | 20% | 22% | 27% | 24% | 25% |
Reading: no single input flips a viable SKU to a loss; the last-mile rate (+/-30%) moves margin by 6-7 points and the LCL rate by 3-5 points. **The two inputs to firm up first are last-mile rate (get a 3PL quote for 20 sample cartons to five ZIP codes) and INR ex-factory cost.** A combined bad case (last-mile +30%, INR cost +20%, LCL USD 400) takes the coffee table and mandir to about 11-15% margin (estimated by adding the deltas).

### Table 6: route (b-air): made-to-order by air-freight batch to the US warehouse (USD 6 per kg door-to-warehouse, ASSUMPTION), at the ready-stock price
| # | SKU | Air batch door-to-3PL (USD 6/kg ASSUMPTION) | Landed delivered cost | Margin at rec price | Note |
|---|---|---|---|---|---|
| 1 | Carved mandir 2.5 ft | 198 | 444 | 3% | too thin |
| 2 | Jaali wall panel 60x90 | 54 | 138 | 9% | too thin |
| 3 | Carved mirror 60x90 | 70 | 161 | 15% | too thin |
| 4 | Coffee table 90x50 (KD) | 156 | 339 | 2% | too thin |
| 5 | Side table (KD) | 90 | 201 | 10% | too thin |
| 6 | Bookshelf 5-tier (185 cm) | 228 | 474 | 16% | OK |
| 7 | Kitchen wood set (tray+board) | 21 | 71 | 11% | too thin |
| 8 | Plant stand / planter | 64 | 141 | 1% | too thin |
| 9 | Storage trunk 90x45 | 238 | 513 | 1% | too thin |
| 10 | Console table 120 (KD) | 180 | 397 | 8% | too thin |
| 11 | Bench 120 (KD) | 132 | 281 | -0% | too thin |
| 12 | Carved stool | 55 | 131 | 5% | too thin |
Only the bookshelf keeps a workable margin. For a 5-8 week made-to-order promise, add a premium of USD 100-150 (mandir, coffee table, console) or sell them as "made to order, 10-12 weeks by sea".

### Table 7: first LCL shipment (about 11 CBM, 136 units), inventory and cash
| SKU | Units | CBM | Ex-factory + pack USD | Landed-at-3PL (freight+duty+admin) USD | List price USD | Retail value USD |
|---|---|---|---|---|---|---|
| Carved mandir 2.5 ft | 12 | 2.38 | 1,025 | 1,890 | 599 | 7,188 |
| Jaali wall panel 60x90 | 20 | 0.99 | 598 | 1,033 | 219 | 4,380 |
| Carved mirror 60x90 | 20 | 1.40 | 540 | 1,094 | 279 | 5,580 |
| Coffee table 90x50 (KD) | 16 | 1.84 | 936 | 1,637 | 459 | 7,344 |
| Side table (KD) | 20 | 1.73 | 707 | 1,354 | 309 | 6,180 |
| Console table 120 (KD) | 8 | 1.11 | 641 | 1,070 | 559 | 4,472 |
| Bench 120 (KD) | 10 | 0.99 | 585 | 976 | 369 | 3,690 |
| Carved stool | 10 | 0.55 | 210 | 422 | 189 | 1,890 |
| Kitchen wood set (tray+board) | 20 | 0.29 | 277 | 456 | 109 | 2,180 |
| **Total** | 136 | 11.3 | 5,520 | 9,931 | | 42,904 |
Add about USD 400-600 for the first-time bond, ISF and broker set-up, USD 300-500 for ocean cargo insurance, and 3PL onboarding (USD 0-500; ASSUMPTION). **Total cash at risk about USD 11,000-12,000 before marketing.** If all 136 units sold at list price the shipment returns about USD 43,000 revenue and about USD 10,000-12,000 contribution after CAC (about 26-29% blended). Sell-through of 70% (about 95 orders of one unit; the first-100-orders target) is a realistic plan; the rest carries into the next season. **Minimum viable order for a container:** 8-12 CBM LCL (about 100-140 units of this mix) to reach the LCL per-CBM rates; a full 20 ft FCL is about 25 CBM (about 250-300 units, about USD 12,000 ex-factory) and is the target once the heroes sell through in about 8-10 weeks.

## 7. Do the SKUs pass? (summary)

| SKU | Route (a) DHL Express | Route (b) sea + 3PL | Comment |
|---|---|---|---|
| Carved mandir 2.5 ft | No (shipping 76% of comp, non-conveyable 32 kg) | **Viable at USD 599** | Anchor SKU; make in mango/teak to avoid the CITES 10 kg rule; largest last-mile (USD 138) |
| Carved mirror 60x90 | No | **Viable at USD 279** | Fragile: corner-protected carton, glass-safe; check HTS 7009.92 |
| Coffee table 90x50, legs off | No | **Viable at USD 459** | Wayfair mass sheesham at USD 217-337 is not our comparable; position with Timbergirl/World Interiors USD 450-824 |
| Side table | No | **Viable at USD 309** | Sell as a pair or with a coffee table (bundle) |
| Bookshelf 5-tier, 185 cm | Outside DHL Express 120 cm piece limit | **Viable at USD 739** | Highest margin (40%) but longest carton (AHS) and comp scarce (USD 800-1,609) |
| Console table 120, legs off | No | **Viable at USD 559** | Oversize (118 cm) but under 17,280 cubic in |
| Bench 120, legs off | No | **Viable at USD 369** | Thin at price cut: hold at USD 369+ |
| Jaali wall panel | No (shipping 104% of comp) | Marginal | Only as premium carved/large (USD 219+); US comps for jaali panels not found (gap) |
| Carved stool | No | Marginal | Bundle only (with a mandir as a "pooja stool") |
| Kitchen wood set | No | Marginal | Only as a personalised gift set at USD 109+; commodity wood sets USD 25-35 elsewhere |
| Storage trunk 90x45 | No | **Not viable** | 0.24 CBM and 104 lb billable weight: last-mile USD 157 |
| Plant stand / planter | No | **Not viable** | Weight and volume out of proportion to a USD 45 comp |

## 8. Does the "30% cheaper" advantage survive at US retail? (plain answer)

**No, not as a price promise.** Sources of the advantage (Jodhpur labour and timber, no showroom) are real, but three costs are added between the factory and a US doorstep: **ocean + customs (USD 6-73 per unit), 10-15% duty (USD 3-12 at transfer value), and US 3PL plus last-mile (USD 33-180 per unit)**. Together they add USD 41-265 to a USD 14-94 ex-factory cost: the delivered landed cost is 3.4-5.6 times the factory cost.
- At the **US comparable median**, contribution after CAC is 32% (mandir), 37% (mirror), 35% (coffee table), 35% (side table), 44% (bookshelf), 37% (console), 33% (bench).
- At **30% below the comparable**, the same SKUs earn 5%, 12%, 9%, 9%, 22%, 12%, 6%. That is below a survivable margin once overhead is included.
- Against **Wayfair mass-market sheesham** (Ahlanni solid sheesham coffee table USD 216.59 on sale, USD 336.99 regular, Havenly listing 2026): our coffee table would lose 44% at USD 217 and break even near USD 320. **We cannot win on price against Wayfair-style container importers; we can win on "craft you can verify + customisation + honest lead time".**
- Against **US-stocked mandir sellers** (Urli Utsav USD 385-570, The Mandir Store USD 399-3,399, both with free ground shipping), a solid carved sheesham/mango mandir at USD 599 is 5-55% above the entry offers and below the US-made custom brands (Pooja Mandirs USA USD 1,700-3,300); that mid position is credible for solid wood with carving, not for laminate look-alikes.
- The **plausible headline** is therefore **"matches or slightly undercuts comparable US pieces (5-10% under), with the customisation and wood provenance they do not offer"**, not "30% cheaper". Any "30% off" claim would be measured against inflated US compare-at prices (for example Timbergirl Andaman coffee table USD 214.99 versus compare-at 319.99, Raven bench USD 199.99-249.99 versus 499.99; World Interiors bundle USD 2,750 versus 4,760) and would be unprovable.

## 9. Shipping-included pricing and policy guidance

- **Price shipping into the product ("free delivery, duties included"),** as every US competitor in the benchmark does (Urli Utsav, The Mandir Store, Mandir For Home, World Market over its threshold, Wayfair). Show one price. World Market adds a per-item "shipping surcharge" of USD 30-200 on some furniture (data-shipping-surcharge on its category pages), so a small surcharge for bulky items is accepted, but a clean number converts better (ASSUMPTION).
- **Free-shipping threshold and small items:** orders under USD 100: flat USD 12.95 (our ground cost is USD 26 for a 3.5 kg kitchen set, so bundle small items with a hero or set a USD 150 free-shipping threshold). Exclude Alaska, Hawaii and Puerto Rico at launch (The Mandir Store also excludes AK, HI, FL) and add remote-area surcharges later.
- **Delivery promise:** in-stock "ships in 1-2 business days, arrives in 3-7 days"; made-to-order "ships in 10-12 weeks" (sea) or "5-8 weeks" (air premium). Quote the date at checkout; FTC rules on shipment dates apply (see [../countries/us-legal-requirements.md](../countries/us-legal-requirements.md)).
- **Returns policy:** damaged or defective on arrival: report with photos within 48 hours (The Mandir Store's window), free repair, replacement part or replacement piece, no return shipping needed for small damage; stock items: 14-day return, buyer pays return shipping (USD 60-160) and 15% restocking fee, item unused in original carton; **made-to-order and customised: final sale except defects** (matches Mandir For Home, whose policy makes the customer responsible for shipping charges and offers free returns only on faulty or damaged mandirs).
- **Warranty and repair:** 1-year workmanship warranty (matches India model); free replacement parts shipped by DHL Express.
- **Delivery to the door:** curbside/first-dry-spot for cartons up to 30 kg; state clearly that the customer must carry it inside (Mandir For Home states ground floor delivery only; that is industry normal). White-glove is an optional paid upgrade (USD 150-250, ASSUMPTION).

## 10. What the owner must provide or decide (in priority order)
1. **Real ex-factory cost sheet for the 12 SKUs** (timber, labour, carving, finish, hardware) and **species per SKU** (sheesham needs CITES/Vriksh over 10 kg net timber; mango/teak/reclaimed avoid it).
2. **Actual packed carton dimensions and weights** per SKU (knock-down design); a drop-tested pack for each.
3. **DHL Express account rate card** for India to USA Zone 8 (base per kg, surcharges, DTP terms) and a **DHL Global Forwarding quote**: LCL Mundra or Nhava Sheva to NJ/Savannah/Houston/LA per CBM all-in to a 3PL door, FCL 20 ft, transit; also air consolidation per kg. Compare with one other forwarder/NVOCC.
4. **US 3PL choice and quotes:** receiving, storage per pallet/CBM, pick/pack for bulky items, ground rates per carton to 5 ZIP zones; ask DHL Supply Chain/eCommerce and two independents; ask about FBA prep as an alternative.
5. **Customs broker** and **valuation approach** (transfer price), **non-resident importer-of-record** set-up, continuous bond, ISF.
6. **Budget:** cash for the first LCL (about USD 11-12k) plus marketing; whether to hold 70% of stock as heroes.
7. **Return and warranty policy** confirmation (section 9) and whether to offer white-glove.
8. **FX rate** and payment set-up: Stripe is invite-only in India with USD card cost about 4.3% + 2% conversion = 6.3% (Skydo, 2026); PayPal and Razorpay International are alternatives (Razorpay about 3%, unverified for a US storefront).
9. **Sales tax advisor** to confirm nexus (3PL state) and registration timing.
10. **Insurance:** cargo policy and product liability.

## 11. Data gaps and blocked sources
- DHL Global Forwarding, DHL Supply Chain and DHL eCommerce US rate cards: not published/not found. Owner-specific DHL Express account discount: unknown (we assume 50% of rack, ESTIMATE from reseller rates).
- US ground carrier rates per zone and weight (UPS/FedEx retail tables were not extractable from search results); our last-mile function is fitted to two published data points (UPS Ground 10 lb USD 20.90-36.50 and 20 lb USD 31.50-56.90 published daily rates, 2026; residential USD 6.45-6.50; fuel about 25.5%; AHS/oversize per FedEx) and assumes 45% contract discount (ASSUMPTION).
- Amazon FBA large-bulky fulfilment fee table: only "starts around USD 9.35 plus per-pound surcharge, +3.5% fuel" found (ESTIMATE); FBA storage USD 0.56 per cubic foot Jan-Sep, USD 1.40 Oct-Dec (VERIFIED via search summary).
- Etsy handbook (403), Etsy listings (403), Wayfair (429), Pottery Barn (403), CB2/Crate (403), West Elm (timeout): see the price benchmark for what was blocked.
- HTS rates for 4419 and framed mirrors not verified against the live USITC schedule; CBP's position on hero-stock transfer value not verified.
- Whether DHL Express DTP is accepted as Etsy's DDP option (Etsy lists UPS and FedEx among DDP carriers; DHL not confirmed).
- Timing of monsoon/moisture damage and real damage rate on India-to-US ocean furniture: no reliable data; use a pilot.
