# Known Decisions (Index)

Full records live in `../decisions/`. This is a running index — add a line here whenever a new
decision record is created.

| # | Title | Date | Summary |
|---|---|---|---|
| [0001](../decisions/0001-fresh-repos-under-wood-vintage.md) | Fresh repos under `wood-vintage`, sourced from `unique-dressup` | 2026-09-09 | Three fresh git repos (backend/frontend/documentation) file-copied from `unique-dressup`, clean history, no remotes yet; `unique-dressup` stays untouched. |
| [0002](../decisions/0002-local-dev-environment-setup.md) | Local dev environment setup | 2026-09-09 | New `wood_vintage` MySQL DB, explicit admin credentials, frontend dev port 3030 (3000-3010 already in use by other projects on this machine), fixed hardcoded `API_URL`. |
| [0003](../decisions/0003-phase-1-foundation-prerequisites.md) | Phase 1 prerequisites | 2026-09-09 | Real Prisma migration history adopted; order pricing made server-authoritative (confirmed-exploitable client-price-trust bug fixed and re-tested). |
| [0004](../decisions/0004-international-url-strategy.md) | International URL strategy | 2026-09-09 | Subdirectory-per-country (`/us/`, `/in/`, ...) on a single domain, evaluated against subdomain/ccTLD/query-param alternatives. Unblocks Phase 3/6. |
| [0005](../decisions/0005-media-cdn-architecture.md) | Media/CDN architecture | 2026-09-09 | Reuse existing image pipeline as-is; defer actual CDN fronting to Phase 5/8. No Phase 1 code changes needed. |
| [0006](../decisions/0006-seo-foundation-scope.md) | SEO foundation scope | 2026-09-09 | Existing SEO infra is adequate; only the pre-existing CMS-routing bug needs fixing. Real SEO buildout is Phase 6. |
