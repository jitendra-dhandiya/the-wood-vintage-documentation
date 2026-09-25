# C. US import mechanics for a B2C foreign seller

Prepared 2026-09-25. FAST items flagged.

## C1. Importer of Record (IOR) and DDP vs DAP
- The IOR is legally liable for duty, accuracy of classification/value/origin, and Lacey declaration. For a DTC parcel there are three models:
  1. Courier DDP (DHL/FedEx/UPS as broker on behalf of seller, seller pays duties/taxes upfront; the consumer pays nothing at door). Best conversion; seller bears the duty in COGS. The courier acts as broker but the named consignee/IOR is typically the buyer unless a seller-IOR account is set; check carrier's "DDP" terms [BROKER].
  2. DAP: consumer pays duty and broker fees at door. Cause of refused deliveries; since de minimis ended every parcel incurs duty + a broker handling fee ($10-25 or more) so DAP surprises are large. Avoid for orders > a few dollars.
  3. Bulk to US 3PL: seller (non-resident IOR) enters goods formally; sells domestically after. Needs bond, POA, broker, ISF for ocean. Cheapest per unit at scale.
- Non-resident IOR: CBP Form 5106 (Create/Update Importer Identity; foreign entities get a CBP-assigned number or use passport/IEC-linked ID - broker will file) [BROKER]; customs bond (CBP Form 301); Power of Attorney to broker (CBP 5291 or broker's form). A US agent for service of process (a resident agent) is needed for the bond surety [BROKER]. Source CBP: https://www.cbp.gov/trade/basic-import-export/importer-record (ASSUMPTION not fetched).
- Bond: single-transaction bond about $50-100 per entry minimum (for duties < $5k) (ESTIMATE); continuous bond min $50,000 -> premium $400-800/yr for ordinary goods (ESTIMATE). Note bond must cover anticipated duties, 10% of duties/fees paid in prior year, min $50k. For low-volume, use single-entry bonds via broker; move to continuous once >5 entries a year.
- ISF (10+2): mandatory for ocean freight only, filed by importer/broker no later than 24 hours before loading at foreign port; late/wrong = $5,000 per violation liquidated damages (ASSUMPTION - 19 CFR 149). Not required for air/courier.

## C2. Entry types (FAST)
- Informal entry threshold $2,500 (ASSUMPTION); above that formal entry with bond. But with de minimis suspended, all low-value shipments now require informal or formal entry (VERIFIED: Federal Register 2026-06-24 interim final rule, https://www.federalregister.gov/documents/2026/06/24/2026-12670/indefinite-suspension-of-the-de-minimis-exemption-for-merchandise-arriving-through-all-modes-other ). Statutory repeal 2027-07-01 (VERIFIED secondary via OBBBA sec 70531(b)(3)). Postal rule effective 2026-07-24 (VERIFIED secondary).

## C3. Tariff stack on India-origin wood furniture and decor (FAST, verify weekly around first shipment)
| Layer | Status 2026-09-25 | Source |
|---|---|---|
| MFN/general duty | 0%-3.9% depending on HTS (see 01 file) | HTS (ASSUMPTION) |
| IEEPA reciprocal (18%) and Russia-oil 25% | Struck down by SCOTUS 2026-02-20; India's 25% removed 2026-02-07 earlier. Refund process for paid IEEPA duties exists (ask broker) | Wilmer, Norton Rose (VERIFIED secondary) |
| Section 122 10% | 2026-02-24 to 2026-07-24, expired. (Reports of trade court ruling against it; moot.) | Skadden (VERIFIED secondary) |
| Section 301 "forced-labor" | 10% from 2026-07-24 for India (flat 10% group of 17 major trading partners), exemptions include goods already under 232 | Holland & Knight (VERIFIED secondary), USTR fact sheet |
| Section 232 timber derivatives | 25% on upholstered wooden furniture, kitchen cabinets, vanities (rise to 30%/50% delayed to 2027-01-01). Non-upholstered furniture/decor not covered (ASSUMPTION) | Federal Register 2026-01-09 (VERIFIED) |
| Section 232 steel/aluminium | Not relevant unless metal-dominant items; brass inlays minor | secondary |
| AD/CVD | Wooden bedroom furniture from China only (not India) | ASSUMPTION |
| India-US interim trade agreement | Announced 2026-02-06; reported 0% for some home-decor lines; superseded by SCOTUS ruling. Verify current text | White House fact sheet (VERIFIED existence) |
Planning number: ~10% ad valorem plus MFN 0-3.9% for non-upholstered goods; ~35% for upholstered pieces (ESTIMATE). Section 301 exempts goods under 232, so upholstered = 25% (+ MFN 0) not stacked (ASSUMPTION). Ask broker to confirm exemption list. Duty valued on transaction (FOB) value, plus MPF.

## C4. Fees
- Merchandise Processing Fee (MPF) formal: 0.3464% of value, min ~$33.58, max ~$651.50 (FY2026 figures - ASSUMPTION verify at CBP); informal entry MPF $2-$10 range. HMF (Harbor Maintenance Fee) 0.125% ocean only. Broker fee $75-200 per entry (ESTIMATE). Express carriers charge a disbursement/duty-advance fee $10-25/shipment (ESTIMATE).

## C5. Country-of-origin marking
- 19 USC 1304: imported article must be marked in a conspicuous place, indelible and permanent as far as practicable, "Made in India" (or "Product of India"). Carved wooden pieces: burn/stamp/engrave under base or on back; stickers can be removed. Retail package marked too. Failure = additional 10% duty and possible seizure. Marking must be visible to the ultimate purchaser. Etsy/Amazon listings must also say "Made in India" (FTC does not require it for imported goods but marketplaces show COO). Source: https://www.cbp.gov/trade/rulings/informed-compliance-publications (marking pub - ASSUMPTION).

## C6. Recordkeeping
- 5 years from date of entry (19 USC 1508; 19 CFR 163) for entry records (invoices, packing lists, HS classification support, Lacey docs). Keep Indian export docs 8 years under CGST law (ASSUMPTION). Lacey Act supplier records: keep same or longer.

## C7. Refusals, returns and RTO
- Returns from the US: goods re-entering India need shipping-bill/return procedure (courier return module in ECCS per Circular 17/2026). For duty drawback on US side: unused returned goods may qualify for 99% drawback; broker action (ASSUMPTION). Refused delivery costs: return freight + duty lost. So use DDP.
