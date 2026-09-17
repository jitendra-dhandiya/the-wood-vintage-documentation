# Phase 6 — SEO: implementation spec

Date: 2026-09-17. Covers MASTER-PROMPT §47 Phase 6 (technical SEO, content SEO, international SEO,
structured data, internal linking, landing pages, editorial architecture).

Per the Phase 6 audit (2026-09-17): international SEO's core mechanism (`buildCountryAlternates()`
in `lib/countries.ts`) is solid and already correctly used on product/category/collections/CMS/
homepage/artisans pages. The real gaps are concentrated in five areas, all frontend-only, all
additive or corrective (no schema changes, no destructive changes, no business decision needed —
unlike Phase 7/8). This spec is scoped to exactly those five, in priority order.

## §1. Fix fashion-era fallback metadata (highest traffic impact, smallest change)

`frontend/app/layout.tsx`'s root `metadata` export is the fallback title/description/keywords for
any page with no `generateMetadata`/`metadata` of its own — and several real, already-indexed,
high-intent pages have none at all: `app/[country]/(store)/shop/page.tsx`, `search/page.tsx`,
`categories/page.tsx`, `collections/(index)/page.tsx` (the collections index, not
`collections/[slug]`, which already has metadata), `contact/page.tsx`. Right now every one of those
silently ships:

```
title.default: "${SITE_NAME} — Premium Fashion Store"
description: "Discover premium fashion, trending styles... streetwear, co-ord sets, dresses"
keywords: ['fashion', 'clothing', 'streetwear', 'dresses', ...]
```

on a furniture site. This is wrong copy on real search-indexed pages, not a cosmetic issue.

