# 0011. Checkout now shows the real per-product shipping override

Date: 2026-09-10

## Decision

Fixed the shipping-display gap tracked in `technical-debt.md` since the order-pricing fix
(`0003`): checkout showed the flat `SHIPPING_METHODS` rate regardless of any per-product shipping
override, while the backend (correctly) charged the override when one was set on a cart's
products. Fixed by mirroring the backend's exact calculation client-side.

## Why

No backend change was needed — the cart/product APIs already return
`standardShippingCharge`/`codShippingCharge`/`expressShippingCharge` on `CartItem.product` (they
use Prisma `include`, which returns all scalar columns, not a restricted `select`). The gap was
purely that the frontend `Product` TypeScript type didn't declare those fields and checkout never
read them — a frontend-only fix.

## Chosen approach

Added the three fields to `types/index.ts`'s `Product` interface, and replaced checkout's flat
`shippingCharge = selectedShipping.charge` with the same max-across-cart-items override logic
`order.service.ts` already uses server-side. `wood-vintage/frontend` commit `76c55e4`.

## Verification — and its limit, disclosed honestly

`tsc --noEmit` and `npm run build` both pass. The logic is a direct line-by-line match of the
already-verified (real exploit-tested, per `0003`) backend calculation — same field names, same
"take the max across items" rule, same fallback to the flat rate.

**Not live/browser verified.** Checkout is a `'use client'` component — its rendered shipping
figure only exists after client-side hydration, so it can't be checked via `curl` the way
SSR-rendered pages were verified earlier in this session (e.g. the Country pricing check in
`0010`). The `claude-in-chrome` browser tool has been confirmed twice this session unable to reach
this sandbox's `localhost` (see `0007`'s disclosed gap for the Swiper carousels). This fix is
therefore in the same "build-verified, not runtime-verified" category as that one — tracked
together as a real-browser follow-up, not claimed as fully done.

## Consequences

- `technical-debt.md`'s shipping-display entry is closed as fixed, with the verification caveat
  carried forward rather than dropped.
- Combined with the carousel-hydration gap from `0007`, there are now two related open items that
  both need the same thing: a real browser reachable from this environment. Worth solving once
  (e.g. a different browser-automation path, or manual verification by the user) rather than
  separately for each.
