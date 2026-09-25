# 0039. Handicraft "Size / Dimensions" and "Finish" system

Date: 2026-09-25

## Decision
The variant controls were still fashion-shaped (XS-XXL chips, waist runs, "Size Guide", "Colour"). They are
replaced by a handicraft/furniture vocabulary: **Size / Dimensions** and **Finish**, with category-aware
presets, a custom dimension builder, smart ordering and consistent display everywhere a variant appears.

## Data model (no schema change, no production migration)
`ProductVariant.size` stays ONE display string; `color` is the Finish name (`colorHex` still derived from the
name, wood finishes added to `colorName.ts`). Structured dimensions are DERIVED from the label by
`parseSizeLabel` (`frontend/lib/handicraftSize.ts`), never stored twice, so old variants stay valid and the
admin can re-open any saved label in the builder. Label grammar: `Queen (5×6.5 ft)`, `4-Seater`,
`Medium (90 × 40 × 85 cm)`, `60 × 40 × 75 cm`, `Ø 45 cm`, `500 ml`, `Set of 4`, optional ` · 18 kg`.
Max 60 chars. Alternate units shown from the label ("152 × 198 cm · 60 × 78 in"; ft shows cm and in).
Existing per-product Craft & Dimensions (`lengthCm/widthCm/heightCm`) is unchanged; variants are per-size.

## Vocabulary
Size / Dimensions, Finish (was Size, Colour/Color). No size chart/guide. Storefront filter: no size filter
(sizes are per product); Finish filter kept (Natural/Walnut/Honey, `PRODUCT_FINISHES`, API param still `colors`).

## Presets (chips + "Add set"; family follows the product category, admin can switch)
- Beds: Single (3×6 ft), Double (4×6 ft), Queen (5×6.5 ft), King (6×6.5 ft); sets Queen+King, Single to King.
- Tables & Desks: 2/4/6/8-Seater; Small/Medium/Large; sets 4+6, 2 to 8.
- Chairs & Stools: Single, Set of 2/4/6.
- Cabinets & Shelves: Small/Medium/Large (add L×W×H in the builder).
- Wall Art & Mirrors: Ø 30/45/60 cm and W×H 30×45, 45×60, 60×90 cm (in inches when the unit toggle is in).
- Décor, Toys & Kitchen: Mini..Large, Set of 2/3/4/6, 250 ml / 500 ml / 750 ml / 1 L.
- Custom: Standard, Small/Medium/Large, Set of 2/4.
Custom builder: optional name, Length/Width/Height (or Diameter), cm/in/ft toggle, optional weight, validation
(positive, unit-aware maximum), live preview label plus other-unit reading. Free-text list entry also works.

## Admin
Add page: finishes as blocks (quick-add Natural/Walnut/Honey/Teak/...), one picker whose sizes go to EVERY finish
(the sizes x finishes matrix in one click), per-variant stock and price, "copy sizes from first finish".
Edit page: table shows Size / Dimensions with alternate units; dialog has finish chips, size field + presets/
builder, SKU, price override, active; "Bulk add" dialog generates sizes x finishes and skips existing combos.

## Ordering (`sortSizes`, replaces the fashion sort; tested by `npm run test:size`)
Groups, in order: (0) named rank - Mini < Small < Medium/Standard < Large < Extra Large < Jumbo, then Single <
Double < Queen < King < Super King; legacy S/M/L/XL letters keep a rank; (1) N-Seater / Set of N by count;
(2) capacities by ml; (3) numeric dimensions by length (1 dim), area (2) or volume (3), all in cm; (4) alphabetical.
Ties are stable; comparison is a total order.

## Backend
`utils/sizeLabel.ts`: normalise (trim, collapse spaces, typed x between numbers -> ×, strip control chars, legacy
apparel size -> Mini/Small/Medium/Large/Extra Large/Standard), max 60 chars (422), case/space-insensitive
duplicate size+finish per product (409 on single create/update, silently de-duplicated in the product-create
bulk payload). Export headers renamed. Combo admin message reworded.
**Price fix found on the way:** the pricing engine ignored `ProductVariant.salePrice`, so seeded size variants
(price = list, salePrice = selling) were charged list price. `unitPriceFor` and cart add now honour a variant sale
price (sale < price). The product page shows the chosen variant's price (default market only; variant prices are
still base-currency, gap noted in 0032).

## Storefront
Product page: "Size / Dimensions" + "Finish", alternate units line, sold-out sizes for the chosen finish disabled,
finish required when finishes exist, low-stock line names the selection. Cart, drawer, account/admin order,
combo detail/cart line, combo admin picker: "Size: Queen (5×6.5 ft) · Finish: Walnut" (or compact "Queen / Walnut").
Quote modal shows "Your selection"; WhatsApp message and the lead `requirement` include it.

## Seed / data
`catalogue.ts` labels updated (Queen (5×6.5 ft), King (6×6.5 ft), 6/8-Seater with L×W×H); size variants added
to Teak Planter Box, Acacia Round Chopping Board, Sun Mandala Wall Art, Jodhpur Sideboard. Idempotent.
`npm run variants:migrate-sizes [-- --apply]` (dry run by default) maps old apparel/seed labels; skips collisions.

## Production
No `prisma migrate`. Deploy backend + frontend, then run `npm run seed:handicraft` (or `variants:migrate-sizes -- --apply`
if only the labels should change; the seed also re-creates catalogue variants).

## Verified
Local: API create of a Bed (Queen/King x Natural/Walnut) incl. duplicate/too-long/legacy rejections, admin UI
add/edit/bulk screenshots at 1440 and 390, storefront selection, cart, real COD order (size/finish snapshot),
cancel via `POST /orders/:id/cancel`, seeded Queen now 64,900 (was list price), test data removed (46 products, 0 orders).

## Gaps
Structured L/W/H is derived, not queryable in SQL; no size facet in search; variant price still base-currency;
category-to-preset matching is keyword based (unknown categories get "Custom" and a family switch).
