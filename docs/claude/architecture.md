# Architecture

Full engineering-level architecture (stack, folder structure, DB schema, API structure, data flow)
lives in `../../../backend/CLAUDE.md` (copied from Unique Dressup, dated 2026-07-27 as of the copy —
verify against current code before relying on it for anything load-bearing).

This file is for **architecture decisions specific to the wood-vintage transformation** that go
beyond what's in that reference — e.g. the country-config model (MASTER-PROMPT §7), content
inheritance (§30), international URL strategy (§31), media/CDN architecture (§19). Populate as
Phase 1 (Foundation) work happens; link out to `../decisions/` records for the "why."

## Country architecture

Spec written 2026-09-09, not yet implemented: `../architecture/country-architecture-spec.md`.
`Country` model, `ProductCountryPricing`/`ProductCountryAvailability` (opt-in-override, not a
column-per-country), nullable `countryId` on `HomepageSection`/`Banner`/`CmsPage` for Global→Country
inheritance. Deliberately scopes IP/edge country detection out for now — ships cookie/locale/default
fallback first (MASTER-PROMPT §8 tiers 2–4), edge detection depends on hosting not yet chosen.
