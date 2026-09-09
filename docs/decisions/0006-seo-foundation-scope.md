# 0006. SEO foundation: existing infrastructure is adequate, one inherited bug needs fixing

Date: 2026-09-09

## Decision

No new SEO infrastructure needed in Phase 1. The inherited `SeoMeta` model, dynamic `sitemap.ts`,
per-product JSON-LD `Product` schema, and `robots.ts` (discovery report §11) already satisfy
MASTER-PROMPT §6's per-page requirements (unique title/description, canonical URL, structured data,
etc.) as a technical foundation. Real international SEO work (hreflang, country-prefixed URLs,
programmatic pages) is Phase 6, and is now unblocked by decision `0004` — nothing further is needed
at the foundation level to prepare for it. One inherited, unrelated bug needs fixing as part of
whichever implementation pass touches CMS pages next: the frontend calls `/cms/:slug`, the backend
serves `/seo/cms/:slug` — every CMS page 404s (`CLAUDE.md` §25 #7). Not fixed in this pass (it's a
one-line frontend fix, but the frontend repo has a background agent actively working in it —
tracked in `docs/claude/technical-debt.md` and `tasks/TASKS.md` to fix once that's clear).

## Why

Evaluated what "SEO foundation" (MASTER-PROMPT §47 Phase 1 line item) actually requires versus what
already exists: the discovery report already confirmed Product/Organization-adjacent structured
data, a working sitemap, and per-page metadata all exist and function (aside from the CMS-routing
bug, which is a routing mismatch, not missing SEO infrastructure). Building new foundation-level SEO
infra now, before the country/URL-strategy work (Phase 3/6) actually needs it, would be premature —
there's nothing to build against yet (no country-prefixed routes exist), and MASTER-PROMPT §6's
requirements are about *page-level* completeness, which the existing per-page `SeoMeta` model
already supports for whatever pages exist today.

## Alternatives considered

- **Build hreflang/canonical infrastructure now, ahead of Phase 3's route restructuring.** Rejected
  — hreflang tags need a URL structure to point *between* (per decision `0004`), so building this
  before the `app/[country]/...` routing exists would mean building it twice (once against the
  current flat routes, again against the country-prefixed ones).
- **Fix the CMS routing bug immediately as part of this decision.** Considered, but the frontend
  repo currently has a background agent (npm vulnerability triage) actively working in it — editing
  the same files concurrently risks a git conflict. Deferred, tracked, not forgotten.

## Chosen approach

Mark "SEO foundation" as scoped/decided in `tasks/TASKS.md` — no Phase 1 work item beyond fixing
the pre-existing CMS routing bug (tracked separately, low effort, unrelated to the SEO architecture
question itself). Real SEO buildout resumes at Phase 6, per the roadmap.

## Consequences

- Closes the last open Phase 1 "architecture scoping" line item — everything else remaining in
  Phase 1 (`tasks/TASKS.md`) is now either implementation work (Country model, CMS resolution
  logic) or was already fixed (migration history, order pricing) or delegated (stock restoration,
  npm vulnerabilities) rather than an open design question.
- The CMS routing fix is small enough that it shouldn't be forgotten once flagged twice
  (`technical-debt.md` and here) — worth doing as a quick follow-up once the frontend repo's
  in-flight agent work lands.
