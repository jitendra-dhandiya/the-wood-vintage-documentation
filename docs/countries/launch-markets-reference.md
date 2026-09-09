# Launch Markets — Reference Data

Objective, verifiable reference data (ISO codes, currencies, timezones) for the 8 markets named in
`MASTER-PROMPT.md` §0/§7, to seed the `Country` model in
`docs/architecture/country-architecture-spec.md`. **This is factual reference data only** — ISO
standards, not business assumptions. It does **not** include AOV, price sensitivity, popular
categories, competitor lists, or other market-research findings that MASTER-PROMPT §4D calls for —
those require real research (and in several cases, real sales/analytics data this platform doesn't
have yet), and belong in a separate `docs/countries/<code>.md` per market once that research
happens. Fabricating those numbers here would be worse than not having them.

| Country | ISO code | Currency | Symbol | Suggested locale | Primary timezone(s) | Note |
|---|---|---|---|---|---|---|
| India | `IN` | INR | ₹ | `en-IN` | `Asia/Kolkata` (single zone, UTC+5:30) | Default/home market — existing `unique-dressup` operates here today |
| United Arab Emirates | `AE` | AED | د.إ | `en-AE` | `Asia/Dubai` (UTC+4) | |
| United States | `US` | USD | $ | `en-US` | Spans `America/New_York` to `America/Los_Angeles` (UTC-5 to UTC-8, plus Alaska/Hawaii) | Multi-timezone — display/delivery-estimate logic must not assume a single US timezone |
| Australia | `AU` | AUD | $ | `en-AU` | Spans `Australia/Perth` to `Australia/Sydney` (UTC+8 to UTC+11, DST varies by state) | Multi-timezone; DST rules differ by state |
| United Kingdom | `GB` | GBP | £ | `en-GB` | `Europe/London` (UTC+0/+1 DST) | |
| Germany | `DE` | EUR | € | `de-DE` | `Europe/Berlin` (UTC+1/+2 DST) | |
| France | `FR` | EUR | € | `fr-FR` | `Europe/Paris` (UTC+1/+2 DST) | |
| Netherlands | `NL` | EUR | € | `nl-NL` | `Europe/Amsterdam` (UTC+1/+2 DST) | |

"Other European markets" (MASTER-PROMPT §0) is intentionally left open — no specific additional
countries were named, and the `Country` model is designed (per the architecture spec) so adding one
is a config row, not a code change, whenever a specific market is chosen.

## What's deliberately NOT decided here

- **Locale/content-language strategy.** The `locale` column above (`de-DE`, `fr-FR`, `nl-NL`) is a
  reasonable *technical* default for number/date/currency formatting, but does **not** imply a
  decision that the storefront's actual content (product copy, marketing, UI strings) will be
  translated into German/French/Dutch. That's a real content/marketing investment decision — see
  "Localization scope" below — not something to assume from a locale code.
- **Per-market business research** (AOV, price sensitivity, popular categories/materials, shipping
  expectations, competitors) per MASTER-PROMPT §4D. Needs real research or real data once the
  platform has sales history; not fabricated here.
- **Payment provider per market** — flagged in the discovery report §8/§16: Razorpay/Cashfree
  don't meaningfully cover any of the 7 non-India markets above. Needs a real vendor decision.
- **Tax/import/customs handling per market** — genuinely needs either real tax expertise input or
  a decision to launch initially without automated tax calculation (manual/estimated) for
  non-India markets. Not decided here — flagging so it isn't silently assumed away when country
  pricing ships.

## Localization scope (Phase 1)

**Decision for Phase 1 only, not a final call on full translation:** ship locale-aware
*formatting* (currency symbols, number/date formats per the table above) for all 8 markets from the
start — this is cheap, low-risk, and expected by any international shopper. Ship UI/content
*translation* (actual German/French/Dutch copy) as a **separate, later decision** — the content
model already supports it (Global → Country → Language inheritance per MASTER-PROMPT §30, in the
architecture spec), so adding real translations later is additive, not a rearchitecture. Shipping
English-only content to EU markets initially is a real product/conversion tradeoff someone should
consciously decide, not something this spec should quietly assume — flagged in
`tasks/TASKS.md` as a question for the user/product owner before Phase 3 content work locks it in.
