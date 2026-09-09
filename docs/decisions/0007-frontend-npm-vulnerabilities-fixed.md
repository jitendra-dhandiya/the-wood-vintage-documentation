# 0007. Frontend npm vulnerabilities: all fixed, no deferred work

Date: 2026-09-09

## Decision

Applied all available fixes for the frontend's 2 critical + 7 high npm vulnerabilities
(`docs/claude/technical-debt.md`, originally flagged 2026-09-09 after `npm install`). Result:
`npm audit` now reports 0 vulnerabilities. Nothing deferred.

## Why

This was delegated to a background agent (see the session's work log) with an explicit instruction
to only keep a breaking dependency bump if it verifiably still worked, and to revert and report
back honestly rather than force through untested changes. The outcome turned out better than the
original technical-debt entry anticipated: `swiper`'s major-version jump (11.x → 14.x, flagged by
npm as breaking) didn't actually require any component changes — both real usages
(`HeroSlider.tsx`, `TestimonialsSection.tsx`) already used the modern `swiper/react` API, which
Swiper's own changelog confirms is unchanged across that range.

## What was fixed

- `next`: `15.5.19` → `^15.5.25` — patches the critical unauthenticated RCE (Windows-hosted
  servers), AVIF Image Optimization RCE, SSRF, and DoS CVEs. Patch/minor bump, no code changes.
- `swiper`: `^11.1.14` → `^14.2.0` — patches the critical prototype-pollution CVE. No component
  changes needed (verified: both real usages already on the stable modern API).
- `postcss` (high, transitive via `critters`/`next`'s bundled copy): pinned via a `package.json`
  `"overrides"` entry to `^8.5.28` rather than following npm's suggested path (a forced `next@16`
  major bump) — a much smaller, lower-risk fix for a transitive build-tool dependency.
- `sharp` (high): cleared automatically as a side effect of the `next` bump.
- `axios`, `brace-expansion`, `form-data`, `js-yaml`, `nanoid`: cleared by plain `npm audit fix`.

`react-slick`/`slick-carousel` (declared in `package.json`, a separate carousel library) were
confirmed unused anywhere in `app/`/`components/` — correctly left untouched, not in scope.

## Verification

- `npx tsc --noEmit` and `npm run build` (55 routes) — clean, both after the `next` bump and after
  the `swiper` bump.
- Booted backend + frontend together, `curl`'d the homepage — HTTP 200, real rendered HTML
  (~417KB), confirmed both carousels' markup present (swiper wrapper/slides/pagination for
  `HeroSlider` and `TestimonialsSection`), no error-boundary text.
- Independently re-confirmed after the fact (this session, not just the delegated agent): `git log`
  shows the real commit (`d1ec1a0`), `npm audit` independently re-run shows 0 vulnerabilities.
- **Honest, disclosed gap**: client-side hydration/interactivity (autoplay, arrow-click behavior)
  was not verified in a real browser — the `claude-in-chrome` browser tool couldn't reach this
  sandbox's `localhost` (a tooling/environment limitation, not an app issue). Only SSR-rendered
  markup was confirmed correct. If a real regression exists in post-hydration carousel behavior,
  it would not have been caught by this verification pass — worth a manual check before this ships
  anywhere real.

## Consequences

- `docs/claude/technical-debt.md`'s frontend vulnerability entry is now closed — no outstanding
  npm security debt on the frontend.
- The `postcss` override is a deliberate divergence from npm's own suggested remediation path
  (which wanted a `next@16` major bump) — worth revisiting if a future `next` upgrade makes the
  override unnecessary or conflicting.
- The disclosed hydration-verification gap means this should get a real-browser smoke test
  (carousel autoplay/interaction) before being considered fully verified, not just built-and-boots.
