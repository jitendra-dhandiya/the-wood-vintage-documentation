# E. US business and tax side

Prepared 2026-09-25. All ASSUMPTION unless noted; needs a US CPA [CPA] and India CA [CA]. FAST for thresholds.

## E1. Is a US entity required?
- No. A foreign (Indian) company can sell to US consumers and import as non-resident IOR without a US entity.
- Advisable later: US LLC (Delaware/Wyoming) + EIN for: Stripe US / Shopify Payments US, Amazon US account, US bank account, sales-tax registration, returns address, 3PL contract, insurance. Cost: formation $200-600 + registered agent $50-300/yr; via Stripe Atlas $500; CPA tax filing $500-2,500/yr (ESTIMATE). A foreign-owned single-member LLC files Form 5472 + pro-forma 1120 annually ($25,000 penalty if missed) [CPA]. FEMA/ODI in India for owning a US subsidiary needs CA [CA].
- EIN for a foreign company without SSN: apply by fax/phone with Form SS-4 (IRS), 2-6 weeks (ESTIMATE).

## E2. W-8BEN-E and US-source income
- Marketplaces (Amazon, Etsy via payment provider) collect Form W-8BEN-E from the Indian company (or W-8BEN if sole proprietor/individual) to certify foreign status and avoid 30% withholding on US-source FDAP. Product sales income from selling goods is generally NOT FDAP; for a foreign seller not "engaged in a US trade or business", sales of goods manufactured abroad are foreign-source when title passes outside US... Title passing rule matters (IRC 861/862/863; ASSUMPTION) [CPA].
- Engaged in trade or business / ECI: selling to US consumers online alone usually does not create US trade or business or a PE. Holding inventory in a US 3PL and selling from there may create a US trade or business under domestic law; under India-US DTAA (treaty in force since 1990) a "permanent establishment" requires a fixed place of business - storage/delivery facilities used solely for storage/delivery are excluded from PE under DTAA Art. 5(3) (ASSUMPTION; India-US DTAA has fixed-place PE; confirm text) [CPA]. Note the US has no treaty benefit needed if not ECI. Watch: agent with authority to conclude contracts = dependent-agent PE.
- Federal income tax return: if ECI, Form 1120-F required even with no tax; also a Form 5472 for LLC. Recommend CPA opinion once inventory sits in US.

## E3. State sales tax (post-Wayfair economic nexus) - FAST
- Consumers owe sales/use tax; sellers must register when they exceed thresholds. Recalled thresholds (verify each state DOR, 2026): California $500,000 sales; Texas $500,000; New York $500,000 AND 100 transactions; Florida $100,000; Washington $100,000 (no transaction count) (ASSUMPTION). Most other states $100,000 or 200 transactions (some dropped the 200 count). Sales count is measured in the previous/current calendar year for retail sales into the state.
- Marketplace-facilitator laws: Amazon, Etsy, eBay collect and remit on marketplace sales in all states with sales tax. Only DTC website sales count for your own registration (some states count marketplace sales toward thresholds).
- Physical nexus: inventory in a US 3PL/FBA warehouse creates physical nexus in that state (and Amazon FBA can move inventory across states). Must register there from day 1 of holding inventory (CA, TX, NJ, PA, IN, OH etc.) [CPA].
- Compliance: register with state DOR, collect, file/remit (Stripe Tax, TaxJar, Avalara, Quaderno; $0-$100 per month; Stripe Tax 0.5% per transaction). Set product taxability (furniture taxable in all sales-tax states). When NOT to worry yet: direct courier DDP shipments from India with title passing at the buyer's door and revenue below thresholds - monitor trailing 12-month sales by state monthly. No state income tax issue without physical presence but some states have gross-receipts taxes (WA B&O, TX franchise, OR CAT) with lower thresholds - check [CPA].
- Import duty is not sales tax. Duty is paid at entry; sales tax is on the sale to the consumer. Do not collect "duty" and "tax" as one line without saying which.
- Optional: Sales tax on DDP orders: If seller ships DDP from India and not registered, no US sales tax is collected until nexus; document your monitoring.

## E4. Cost table
| Item | Cost (ESTIMATE) |
|---|---|
| US CPA consult scoping | $300-1,000 one-off |
| LLC + EIN + agent | $500-1,500 |
| Sales tax automation | $0-100/mo |
| Form 5472/1120 | $500-2,500/yr |
