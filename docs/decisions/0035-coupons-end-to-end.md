# 0035. Coupons end to end

Date: 2026-09-21

## Decision
One server-side pricing engine (`backend/src/modules/pricing/pricing.service.ts` `quote()`) and one coupon
service (`modules/coupons/services/coupon.service.ts`) now decide every coupon discount. The cart preview,
checkout preview and `POST /orders` all call `quote()`, so a preview cannot differ from the charged total.
Extends 0003 (server-authoritative pricing), 0009/0027 (country/currency), 0032 (availability), 0033 (motion).

## Audit: what was broken
- Order creation matched the code case-sensitively, never enforced `userLimit`, and bumped `usageCount` with a
  read-then-write (limit overshoot under concurrency). Nothing recorded who used a coupon.
- An invalid/ineligible coupon was silently ignored (order at full price) yet `couponCode` was still stored on the order.
- `/cart/coupon` trusted a client-sent `cartTotal`; `/coupons/validate` ignored `startsAt` and the public
  `/coupons/:code/check` leaked the whole row. Error text hard-coded "₹".
- A FIXED/min-order amount (rupees) was applied in any currency; rounding was absent; BUY_X_GET_Y validated and did nothing;
  `applicableTo` was never read. Admin create/update spread `req.body` into Prisma (could set `usageCount`, `id`).
- Cancelling an order never gave the coupon back. The cart page passed `?discount=` through the URL. WELCOME10 said
  "first order" but nothing enforced it. The admin form had no rules beyond min/limit/expiry and no usage view.
- Order/checkout total used a rupee free-shipping threshold in every currency (fixed here for non-default markets).

## Rules (exact semantics)
- One coupon per order. Code is trimmed/upper-cased. Errors are `400` with a machine code (`COUPON_EXPIRED`,
  `COUPON_MIN_ORDER`, `COUPON_EXHAUSTED`, `COUPON_USER_LIMIT`, `COUPON_FIRST_ORDER_ONLY`, `COUPON_WRONG_COUNTRY`,
  `COUPON_NOT_APPLICABLE`, ...) and a shopper-readable message. At order time a failing coupon REJECTS the order
  (nothing charged) instead of silently dropping it.
- Types: PERCENTAGE, FIXED, FREE_SHIPPING. **BUY_X_GET_Y is unsupported** (no per-product buy/get model; combos in
  workstream B cover it): hidden from admin, rejected on create, refused at evaluation. Enum value kept (no destructive migration).
- Discountable amount = lines matching `productIds`/`categoryIds` (descendant categories included), minus on-sale
  lines when `excludeSaleItems` (on sale = sale price below the regular price in that market; variant-priced lines count as not on sale).
  Min order is judged on that amount. Percentage = round2(amount * pct), capped by `maxDiscount`; FIXED = value; both
  capped at the eligible amount, hence never above the subtotal. FREE_SHIPPING waives the remaining delivery charge
  (after country rule / per-product / free-shipping threshold); the waived amount is snapshotted.
- Currency: base columns (`value`, `minOrderAmount`, `maxDiscount`) are in the DEFAULT market's currency.
  Another market gets money terms only from `countryTerms` (its own currency); otherwise the coupon is refused there
  (`COUPON_WRONG_COUNTRY`). A percentage without money rules is currency-free. `countryCodes` scopes markets.
  A request with no country is judged as the default market. Amounts round half-up to 2dp.
- Limits: `usageLimit` (global), `userLimit` (per customer, null = unlimited, default 1), `firstOrderOnly`
  (no earlier non-CANCELLED order), dates, `isActive`. In the order transaction the coupon row is locked
  (`SELECT ... FOR UPDATE`), usage is re-read with locking reads (InnoDB REPEATABLE READ would otherwise miss a
  concurrent commit), and the increment is also conditional (`usageCount < usageLimit`). Verified with 6 parallel orders on a limit-1 coupon (1 wins) and 4 parallel orders by one user on a per-user-1 coupon (1 wins).
- `CouponUsage` (coupon, user, order unique, amount = discount + shipping waived, currency, `revertedAt`, reason).
  Cancel (`POST /orders/:id/cancel`) and admin status CANCELLED/RETURNED/REFUNDED stamp `revertedAt` and decrement
  `usageCount` in the same transaction; idempotent. Rows are kept for the report. Orders store `couponCode`, `couponType`,
  `couponDiscount`, `couponShippingDiscount` (only when actually applied).
- Guests: may preview (session cart); per-customer rules (first order / per-user limit) cannot be checked, so the
  response carries `needsLogin` and the UI says it will be confirmed on sign-in. Ordering requires login and re-checks everything.
- Public coupons (`isPublic`) appear as "Available offers" via `GET /coupons/offers?country=` (no limits/usage exposed). WELCOME10 is public and now really first-order-only.

## API
Storefront: `POST /coupons/validate` (alias `POST /cart/coupon`; body `{code, country?, shippingMethod?}`, prices the requester's own
server cart, returns discount/subtotal/shipping/total/currency), `GET /coupons/offers`. Admin: `GET/POST /coupons`,
`GET/PUT/DELETE /coupons/:id`, `PATCH /coupons/:id/active`, `GET /coupons/:id/usages` (report + summary). Delete is refused (409) once used: deactivate instead. Input is whitelisted and validated (422).

## Frontend
`hooks/useCoupon.ts` (only the code is stored, `wv_coupon`; every figure re-fetched from the server when cart/market/shipping change; stale codes are removed with the reason),
`components/cart/CouponBox.tsx` (input, loading spinner, inline server errors, offers, applied chip with tick draw + saving-row flash; CSS only, transform/opacity, reduced motion honoured per 0033), used by cart and checkout. `formatPrice` now keeps cents for fractional amounts. Admin: list with status/rules/uses, quick toggle, full form dialog (`CouponFormDialog`), usage report (`CouponUsageDialog`). Account/admin order pages show coupon code and waived delivery.

## Not done / limits
- No order confirmation email or invoice exists in this codebase yet; the order snapshot fields are ready for them.
- Online-payment orders abandoned in PENDING keep their redemption until cancelled; there is no expiry job.
- Discount is not allocated per order line (matters for partial returns/refunds); GST `taxAmount` is still computed on the pre-discount subtotal (display only, unchanged).
- Admin cancel via status change does not restore stock (pre-existing); it does release the coupon.
- Combo offers (B) should price bundle lines inside `PricingService.priceLines`; the coupon then applies to that subtotal.
