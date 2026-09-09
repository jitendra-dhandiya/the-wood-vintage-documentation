# Business Rules

Domain rules specific to the handicraft/furniture business that aren't obvious from code — pricing
rules per country, tax handling, made-to-order/customization terms, B2B/bulk enquiry handling,
warranty and returns policy for handcrafted goods, export/shipping constraints per country.

See MASTER-PROMPT §17 (international pricing), §18 (shipping), §33 (product storytelling
answers "what's the warranty/damage policy"), §34 (trust architecture).

Nothing captured yet — depends on business decisions not yet made (pricing model, warranty terms,
per-country tax handling). Populate as those are decided; each should also get a
`../decisions/` record if it constrains implementation.
