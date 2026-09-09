# Project Context

## What we're building

A global handcrafted wooden furniture / handicrafts / home décor e-commerce platform ("wood
vintage"), transformed from an existing production B2C fashion e-commerce codebase (Unique
Dressup). See `../../MASTER-PROMPT.md` for the full brief.

## Where the code actually lives

- `wood-vintage/backend`, `wood-vintage/frontend` — the live working repos for this project.
  Seeded 2026-09-09 as a file copy of `unique-dressup/backend` and `unique-dressup/frontend`
  (fresh git history, no remotes yet — see `docs/decisions/0001-fresh-repos-under-wood-vintage.md`).
- `unique-dressup/backend`, `unique-dressup/frontend` — the original fashion-app source.
  **Read-only reference. Never modify.**

## Target markets

India, UAE, USA, Australia, UK, Germany, France, Netherlands, other European markets — architecture
must allow adding more without major code changes (MASTER-PROMPT §7).

## Non-negotiables (see MASTER-PROMPT for detail)

- Don't rebuild from scratch — reuse/extend the copied architecture (§2–3).
- Country is a first-class, admin-configurable concept: currency, pricing, tax, shipping,
  content, SEO, availability, promotions all vary by country (§7–10).
- No fake reviews, fake urgency, fake scarcity, dark patterns (§13, §34).
- CMS-driven, not hardcoded marketing content in components (§11).
- Challenge bad requirements instead of blindly executing them (§49).
