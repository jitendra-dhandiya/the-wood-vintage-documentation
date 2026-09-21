# Plan: coupons end-to-end, combo offers, geo-locked country

Date: 2026-09-21. Three workstreams, ordered by dependency.

## 1. Coupon codes end to end (Agent A)
Existing: `Coupon` model (PERCENTAGE / FIXED / FREE_SHIPPING / BUY_X_GET_Y, min order, max discount,
usage limit, per-user limit, dates, `applicableTo`), coupon module, admin page, cart/checkout hooks.
Unknown: how much of it truly works. Scope = audit, then make the whole loop correct:
- Server-authoritative validation and discount maths in ONE service used by cart preview, checkout
  and order creation (never trust client amounts); currency/country aware (fixed amounts per
  country/currency — a ₹500 coupon must not be $500); rounding; discount never exceeds subtotal.
- Rules: active/dates, min order, max discount cap, global + per-user usage limits enforced
  atomically at order time (race-safe), first-order-only, category/product applicability,
  excludes already-sale items option, free-shipping type, stacking policy (default: one coupon).
- Usage tracking: `CouponUsage` (coupon, user, order, amount) so limits/reporting are real; usage
  reverted when the order is cancelled/refunded.
- Storefront: apply/remove UI in cart + checkout with clear errors, animated success, auto-applied
  announcement code; order summary shows the discount; order + invoice + emails store it.
- Admin: create/edit with all rules, per-country scope, activate/deactivate, usage report, expiry.
- Tests via real HTTP + real order (cancel through the real flow, restore coupon usage).

## 2. Combo offers managed by admin (Agent B, after A — shares pricing code)
- `Combo` (name, slug, description, image, items[product+variant?+qty], pricing: fixed combo price
  per country/currency OR % / amount off the item total, active window, stock behaviour, per-country
  availability, badge text) + admin CRUD (product picker, live "you save" preview, image, schedule).
- Storefront: combo cards/section on home + product page "Frequently bought / Complete the set",
  combo detail page or drawer, add-combo-to-cart adds the items as one linked bundle at the combo
  price; cart shows the bundle, removing one breaks the offer clearly; stock is checked for every item.
- Pricing engine: server-authoritative; interaction with coupons defined (coupon applies on the
  post-combo subtotal, stacking rules documented); order items keep combo reference for reporting;
  cancellation restores stock of every item.

## 3. Country locked by location, no user-facing switcher (Agent C, parallel with A)
- Remove the country selector from the UI (navbar/footer/mobile) — visitors cannot choose.
- Detect the visitor's country from IP geolocation (lat/lng + country from an offline GeoIP DB
  such as `geoip-lite`, plus trusted CDN headers `cf-ipcountry` / `x-vercel-ip-country` when present).
  Resolution lives in the backend (`GET /geo/resolve`, node runtime) because Next middleware runs
  on the edge runtime; middleware calls it (cached briefly) forwarding the client IP.
- Enforcement: a visitor located in US who opens `/in/...` is redirected to `/us/...` (same path);
  if their country has no enabled market, show a designed "not available in your region yet" page
  (or fall back to the default market — decision recorded; recommended: default market with a
  banner is friendlier, but the user asked for lock, so: redirect to their market if enabled,
  otherwise the region page).
- Exempt: `/admin*`, API, static assets, and verified search-engine crawlers (Googlebot/Bingbot UA
  + reverse-DNS not practical here, so UA-based with a documented risk) so international SEO and
  hreflang keep working. Localhost/private IPs resolve to the default market.
- Dev/test override: `GEO_DEV_OVERRIDE=US` env or `?__geo=US` (non-production only) so behaviour
  is testable from one machine.
- Honest limits (documented): IP location is approximate; VPN users can spoof it; browser
  Geolocation lat/lng needs a permission prompt so IP-derived coordinates are used instead.
- Server-side too: orders/pricing use the country resolved server-side from the request, not the
  URL, so URL tampering cannot buy at another market's price.

## Order of work
A and C in parallel → verify → B → verify → docs (decisions 0035–0037), push.
