# 0033. Motion and loading states

Date: 2026-09-21

## Decision
Add premium motion and complete loading/empty states across storefront, account and admin using
CSS + one shared IntersectionObserver hook. No new dependency. framer-motion (already present) stays
only where it already was (mega menu, cart drawer, some sections); the homepage scroll reveals no
longer use it.

## Why
Home reveals via framer-motion server-rendered `opacity:0` (content invisible until hydration, and
framer is switched off < 900px by MobileMotionConfig, so phones got inconsistent behaviour). Several
routes had no `loading.tsx`, the cart flashed "Your bag is empty" before its first fetch, admin tables
showed a lone spinner, and the nav progress bar only appeared after navigation had finished.

## Approach
- **Reveal** (`components/common/Reveal.tsx`, `hooks/useReveal.ts`, CSS in `globals.css`): content is
  visible in SSR and when already on screen at mount; only below-the-fold elements are hidden in a
  layout effect (pre-paint) and shown by one shared IntersectionObserver. No-JS/observer-less/reduced
  motion = plain visible content. `index` staggers 60ms per step (capped at 8). Transform/opacity only.
- **Hero** entrance is CSS-only (`.hero-rise`, opacity starts at 0.001, 0.7s) so text never waits on JS.
- **CountUp** for craft-story stats: final text stays in the DOM and sizes the box; an aria-hidden overlay
  counts up (rAF, no React renders), so no CLS.
- **Micro-interactions**: `.pop` (wishlist heart), `.badge-bump` (bag badge on add, not on load), card image
  zoom + quick-add spinner, optimistic wishlist with rollback, MUI `Button loading` on add-to-bag,
  checkout submit guarded against double submit.
- **Loading**: `loading.tsx` for product, category, collection, room/material/style, artisans (+detail),
  blog post, cart (plus existing home/shop/search/checkout/blog/collections/categories/account/admin).
  Skeletons live in `components/common/Skeletons.tsx` (`ProductDetailSkeleton`, `CartSkeleton`,
  `ArticleSkeleton`, `TableSkeletonRows`, ...). MUI Skeleton is themed cream/walnut in `themes/index.ts`.
  Cart drawer shows skeleton rows; cart page shows a skeleton until the first fetch settles.
- **NavigationProgress** now starts on the click of any internal link (document capture listener, works
  for `/in/...` prefixed routes), appears only if still pending after 120ms, completes on pathname/search
  change.
- **EmptyState** component for cart, wishlist, orders.

## Dependency decision
No framer-motion expansion, no new package. Bundle impact measured with `npm run build`: shared first-load JS
unchanged at 102 kB; home 287 -> 288 kB, PDP 266 -> 267 kB, cart 231 -> 235 kB, admin lists +5-6 kB (Skeleton).

## Reduced-motion policy
`prefers-reduced-motion: reduce` = no movement, instant states. Reveals never hide, CountUp shows final
value, hero autoplay/Ken Burns/progress off, and a catch-all rule in `globals.css` zeroes remaining CSS
animation/transition durations (spinners and the nav progress bar are status indicators and keep running).
`MobileMotionConfig` now uses `reducedMotion="user"` on desktop (was `never`). HeroSlider reads the media
query in an effect (not at render) to avoid a hydration mismatch.

## How to add
- **Reveal**: `<Reveal index={i}>...</Reveal>` (or `Reveal` from `home/craft/shared`). Wrap the item, not the grid.
- **Skeleton**: build it from `Skeletons.tsx` using the same aspect ratios/heights as the real component,
  add `loading.tsx` next to `page.tsx` exporting it. Client-fetched data: render the skeleton until the first
  fetch settles (guard with a `mounted` flag to keep hydration identical).
- **Button**: MUI `loading` prop, or disable + inline `CircularProgress`; guard the handler against re-entry.

## Gaps
- Mega menu, cart drawer and toasts keep their existing transitions (framer/MUI/react-hot-toast); not reworked.
- Most admin forms still use spinner/`startIcon` loading rather than per-form skeletons; admin pages besides
  orders/products/settings/marquee keep their existing loaders.
- framer-motion is still disabled below 900px by MobileMotionConfig (dev logs a reduced-motion warning).
- Skeleton screenshots were taken from a temporary route (real loading.tsx only streams on slow SSR).