**Fix:**
1. Rewrite `app/layout.tsx`'s `metadata` fallback for the furniture/handicraft vertical — title,
   description, keywords. Use `SITE_NAME`/`SITE_TAGLINE`-style constants already imported there if
   they exist; otherwise write real furniture-appropriate copy directly (e.g. "Handcrafted wooden
   furniture and home décor" framing, not generic filler).
2. Add a `generateMetadata` (Server Component pages) or `metadata` export to each of the five pages
   above. `shop`/`search`/`categories`/`collections` index pages are Client Components today (per
   the Phase 5 audit's SSR/SSG findings) — a Client Component page file can still export a sibling
   `generateMetadata` in the same file only if the file itself is a Server Component; since these
   are `'use client'` pages, the pattern used elsewhere in this codebase for a client page needing
   metadata is to add a thin server wrapper, OR (simpler, check what the codebase already does)
   confirm whether these pages already have a non-client parent `layout.tsx` in their route segment
   that could carry static metadata instead — investigate before choosing an approach, don't assume.
   For `contact/page.tsx`, check whether it's a Server or Client Component first.

## §2. Structured data (real ranking/rich-result impact, moderate effort)

Only one file emits JSON-LD today: `app/[country]/(store)/product/[slug]/page.tsx` (schema.org
`Product` + `Offer` + conditional `AggregateRating`). Two real bugs in it, plus broad missing
coverage:

1. **`priceCurrency: 'INR'` is hardcoded** (`product/[slug]/page.tsx`, inside the `schema` object) —
   factually wrong on any non-India country page once more markets go live. Fix: resolve the
   correct ISO 4217 code the same way `generateMetadata` in the same file already resolves the
   country list — call `getEnabledCountries()` (already imported in this file), find the country
   matching `params.country` (or the default), and use its `.currency` field (confirmed present on
   the `Country` type, `types/index.ts` — `currency: string; // ISO 4217, e.g. "INR"`). Do not
   thread this through `useCountry()` — this is a Server Component, that hook is client-only.
2. **`brand.name` falls back to `'LUXÉ'`** — a fashion-brand leftover, same class of bug as §1.
   Change the fallback to a real site-appropriate brand name (or `SITE_NAME`).
3. **Missing entirely**: `Organization`/`WebSite` (sitewide identity — add once to `app/layout.tsx`,
   cheap, improves Knowledge Panel/sitelinks-search-box eligibility), `BreadcrumbList` (real
   `<Breadcrumbs>` UI already exists on product/category/collection/artisans pages — find that
   breadcrumb data and emit the matching JSON-LD alongside it on each of those page types), `Article`
   for blog posts (blog detail currently has zero JSON-LD of any kind).
4. **Not in scope**: `LocalBusiness` for the `Store` model — it has no lat/lng field
   (`backend/prisma/schema.prisma`, `Store` model), so real `LocalBusiness` schema needs a backend
   migration first. Do not add fake/placeholder geo data to force this through; skip it and note the
   dependency in `tasks/TASKS.md` instead.

## §3. Material/Room/Style landing pages (highest leverage — data model already exists)

`Material`, `Style`, `Room` models (`backend/prisma/schema.prisma`) each have `slug` (unique,
indexed), `description`, `image`, `isActive`, `sortOrder`, and a real `Product[]` relation — exactly
the taxonomy needed for programmatic landing pages ("wooden dining tables", "teak furniture", etc.).
Admin CRUD already exists (`app/(admin)/admin/materials`, `/rooms`, `/styles`). **No frontend route
exists for any of them** — confirmed via grep, there is no `/material/[slug]`, `/room/[slug]`, or
`/style/[slug]` page anywhere in `frontend/app`.

**Fix:** add `frontend/app/[country]/(store)/material/[slug]/page.tsx`,
`.../room/[slug]/page.tsx`, `.../style/[slug]/page.tsx`. Each should closely follow the existing
`category/[slug]/page.tsx` pattern (it already has `generateMetadata`, `buildCountryAlternates()`,
and a product grid — this is the closest analog, reuse `CategoryPageClient.tsx`'s structure rather
than inventing a new one, parameterized by which FK to filter on — `materialSlug`/`roomSlug`/
`styleSlug`, all three already supported by the backend's `GET /products` filters per Phase 2/4
work). Metadata should come from the model's own `name`/`description` fields, not be generic. Add
`BreadcrumbList` JSON-LD (§2) at the same time, not as a separate pass. This is genuinely new
public surface area, not a fix — treat it as the biggest single piece of this spec, but still
low-risk (purely additive, no existing route changes).

**Also**: add these to `frontend/app/sitemap.ts` (currently omits collections, artisans, and this
new material/room/style set entirely) once the routes exist.

## §4. Blog detail: hreflang, canonical, and a leftover brand name

`blog/[slug]/page.tsx` has three real problems, worse than what decision `0018` originally flagged
(which only noted missing hreflang):
1. **No `alternates` at all** — not just missing hreflang, missing `canonical` too. Fix: call
   `buildCountryAlternates()`, same pattern as every other page type already uses.
2. **Fallback title is `` `${blog.title} — Unique Dressup Blog` `` — leftover fashion-app brand.**
   Fix: use the real site name.
3. **`openGraph.url` is `${SITE_URL}/blog/${blog.slug}`, missing the country prefix** — points at a
   URL that 307-redirects rather than the canonical `/in/blog/...` one. Fix: prefix with
   `withCountry()` or the resolved country code, matching how canonical URLs are built elsewhere.
4. Add `Article` JSON-LD here too (§2) while this file is already being touched.

## §5. Footer: country-prefix every internal link, plus a currency-adjacent correctness check

`components/layout/Footer.tsx`'s `FOOTER_LINKS` object (Shop/Help/Company groups) and its two
`<Link>` render sites (~line 176 and ~line 234, the bottom bar) use raw hrefs (`/shop`, `/faq`,
`/blog`, etc.) with **no `withCountry()` call** — confirmed via grep, no `withCountry`/`useCountry`
import in this file at all. Every footer link on every page of the site currently forces an extra
307 redirect hop instead of linking straight to the canonical country-prefixed URL — a real,
sitewide crawl-budget and link-equity leak, and the one place decision `0018`'s otherwise-thorough
`withCountry()` sweep missed.

**Fix:** import `useCountry()` (`contexts/CountryContext`, same pattern as `Navbar.tsx`) and
`withCountry()` (`lib/withCountry.ts`), wrap every `href` in `FOOTER_LINKS` and both `<Link>` render
sites with `withCountry(href, country)`. Also spot-check (not necessarily fix in code — this may be
a DB seed issue, not a code issue) whether `settings.site_name`/`site_description` in the actual
running DB still say "Unique Dressup"/"Trendy & affordable fashion..." (Footer's own fallback
defaults reference this) — if so, that's a `docs/decisions/` note for the already-tracked "Rebrand
seeded content" task (`tasks/TASKS.md`), not new code to write here.

## Non-goals (explicitly out of scope for this spec)

- `LocalBusiness` schema for `Store` (needs a lat/lng migration first — §2).
- Any editorial/content-strategy tooling (`targetKeyword` fields, content briefs) — genuinely
  useful later but not worth building ahead of an actual content program; note in `tasks/TASKS.md`.
- Rebranding seeded DB content (site name/description settings, product/category copy still saying
  "Unique Dressup"/fashion terms) — separate, already-tracked task, not a Phase 6 code change.
- A sitemap index split (multiple sitemap files) — the audit found the current single-file
  `sitemap.ts` is fine at this catalogue size; only add the new route types to it (§3), don't
  restructure it.

## Rollout / commit plan

Separate, well-scoped commits so each piece is independently revertible, same discipline as every
prior phase this session:
1. §1 — root layout + 5 pages' metadata (quick, high-value, do first).
2. §5 — Footer `withCountry()` fix (quick, independent of everything else).
3. §4 — blog detail hreflang/canonical/title/OG fixes.
4. §2 — structured data: Product currency + brand bugs, Organization/WebSite, BreadcrumbList on
   existing page types, Article on blog.
5. §3 — material/room/style landing pages + sitemap additions (biggest, do last since it may reuse
   the BreadcrumbList work from §2's commit).

## Verification checklist

- `npm run type-check` and `npm run build` both clean.
- Real check: load `/in/shop`, `/in/search`, `/in/categories`, `/in/collections`, `/in/contact` and
  confirm the rendered `<title>`/meta description are furniture-appropriate, not fashion copy — view
  page source or use `curl`, don't just trust the code.
- Real check: `/in/product/<slug>` JSON-LD `priceCurrency` matches the country's actual currency —
  test against at least one non-default enabled country if one exists, not just `in`.
- Real check: a new `/in/material/<slug>` (and room/style) page returns real products via the
  correct filter, has correct metadata, and has working hreflang (compare against how `category/
  [slug]` already does it).
- Footer links on any page, when clicked or curled, go straight to the country-prefixed URL, not
  through a 307.
- No regression: existing product/category/collection/CMS/homepage/artisans hreflang and JSON-LD
  still work exactly as before (0018 verification, re-run at least the product page check).
