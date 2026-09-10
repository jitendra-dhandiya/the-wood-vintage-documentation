# 0012. Phase 2 backend implemented; carousel hydration gap closed, shipping-display gap narrowed

Date: 2026-09-10

## Decision

Implemented the Phase 2 (Handicraft Domain) backend per the earlier spec — `Material`/`Style`/
`Room`/`Artisan` models, seed data, CRUD modules, product filters/fields
(`wood-vintage/backend` commit `59964a4`). Separately, used a newly-discovered local headless
Chrome capability (`0011`'s skills-log entry) to close the carousel-hydration verification gap
from `0007` for real, and partially narrow the checkout shipping-display gap from `0011`.

## What was built — Phase 2 backend

Delegated to a background agent against the existing spec. Matches the spec closely:
`Material`/`Style`/`Room` (11/11/8 seeded rows — Room list wasn't specified in MASTER-PROMPT, the
agent chose Living Room/Bedroom/Dining Room/Kitchen/Home Office/Outdoor & Patio/Entryway/Kids
Room, a reasonable standard furniture-catalog set), `Artisan` (correctly left unseeded — no real
artisan data exists yet), CRUD modules following the `Country` module's established pattern, and
`?materialSlug=&styleSlug=&roomSlug=` product filters. Migration `20260910043130_add_handicraft_domain`
applied via normal `prisma migrate dev` — notably, the "non-interactive environment" issue that
required a hand-written migration for `0010`'s CMS fix did **not** recur here, suggesting it's
specific to migrations needing a destructive-change warning (a new unique constraint), not a
general environment limitation.

## Verification

Independently re-verified, not just trusted: confirmed the real commit, clean `npm run build`,
`prisma migrate status` reports up to date, and — most importantly — **queried the DB directly**
for the seeded counts (`materials=11, styles=11, rooms=8, artisans=0`) rather than accepting the
agent's numbers, and they matched exactly. Read `material.controller.ts` directly: clean,
consistent with the `Country` module's conventions, correct slug-uniqueness handling, correct
`ON DELETE SET NULL` reasoning for the taxonomy-deletion case. Booted both servers myself and
independently re-ran the filter check (`?materialSlug=sheesham` → 0, matching the agent's own
cleanup; `?materialSlug=nonexistent-xyz` → 200 with an empty list, not an error).

## Closing the disclosed verification gaps

While investigating why `claude-in-chrome` kept failing (`0007`, `0011`), found the actual cause:
it drives the *user's own* Chrome on their machine, which has no route to this sandbox's
`localhost` — architectural, not transient. Found a real alternative: `google-chrome` is installed
as a system binary in this sandbox and can run headless directly against `localhost` with no new
dependency (`--headless=new --dump-dom`/`--screenshot`). Logged in `skills/SKILLS.md`.

Used it to:
- **Close `0007`'s carousel-hydration gap for real.** Loaded the homepage headless, dumped the
  post-JS DOM, and found `swiper-initialized`, `swiper-slide-active`, and
  `swiper-pagination-bullet-active` — classes Swiper's JS runtime only adds after a real
  `new Swiper()` initialization on the live DOM, never present in SSR markup alone. No error-page
  text anywhere in the dump. This is genuine proof the post-upgrade carousels hydrate and function
  correctly, not just that the SSR markup looks right. **`0007`'s disclosed gap is now closed.**
- **Partially narrow `0011`'s shipping-display gap.** Loaded `/checkout` headless with an empty
  cart — confirmed it renders without a JS crash (284KB of real content, no error-boundary text),
  which validates the new `cart?.items ?? []` optional-chaining path doesn't break the page. **Not
  fully closed**: verifying the actual override calculation requires a populated cart with a
  product that has a shipping override, which needs either real UI interaction (add-to-cart click)
  or scripting the Chrome DevTools Protocol directly to seed `localStorage`/session state before
  navigating — assessed as disproportionate effort against the risk (the logic is a few lines,
  already a direct line-by-line mirror of the real-exploit-tested backend calculation) and not
  done in this pass. Left as a known, narrower remaining gap rather than closed by inflated claim.

## Consequences

- `tasks/TASKS.md`'s carousel-verification follow-up (added after `0007`) is done and can be
  checked off.
- The shipping-display verification gap from `0011` is downgraded from "no verification at all
  possible" to "baseline crash-safety confirmed, full calculation still unverified in a real
  browser" — a real, if partial, improvement, not fully resolved.
- `skills/SKILLS.md`'s headless-Chrome finding is now proven useful in practice, not just
  theoretically — worth reaching for first on any future browser-verification need in this sandbox.
- Phase 2 backend is done; Phase 2 frontend (material/style/room display and filters, artisan bio
  rendering, craft story on product pages, admin UI for the new taxonomy screens) is the natural
  next piece, not yet started.
