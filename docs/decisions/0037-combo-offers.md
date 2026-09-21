# 0037. Combo offers (admin-managed bundles)

Date: 2026-09-21

## Decision
Admins define **combos**: a named set of products (optional variant, quantity each) sold together at a price the admin
controls, per market. Shoppers add a combo to the bag as ONE atomic bundle line. Extends 0035 (single pricing engine and
coupons), 0036 (geo-locked market), 0032 (product availability) and the homepage section system.

## Model (migrations `combo_offers`, `combo_bundle_qty`)
- `Combo` (name, slug, description, image, badgeText, isActive, startsAt/endsAt, sortOrder, showOnHome, `pricingMode`,
  `discountValue`), `ComboItem` (product, variant?, quantity), `ComboCountryPricing` (combo x country: `isEnabled`, `value`),
  `CartCombo` (cart x combo, quantity; unique per cart), `OrderItem.comboId/comboName/bundleId/bundleQty`,
  `HomepageSectionType.COMBO_OFFERS`.
- Pricing modes: **FIXED_PRICE** (the set costs X), **PERCENT_OFF** (% off the separate total, currency-free, same in every
  market unless a row overrides it), **AMOUNT_OFF** (flat amount off). Money figures follow the coupon currency rule (0035):
  `discountValue` is the DEFAULT market's currency; every other market needs its own `ComboCountryPricing.value` in its own
  currency, otherwise the combo is not sellable there. A rupee figure is never charged as dollars.
- Availability: a market sells the combo only if it has an `isEnabled` row (opt-in, unlike products), AND every product is active,
  not deleted, not switched off for that market, and (with variant) the variant is active.

## One evaluator
`ComboService.evaluate()` (`backend/src/modules/combos/services/combo.service.ts`) decides availability and price for a market. The
storefront list/detail, the cart, the admin live preview and order creation all call it, so they cannot disagree. "Separate
total" uses the shared `unitPriceFor` (variant price > market override > sale > base), the same as `priceLines`.
Runtime gates: active, in schedule, market row, products live, price > 0 and **strictly below the separate total** (if product
prices move so the combo no longer saves, it becomes unavailable and is refused at order time rather than sold at a loss of trust).

## Pricing engine and coupon interaction (documented semantics)
- `POST /orders` and the cart/coupon preview accept `combos: [{comboId, quantity}]`. Prices in the body are never read.
- `PricingService.priceLines` prices each bundle into ONE `PricedLine` per constituent item: quantity = item qty x bundle qty,
  `lineTotal` = the item's share of (combo price x bundle qty), allocated by its share of the separate total with the
  remainder on the last line, so the lines sum exactly to the combo price. `onSale` is true, `comboId/bundleId` set.
- **Coupon applies to the post-combo subtotal.** A whole-cart coupon (percentage/fixed/free-shipping, min order, caps) counts combo lines at combo prices.
- `excludeSaleItems` treats combo lines as **sale lines** (excluded). Product/category-scoped coupons **do not apply to combo lines**
  (they only see plain lines, even for the same product). Still ONE coupon per order.
- Delivery: per-product shipping overrides consider every constituent; free-shipping threshold uses the post-combo, post-coupon subtotal.
- Stock: checked for every item across plain lines and bundles together (aggregated per product); a combo with any out-of-stock item
  returns `COMBO_OUT_OF_STOCK` naming the item. Order creation decrements every constituent (`totalSold`, InventoryLog "Order placed (combo: X)").
  Cancel (`POST /orders/:id/cancel`) restores every constituent because they are order items, and releases the coupon as before.
  (Admin status change to CANCELLED still does not restore stock: pre-existing gap from 0035.)
- Orders keep `comboId` (nullable FK, SET NULL), `comboName` snapshot, `bundleId` (one per combo per order), `bundleQty`. Line price/total
  are the allocated share, labelled "share of combo price" in admin. Admin/account order pages show a "Combo: X" chip.

## Cart: bundle is atomic
The cart returns `combos[]` (server-priced for the visitor's market via `enforceRequestCountry`, with a `problem` string when
unavailable/out of stock). Only whole-bundle quantity change and remove are offered; items inside cannot be edited. To buy
part of a set the shopper adds those products from their pages. Adding the same combo again bumps the bundle quantity.
Checkout is blocked with the reason while any bundle has a problem. `DELETE /cart/clear` clears bundles too.

## API
Public (geo-locked; `?country=` is a claim that the located market overrides): `GET /combos?home=&productId=&limit=`, `GET /combos/:slug`
(404 if not offered in the market). Cart: `POST /cart/combo/add`, `PUT/DELETE /cart/combo/:id`, `GET /cart?country=`.
Admin (ADMIN, SUPER_ADMIN, SUB_ADMIN like other catalogue CRUD), under `/combos/admin`: `list`, `preview`, create (multipart, `image`), `GET/PUT/DELETE :id`,
`PATCH :id/active`, `POST :id/duplicate`. Input is whitelisted. Validation (422): >= 2 items (units), no duplicate product+variant line, products
active, products with options need a variant, >= 1 enabled market, percent 0-100, end after start, per-market price required
and below that market's separate total. Delete is refused (409 `COMBO_ORDERED`) once ordered: deactivate. Duplicate copies the image file, comes out inactive.
The list shows default-market price/savings, markets, **sets sold and revenue** (from non-cancelled/returned/refunded orders).

## Storefront
- Homepage: new section type `COMBO_OFFERS` (chosen over a hard-coded block so the admin positions/hides it in the Homepage Builder;
  the seed places it after "Shop by Craft"). It shows combos flagged `showOnHome`, fetched from `GET /combos` client-side so the
  market lock applies; renders nothing when empty.
- `/[country]/combos` list, `/[country]/combo/[slug]` detail (SSR metadata, canonical only (combos exist in some markets so no
  hreflang), JSON-LD `Product` + `Offer` + `BreadcrumbList`; breadcrumb row is positioned above the sticky image column and verified clickable
  with `elementFromPoint`), product-page block "Complete the set, save with a combo", cart page + drawer bundle lines, checkout summary. Sitemap lists combos per market.
- Seed: Kitchen Starter Set (fixed 5499 / $84), Living Room Accent Set (15% off), Gifting Trio (1270 / $17 off) in `prisma/seed-data/combos.ts`,
  create-if-missing (never overwrites admin edits), run by `seed:handicraft` or alone via `npm run seed:combos`.

## Limits / follow-ups
- Stock is product-level (as for plain items), not per variant.
- The checkout's no-coupon shipping estimate (client side, pre-existing) does not read shipping overrides of products that are only inside a combo; the server total is authoritative and used whenever a coupon is applied.
- No combo analytics events beyond the existing ADD_TO_CART; no per-line discount allocation for partial returns (returns of a combo line are treated as ordinary lines).
- Admin-cancel stock restore gap (0035) still open.

## Verification (2026-09-21)
71-check real-HTTP suite: admin validation, multipart image create, preview per market, duplicate, IN vs US public lists, `?__geo=US` claim
override, cart bundle (bump/atomic), preview == order with coupon, tampered prices ignored, order items reference the combo, exact allocation,
stock per constituent, cancel restores stock and coupon usage, US order at the USD price, geo mismatch 403, out-of-stock/inactive/expired/
not-started/no-saving rejected, delete rules, sub-admin allowed. Headless Chrome screenshots at 1440 and 390. Test data removed.
