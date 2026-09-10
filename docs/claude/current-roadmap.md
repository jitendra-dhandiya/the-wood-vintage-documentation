# Current Roadmap

Mirrors `tasks/TASKS.md` at a phase level (MASTER-PROMPT §47). Keep this in sync with TASKS.md —
TASKS.md is the granular checklist; this is the narrative status.

| Phase | Name | Status |
|---|---|---|
| 0 | Discovery | **Done** (2026-09-09) — `docs/architecture/phase-0-discovery-report.md`. One open question flagged, unresolved: does `wood-vintage` eventually replace `unique-dressup` in production? |
| 1 | Foundation (country/currency/localization/CMS/media/SEO foundation) | **Done** (2026-09-09/10) — migration history, server-authoritative pricing, Country architecture (backend + frontend), CMS/homepage/banner resolution logic, Media/CDN and SEO foundation scoping, checkout shipping-display fix, all complete and verified (carousel hydration gap also closed). Remaining: country-scoped admin UI (not urgent) |
| 2 | Handicraft Domain (categories/materials/styles/attributes/customization) | **Backend done** (2026-09-10) — `Material`/`Style`/`Room`/`Artisan` models, seed data, CRUD, product filters/fields, verified. Frontend (display, filters, admin UI) not started |
| 3 | Internationalization (country config/pricing/content/shipping/SEO) | Not started |
| 4 | Experience (homepage/discovery/storytelling/search/recommendations) | Not started |
| 5 | Performance (CDN/images/caching/SSR/bundle/CWV) | Not started |
| 6 | SEO (technical/content/international/programmatic) | Not started |
| 7 | Analytics (event tracking/funnels/dashboards/attribution) | Not started |
| 8 | Scale (traffic/volume/warehouses/providers/ML-ready recs) | Not started |

Don't jump ahead of Phase 0 for a given module — inspect before modifying (MASTER-PROMPT §2).
