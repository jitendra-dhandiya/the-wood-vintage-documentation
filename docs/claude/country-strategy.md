# Country Strategy

Target markets (MASTER-PROMPT §0/§7): India, UAE, USA, Australia, UK, Germany, France, Netherlands,
other European markets. Architecture must allow adding more without major code changes.

Per-country research (customer preferences, AOV, popular categories, materials, price sensitivity,
shipping/delivery/return expectations, payment preferences, currency, tax, import considerations,
SEO language, search intent, seasonal demand, competitors — MASTER-PROMPT §4D) belongs in
`../countries/<country-code>.md`, one file per country. **Do not assume India and USA customers
behave identically** — each needs its own research, not a copy-paste.

No per-country files created yet — this is Phase 3 (Internationalization) / Phase 4 (Experience)
work. Country *architecture* (the config model itself) is Phase 1, tracked in `architecture.md`.
