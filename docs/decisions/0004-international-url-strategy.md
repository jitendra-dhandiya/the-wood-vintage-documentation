# 0004. International URL strategy

Date: 2026-09-09

## Decision

Use **subdirectory-per-country** on a single domain: `/in/`, `/us/`, `/ae/`, `/au/`, `/gb/`, `/de/`,
`/fr/`, `/nl/`, matching MASTER-PROMPT §31's own example. Country code is an ISO 3166-1 alpha-2
segment at the root of the path (`woodvintage.com/us/product/rustic-dining-table`), resolved via a
Next.js route segment (`app/[country]/...`) rather than middleware rewriting, so it's visible in
the URL and explicit in the App Router's routing table.

## Why

MASTER-PROMPT §31 explicitly forbids picking this arbitrarily and requires evaluating SEO,
maintainability, localization, canonicalization, hreflang, analytics, and scalability. Evaluated
against the three realistic alternatives:

| Criterion | Subdirectory (`/us/`) | Subdomain (`us.site.com`) | ccTLD (`site.ae`) |
|---|---|---|---|
| SEO — domain authority | Single domain accumulates all authority; every country page benefits from the whole site's backlink profile | Google treats subdomains as largely separate for authority purposes — a new market starts near zero | Fully separate authority per ccTLD — worst for a growing brand |
| hreflang / canonicalization | Straightforward — one sitemap, one robots.txt, hreflang tags between sibling paths | Needs per-subdomain sitemap/robots, more moving parts | Same, plus DNS/cert management per ccTLD |
| Maintainability (small team) | One deployment, one codebase, one cert | Same codebase but more DNS/infra config | Most infra overhead — DNS, SSL, hosting per ccTLD, often per-country legal entity implications |
| Analytics/attribution | Path-based segmentation works natively in GA4 and most tools | Needs cross-domain tracking setup | Same, worse |
| Localization signal to users | Less strong a "local" signal than a ccTLD, but hreflang + on-page content (currency, language) compensates | Stronger localization signal | Strongest localization signal, but not worth the cost here |
| Scalability (adding a 9th, 10th country) | Add a route segment value + DB row — no new infra | New DNS/subdomain per country | New domain purchase + legal/hosting setup per country |
| Fit with existing Next.js App Router | Clean fit — `app/[country]/(store)/...` extends the existing route-group structure additively | Requires either separate Next.js deployments or middleware-based domain routing — more complex | Same as subdomain, worse |

Subdirectory wins on every criterion **except** "localization signal strength," where a ccTLD is
marginally stronger but at a cost (per-country infra, split SEO authority, legal/registration
overhead per market) that isn't justified for a platform just starting international expansion
(MASTER-PROMPT §0 lists 8 target markets — ccTLD costs would multiply by 8 immediately). This
matches how most D2C brands actually scale internationally in their first few years (subdirectory
first, ccTLD only if a specific market's scale and local-presence requirements justify it later).

## Alternatives considered

- **ccTLDs per country.** Rejected for now — strongest localization signal but the highest cost
  (domain, hosting/legal setup, and split SEO authority per market) for a platform with no
  established authority yet in any of the 8 target markets. Revisit per-market if/when a specific
  country's scale justifies it (this is a per-market decision that could be made later without
  blocking the others — subdirectory and ccTLD aren't mutually exclusive in the long run).
- **Subdomains per country.** Rejected — meaningfully worse SEO-authority consolidation than
  subdirectories with none of a ccTLD's localization-signal benefit, and still adds real
  infra/analytics overhead. No scenario where this beats one of the other two options.
- **Query parameter (`?country=us`).** Not seriously considered — MASTER-PROMPT §31 doesn't list it
  and it's a well-established SEO anti-pattern (Google discourages indexing parameterized country
  variants; canonicalization becomes ambiguous).
- **No URL-level country signal at all (cookie/IP only, same URL for everyone).** Rejected — this is
  what MASTER-PROMPT §31 is explicitly asking to move away from; it makes country-specific pages
  unindexable/unlinkable (can't share a URL to "the US version of this product") and defeats
  international SEO entirely (§6, §31).

## Chosen approach

`app/[country]/...` as the new route root inside the Next.js App Router, wrapping the existing
`(store)`/`(admin)`/`(account)`/`(auth)` route groups. `[country]` validates against the enabled
`Country.code` values from `docs/architecture/country-architecture-spec.md` (invalid/disabled codes
404 or redirect to the default country — exact behavior to be decided at implementation time, not
here). `hreflang` tags generated per page linking to the equivalent path under every other enabled
country. Canonical URL is the current country's own path (not the default country's) — each
country's page is its own canonical entity, not a duplicate of a "main" version, since content,
pricing, and availability can legitimately differ.

`/admin`, `/account`, and API routes are **not** country-prefixed — admin/account are
authenticated, session-scoped surfaces where a URL-level country signal adds no SEO value and only
complicates routing; the existing `CountryContext` (cookie-based, from the architecture spec)
handles country there instead.

## Consequences

- Every existing storefront route (`(store)/page.tsx`, `(store)/product/[slug]/page.tsx`, etc.)
  needs to move under `app/[country]/(store)/...` — a real, mechanical restructuring of the route
  tree, not a small patch. Scope this explicitly as its own Phase 3/6 task, not a side effect of
  something else.
- `sitemap.ts` needs to generate URLs for every enabled-country × page combination, not one flat
  list — sitemap size scales with country count × catalog size. Worth a sitemap-index (multiple
  sitemap files) once country count and catalog size both grow, not necessarily on day one.
- Existing bookmarked/shared/indexed URLs (e.g. `woodvintage.com/product/x`, if any exist by the
  time this ships) would need a redirect to a default-country-prefixed URL
  (`/in/product/x`) to avoid breaking existing links/SEO equity — a redirect map is required at
  implementation time, not assumed away.
- Doesn't block Phase 1 (Country model, `CountryContext`) — that work is independent of the URL
  structure and can proceed first. This decision unblocks Phase 3 (country routing) and Phase 6
  (international SEO), which were both waiting on it.
