# Technical SEO audit + checklist — thewoodvintage.com

Date: 2026-09-25. Owner: SEO agent. Development is ON HOLD: nothing here was changed in code; "website changes needed later" (section 12)
lists what to build when dev resumes. Tags: VERIFIED (observed 2026-09-25 with GET requests against production or read in the repo) /
ESTIMATE / ASSUMPTION. Companion docs: [india-seo-plan.md](india-seo-plan.md), [us-uae-seo-plan.md](us-uae-seo-plan.md),
[keyword-map-india.md](keyword-map-india.md), [content-calendar.md](content-calendar.md).

Method: read `frontend/app/sitemap.ts`, `robots.ts`, `middleware.ts`, `next.config.ts`, the `[country]/(store)` routes, decisions 0004/0006/0018/0023/0036/0037/0039,
`operations/server/nginx-site.conf`; then GET-only requests (curl, browser-like and Googlebot User-Agent) against `https://thewoodvintage.com/in/...`, `/robots.txt`,
`/sitemap.xml`, `/img/...`, and the public API. No POST, no writes.

---

## 1. Headline findings (read this first)

| # | Finding | Severity | Evidence |
|---|---|---|---|
| F1 | **Both production product pages render "Product Not Found" (HTTP 200, `<meta name="robots" content="noindex">`, no Product JSON-LD)**, although `GET /api/v1/products/<slug>?country=in` returns 200 with full data from outside the server. Affects `/in/product/hand-carved-krishna-panel` and `/in/product/channapatna-stacking-rings`. Same result with a Googlebot UA. | **BLOCKER for launch** | VERIFIED 2026-09-25. Likely cause (ASSUMPTION, same class as bug-log entry about nginx overwriting X-Forwarded-For): the page's server-side `getProduct()` calls the public API URL through nginx, arrives with the server's own IP, and the 0036 geo-lock in the backend answers 403 `REGION_UNAVAILABLE`/mismatch. Middleware was already fixed with `INTERNAL_API_URL`; the page-level fetches (`product/[slug]/page.tsx`, sitemap `getProducts`) were not. |
| F2 | **Sitemap has 68 URLs and zero product or combo URLs** (2 products exist for IN). Same root cause as F1 (the product list call in `sitemap.ts` is country-filtered/geo-enforced). | BLOCKER | VERIFIED: `sitemap.xml` = 68 `<loc>`, none contain `/product/`; API returns 2 products for `country=IN`. |
| F3 | **Whole site is `X-Robots-Tag: noindex, nofollow`** (nginx `add_header`, line marked PRE-LAUNCH in `operations/server/nginx-site.conf` line 51-52). It also applies to `/robots.txt` and `/sitemap.xml`. Intentional until go-live. Note the HTML meta says `index, follow` — the header wins. | Intentional; gate for launch | VERIFIED on `/`, `/in`, `/robots.txt`, `/sitemap.xml`. |
| F4 | Many pages have **no canonical and no hreflang**: `/in/shop`, `/in/about`, `/in/faq`, `/in/blog`, `/in/contact` (no `<link rel="canonical">`). Present only on home, category, material/room/style, collection and blog-post pages. | High (easy fix) | VERIFIED via HTML head of each page. |
| F5 | **Product JSON-LD (in code) is incomplete for merchant results**: Offer has price/currency/availability only — no `shippingDetails`, `hasMerchantReturnPolicy`, `itemCondition`, `url`, `priceValidUntil`; no `mpn/gtin`; availability uses short enum text; `og:type` is `website` not `product`. Organization JSON-LD is only `{name, url}` (no logo, sameAs, contactPoint, address). | High | VERIFIED in `product/[slug]/page.tsx` and in the live homepage HTML (Organization = name + url only). |
| F6 | **Thin / empty indexable surface**: sitemap lists 18 categories, 9 materials, 8 rooms, 8 styles, 4 collections, 8 artisans for a **2-product catalogue**. Decision 0023 already noted no seeded product had Material/Room/Style FKs. Empty taxonomy pages are near-doorway/soft-thin content. | High | VERIFIED sitemap composition; catalogue count VERIFIED (2 prod / 46 local). Whether the taxonomy pages are actually empty in prod is ASSUMPTION - spot-check. |
| F7 | Artisan pages use **UUID URLs** (`/in/artisans/fa5309a3-...`) — no keyword/slug, unfriendly for sharing, and change if re-seeded. | Medium | VERIFIED in sitemap. |
| F8 | **No page-level caching**: `/in` returns `cache-control: private, no-cache, no-store`; every request SSRs on a 2-CPU box. TTFB 0.61-0.94 s (4 runs), category 0.47 s; HTML 307 KB raw / 47 KB gzip; 43 `<script>` tags; one 15.5 s outlier on first request (cold). | Medium (CWV/crawl budget) | VERIFIED 2026-09-25 from India; CWV field data does not exist yet (no traffic). |
| F9 | **Image pipeline is good**: custom loader -> backend `/img/...?w=` negotiates AVIF/WebP by `Accept`, `cache-control: public, max-age=31536000, immutable`; hero at w=828 = 99 KB AVIF / 149 KB WebP. | Positive | VERIFIED. |
| F10 | Products have **one image each** in the API (`images.length = 1`); Merchant Center/rich results and conversion want 4-8 angles + scale + detail. | Medium | VERIFIED via `/api/v1/products?country=IN`. |
| F11 | **Placeholder/seeded content that must not go live indexed**: contact page phone `+91 98765 43210` (placeholder pattern); homepage has a "Kind words from our customers" TESTIMONIALS block while there are 0 orders (content unverified - check it is not invented; if seeded it must be removed and never marked up as Review); blog posts have seeded `datePublished` (2026-09-04) earlier than the site's creation (2026-09-24); site copy mentions Channapatna/Kutch artisans whereas the owner's business is the Jodhpur carpenter team. | High (trust + spam policy) | VERIFIED text on live pages/JSON-LD; whether testimonials are fake is UNVERIFIED. |
| F12 | Error handling: unknown URL returns a real **404** (good) but the HTML head carries both `noindex` and `index, follow` (conflicting; Google obeys the restrictive one). Product not-found is a 200 "soft 404" (see F1). Crawler UA gets `/` -> 307 `/in` (fine). | Low | VERIFIED. |
| F13 | Blog: 5 posts, Article JSON-LD present with author "The Wood Vintage Editorial" (Person) — generic; no named author/E-E-A-T. Blog index has ItemList + Article. Sample post ~1,870 rendered words (includes chrome). | Medium | VERIFIED. |
| F14 | Root `/` answers **307 -> /in** with a `wv_country` cookie. Acceptable while India is the only market; revisit when a second market opens (section 5). | Low | VERIFIED. |

What is already good: unique titles/descriptions on category/material/collection/blog pages, BreadcrumbList on taxonomy pages, WebSite+Organization JSON-LD,
`lang="en"`, mobile viewport, HTTPS + HSTS, security headers, AVIF/WebP with immutable cache, per-country URLs (decision 0004), hreflang on key page types (0018/0023),
robots.txt disallows admin/account/api/checkout/cart.

---

## 2. Indexability plan — WHEN and HOW to remove the noindex header safely

### 2.1 When (gates — all must be true)
Go-live for search is **not** the same as "site works". Remove the header only when:
1. **F1/F2 fixed** — `curl -s https://thewoodvintage.com/in/product/<slug>` shows the real product `<title>`, Product JSON-LD, and the slug appears in `sitemap.xml`. (Website change W-01, W-02.)
2. Real business data: real phone/WhatsApp/address/email (Contact, footer, Organization JSON-LD), real GST/legal pages (`/in/privacy-policy`, `/terms`, `/return-policy`, `/shipping-policy` exist as routes; contents must be final).
3. Razorpay/Cashfree live keys (or COD-only stated honestly) and at least one complete end-to-end order test.
4. Catalogue floor: **>= 12-15 real products with 3+ real photos each** across at least 3 categories, with taxonomy FKs set (material/room/style) — otherwise thin-page risk (F6). Owner decides; the 2-product state is NOT a search launch (it is fine as a social/WhatsApp landing site while noindex).
5. No seeded/fake content: testimonials, blog dates, artisan bios about people who are not the owner's team, placeholder phone (F11).
6. Canonicals on every public page (F4, W-03) and Search Console/Bing verified (section 9).
7. One social/WhatsApp push already running — so the first Googlebot visit is not the first time anyone sees the site (brand searches and social profiles give early trust signals).

Until then the current setup is *correct* (a noindex demo). Do not remove partially "to test" — a half-broken product page indexed under the brand hurts more than waiting.

### 2.2 How (runbook; nginx change is an ops action, not a code change)
1. **Pre-flight (still noindex):** verify the domain in Search Console (DNS TXT, works while noindex) and Bing Webmaster Tools; run `curl -I` on 10 URLs and save baseline.
2. **Optional staged release (recommended):** instead of deleting the line, replace it with an nginx `map` so only *ready* paths are indexable, and keep `noindex` on the rest:
   - indexable: `/in` (home), `/in/category/*`, `/in/product/*`, `/in/blog*`, `/in/about`, `/in/faq`, `/in/collections*`, the new custom-furniture pages;
   - still noindex: `/in/material/*`, `/in/room/*`, `/in/style/*`, `/in/artisans/*`, `/in/combos*` until each has >= 3 products / >= 300 unique words (then flip one by one).
   (Longer term the same rule belongs in page metadata — W-05 — so it is data-driven, not an nginx list.)
3. Remove/replace the line (`operations/server/nginx-site.conf` lines 51-52; server: `/etc/nginx/sites-available/thewoodvintage.com` per `operations/server-runbook.md`), `nginx -t && systemctl reload nginx`.
4. **Verify immediately:** `curl -sI https://thewoodvintage.com/in | grep -i x-robots` returns nothing; same for `/robots.txt`, `/sitemap.xml`, a product, a category. View-source for stray `<meta name="robots" content="noindex">` (the 404/not-available/`Product Not Found` patterns add it, which is correct only for those).
5. **Search Console:** submit `https://thewoodvintage.com/sitemap.xml`; URL Inspection -> "Test live URL" on `/in`, one category, one product, one blog post (confirm "Page is indexable", correct canonical, structured data detected); "Request indexing" for ~10 money pages only (the daily quota is small; mass requests do not speed anything).
6. **Bing:** submit sitemap; enable IndexNow later (W-16) for fast pings.
7. **Days 1-14 watch:** Pages report (Indexed / Excluded reasons: "Crawled - currently not indexed", "Duplicate without user-selected canonical", "Excluded by noindex" should fall to expected pages only). Google says new content takes "several hours to several weeks" to be indexed (Mueller, via Search Engine Land, https://searchengineland.com/google-on-how-long-it-takes-for-seos-to-be-indexed-and-ranked-349998, accessed 2026-09-25 - VERIFIED as a statement, timing itself is variable).
8. **Rollback:** if a major defect appears, re-add the nginx line (instant) and fix; pages already indexed drop after recrawl (days). Because rollback is cheap, launch early in the week, not before a festival weekend.
9. A pre-launch `noindex` never needs a "removal request" — Google simply recrawls; no sandbox penalty is documented (Google has no official "sandbox"; new domains still earn trust slowly - Mueller quoted at https://www.searchenginejournal.com/mueller-mentions-google-sandbox-and-honeymoon-ranking-effects/408994/, accessed 2026-09-25).

---

## 3. Sitemap and robots — per country

### Current (VERIFIED)
- One `sitemap.xml` generated from `app/sitemap.ts`, ISR 1 h, URLs multiplied by **enabled** countries only (today only `/in`). 68 URLs, no products (F2). `lastModified: new Date()` on static pages = "always fresh" (meaningless; Google ignores `changefreq`/`priority`, and untrustworthy `lastmod` is discounted).
- `robots.txt`: `User-Agent: *`, `Allow: /`, disallow `/admin/ /account/ /api/ /*/checkout/ /*/cart/`, `Sitemap: https://thewoodvintage.com/sitemap.xml`.

### Target
| Item | Recommendation | Change ID |
|---|---|---|
| Sitemap structure | `sitemap-index.xml` -> `sitemap-in.xml`, later `sitemap-us.xml`, `sitemap-ae.xml` (one file per enabled country: easier Search Console diagnostics per market, and a country switched on/off doesn't disturb others). Products in their own file per country. Keep single file until > ~500 URLs; index is cheap though. | W-04 |
| `lastmod` | Real `updatedAt` of the entity only; drop `changefreq`/`priority`. | W-04 |
| What to include | Only indexable, canonical, 200 URLs; exclude empty taxonomy pages and search/filter URLs; product URL only when the product is active AND enabled for that country. Add image entries for product pages (Google image sitemap ext.) - optional. | W-04/W-05 |
| robots.txt additions | `Disallow: /*/search`, `/*/track`, `/*/order-success`, `/*?*sort=`, `/*?*page=` only if we decide parameter handling (section 7), `/not-available`. Keep the wildcard `/*/checkout/` etc. Do NOT disallow `/_next/static/` (Google needs CSS/JS to render). Add an explicit note-block allowing `Googlebot`, `Bingbot`, `Googlebot-Image`. | W-06 |
| AI crawlers | Business decision, not SEO: allow (visibility in AI answers) vs block (`GPTBot`, `ClaudeBot`, `Google-Extended`, `PerplexityBot`). Recommendation: **allow** search-oriented bots; a small brand benefits from being cited (ASSUMPTION). | Decision |
| Sitemaps reference | Keep the sitemap URL in robots.txt; also submit in GSC + Bing. | - |
| Header on these files | Must NOT carry `X-Robots-Tag: noindex` after launch (F3) — check separately; a noindex header on `sitemap.xml` is an easy post-launch trap. | Runbook |

---

## 4. Canonical and hreflang for `/in` and `/us`

Architecture (decision 0004): subdirectory per country, each page its own canonical (never point `/us/x` canonical at `/in/x`). Implemented via `buildCountryAlternates()` in `lib/countries.ts`; observed output on India pages:
```
<link rel="canonical" href="https://thewoodvintage.com/in/category/beds"/>
<link rel="alternate" hrefLang="en-IN" href=".../in/category/beds"/>
<link rel="alternate" hrefLang="x-default" href=".../in/category/beds"/>
```
Rules for the plan:
1. **While only IN is enabled**: keep exactly this (self-referencing `en-IN` + `x-default`). Do not publish `en-US` hreflang to a `/us` that is not public/indexable — hreflang needs reciprocal, crawlable targets or Google ignores it.
2. **When `/us` opens** (see us-uae-seo-plan.md): every page that exists in both markets gets three tags: `en-IN`, `en-US`, `x-default`; pages that exist in only one market get only their own self-tags (a product not enabled for the US must not list a US alternate — it would 404 there per sitemap comment). The generator already filters by enabled countries; confirm it also filters by "this product is enabled for that country" (decision 0032).
3. `x-default`: currently `/in` for everything. With a second market, x-default should be a page for users of *unlisted* countries. Because 0036 sends every non-served visitor to `/not-available`, **x-default = the primary market (`/in`) is fine** — but the honest user experience for a Canadian searcher is the "not available" page; accept this.
4. Root domain: `/` -> 307 `/in`. Fine for users; Google will consolidate. Prefer **302/307 only while multi-market routing stays geo-based**; do not use 301 (a permanent redirect would permanently attach the root to whichever market Googlebot happened to be routed to).
5. Add hreflang and canonical on the currently bare pages (F4).
6. Keep `og:locale` per market (`en_IN`, `en_US`, `en_AE`).
7. Page content must be *genuinely* different per market (currency, price, delivery, spelling) — near-identical duplicates across `/in` and `/us` with only price changes are fine when hreflang'd, but not a reason to expect separate rankings.

---

## 5. Geo-lock and crawlers (decision 0036) — cloaking policy and the safest approach

**What happens today (VERIFIED in `middleware.ts`):** real visitors are located by IP and redirected (307) to their market or shown `/not-available`; requests whose User-Agent matches `googlebot|bingbot|...` skip the lock entirely and get whatever `/<country>/` URL they asked for. The crawler match is by UA string only (spoofable; no reverse-DNS check).

**What Google says (VERIFIED, accessed 2026-09-25):**
- Locale-adaptive pages: "Google might not crawl, index, or rank all your content for different locales." Googlebot crawls mostly from US IPs, "in addition to" non-US IPs, and sends no `Accept-Language`. Google *recommends separate locale URLs + hreflang* instead of adapting by IP — which is what we have. Also: treat Googlebot like a visitor from its apparent location ("if you block USA-based users ... your server should block Googlebot if it appears to be coming from the USA"). Source: https://developers.google.com/search/docs/specialty/international/locale-adaptive-pages
- Cloaking = "presenting different content to users and search engines with the intent to manipulate search rankings and mislead users"; sneaky redirects = redirecting users somewhere "significantly different" from what search engines see. Source: https://developers.google.com/search/docs/essentials/spam-policies

**Risk assessment (analysis, ESTIMATE):**
| Risk | Level | Why |
|---|---|---|
| Manual action for cloaking | Low | Content per URL is identical for crawler and for a local human; the crawler is *not* shown a nicer page, it is just not bounced. Intent is not deceptive. But it is a documented grey zone: crawler is treated more permissively than a US-IP human. |
| Googlebot from a US IP redirected away from `/in` if UA-exemption breaks (e.g. UA list stale, regex bug, new crawler like `Google-InspectionTool`/`GoogleOther`) | Medium | Then Google sees `/in` -> 307 `/us` (or `/not-available`) and may index the wrong thing or nothing. The regex already includes `google-inspectiontool`, `adsbot-google`; it lacks `googleother`, `storebot-google`, `google-read-aloud`, `googlebot-image` (covered by `googlebot` substring). **Merchant Center's `Google-InspectionTool`/`Storebot-Google` must reach product pages** or feed checks fail. |
| UA spoofers see other markets | Low | Prices are still computed server-side per market; acceptable per 0036. |
| Users from Google (US-based searcher on an /in result) get "not available" | Certain, by design | Correct for an India-only shop, but shows in Search Console as US impressions with ~0 CTR/engagement; ignore, do not chase. |
| Indian mobile users whose IP geolocates outside India (roaming, VPN, Jio CGNAT mislocation) are locked out | Medium | Hurts conversions more than SEO; mention in the psychology tracker. |

**Recommended approach (safest, in order):**
1. **Keep the UA exemption, but verify crawlers properly** (W-07): for requests claiming to be Googlebot/Bingbot, match against Google's published IP ranges (https://www.gstatic.com/crawling/ipranges/common-crawlers.json, `special-crawlers.json`, `user-triggered-fetchers.json`) or reverse-DNS + forward-DNS to `googlebot.com`/`google.com` (https://developers.google.com/search/docs/crawling-indexing/verifying-googlebot), Bing via `https://www.bing.com/toolbox/bingbot.json`; cache the result per IP. Unverified "Googlebot" gets treated as a normal visitor. This removes the spoof risk and any "you serve bots differently by UA claim" argument.
2. **Never vary content by UA** — only skip the redirect. No extra text, links or schema only for bots.
3. **Do not redirect the crawler's *own* market URL**; also serve all enabled markets to every crawler (already true).
4. **Prefer softer UX for humans as markets grow** (Google's own recommendation): when a second market opens, replace the hard 307 for *organic landing pages* with a dismissible banner "You appear to be in X - view the X store", keeping the hard lock only at checkout/price-authority (server-side pricing enforcement already exists per 0036). This eliminates the crawler/human asymmetry. Needs the owner's OK because 0036 was a client requirement ("no switcher; lock by location").
5. Serve `/not-available` with **HTTP 200 + noindex** (current) — fine; ideally 451/403 is not needed. Keep out of the sitemap.
6. Monitor: GSC "Page indexing" for `/us/*` when opened; Crawl Stats (by response code) for any spike in 307/403.

---

## 6. Core Web Vitals on a slow 2-CPU server

No field data exists (no traffic; CrUX will not show until enough Chrome users visit). Lab facts so far (VERIFIED): TTFB ~0.5-0.9 s uncached SSR, HTML 47 KB gzipped, 43 scripts, three Google-Font families (Inter, Cormorant Garamond, Playfair Display, `display=swap`), MUI + emotion inline CSS (large HTML), hero image `loading=eager` w/ srcset + AVIF.

| Area | Recommendation | Change |
|---|---|---|
| Caching of HTML | Public marketing pages (home, category, product, blog, content pages) do not need `no-store`. Use ISR/`s-maxage=300, stale-while-revalidate=86400` at nginx (`proxy_cache`) for `GET` HTML **without cookies**; bypass on `wv_country`/auth cookies... but note the geo lock is per-visitor (middleware runs before cache) — cache key must include the resolved market (`/in/...` path already does). Even a 60-s micro-cache flattens Googlebot bursts on 2 CPUs. | W-08 |
| Crawl budget | Small site; no issue if TTFB stays < 1 s. Watch GSC Crawl Stats "average response time"; > 1 s consistently = slower crawling. | Monitor |
| LCP | Homepage LCP = hero image. Keep hero <= 100 KB AVIF at mobile width (currently 99 KB at 828w), `fetchpriority="high"` + preload of the first hero (the HTML preloads the logo instead - VERIFIED `<link rel="preload" as="image" href="/logo-horizontal.png"/>` — wrong priority target). Product page LCP = first product image: same treatment. | W-09 |
| Fonts | 3 families x many weights = render-blocking Google CSS. Self-host (next/font) 1-2 families (Inter + one display), subset Latin, weights 400/600/700 only. | W-10 |
| JS | 43 script tags; audit with `ANALYZE=true npm run build` (already wired in `next.config.ts`); keep admin code out of storefront (0022 did this). Defer below-the-fold carousels (Reveal already IntersectionObserver-based). | W-11 |
| CLS | Reserve aspect ratios for images (Next `fill` inside sized boxes - good); avoid layout shift from announcement bar/promo strip; fonts swap. Test on real phone. | Test |
| INP | MUI + emotion hydration on a 4G Android is the risk; measure with PageSpeed Insights (mobile) once public, and Lighthouse locally via headless Chrome (not claude-in-chrome per project rule). | Test |
| Images | Backend `/img` pipeline is the right design (AVIF/WebP, immutable, 1-year TTL, `w` ladder). Pre-generate the ladder for new uploads to avoid first-hit CPU spikes on the 2-CPU box (first-hit conversion is CPU-heavy; ASSUMPTION - measure). Upload originals <= 2000 px, 85% quality. | W-12 |
| HTTP | HTTP/2 on, gzip on (VERIFIED 47 KB); enable Brotli in nginx (~15-20% smaller, ESTIMATE). | Ops |
| Third parties | GA4/Meta pixel/Clarity/WhatsApp widget: load after interaction or `afterInteractive`; every tag is INP cost. | W-11 |

Thresholds to hold at the 75th percentile mobile (Google web.dev, VERIFIED as published targets): LCP <= 2.5 s, INP <= 200 ms, CLS <= 0.1. Success metric in 90 days: PageSpeed Insights "mobile" Performance >= 70 lab on `/in`, category, product; field data appears in Search Console "Core Web Vitals" only after enough traffic (weeks-months).

---

## 7. Duplicate content, facets, pagination, variants (size/finish — decision 0039)

- **Shop/category filter & sort URLs**: `/in/shop`, `/in/category/<slug>` with filters (price, material, size, finish; taxonomy pages also exist for material/room/style). Rule: *one indexable URL per intent*. `/in/material/sheesham` (indexable landing) vs `/in/shop?material=sheesham` (filter state) -> the filter URL must canonicalise to the landing page or be `noindex,follow`; sort/price-slider/page params always `noindex` or canonical to the parent. Verify what `/in/shop?sort=...` emits today (not tested) - W-13.
- **Pagination**: use crawlable `?page=N` links (or "load more" + real links). `rel=prev/next` is ignored by Google; each page self-canonical; page >= 2 `noindex` is optional. With 2 products it is moot.
- **Size/finish variants (0039)**: one product URL per *design*, variants selected on-page (no separate URLs per size/finish) — this is what we want; do not create `/product/x-king` URLs. In JSON-LD use a `ProductGroup` + `hasVariant` **only if** each variant has its own price/SKU; otherwise one Product with `offers` as `AggregateOffer` (lowPrice/highPrice) — Google's variant guidance: https://developers.google.com/search/docs/appearance/structured-data/product (updated 2025-12-10, VERIFIED).
- **Same content in two categories/collections/combos**: product canonical is always `/product/<slug>` (no category in the URL - good).
- **`/combo/<slug>`** pages contain products already on their own pages: fine, but give them unique intro copy; keep out of sitemap until they exist.
- **Trailing slash/case/duplicate slugs**: `/in/Product/x`, trailing slash — verify Next redirect behaviour; 308 already common. Legacy category slug redirects exist (`legacyCategorySlugs`) 301 - good.
- **Country duplicates**: hreflang (section 4), not canonical-to-one.

---

## 8. Structured data — target spec (what to emit, when)

| Type | Where | Status (VERIFIED) | Target / rule |
|---|---|---|---|
| Organization | all pages (root layout) | `{name,url}` only | Add `logo` (square PNG >= 112 px), `sameAs` (Instagram, Facebook, YouTube, Pinterest, GBP, IndiaMART), `contactPoint` (WhatsApp/phone, `areaServed: IN`, `availableLanguage: [en, hi]`), `foundingDate`, `address` (Jodhpur), `hasMerchantReturnPolicy` at org level (Google supports org-level return policy). |
| WebSite | root | name,url | Add `potentialAction` SearchAction only if `/in/search?q=` is a real, indexable-safe URL (sitelinks searchbox is deprecated by Google in 2024 - low value; skip). |
| LocalBusiness / FurnitureStore | `/in/about` + `/in/contact` (a "Visit/Workshop" section) | not built (0023: needs `Store.lat/lng`) | Type `FurnitureStore` (schema.org, subtype of Store/LocalBusiness) with address, geo, openingHours, telephone, `image`, `priceRange`. **Only if** the workshop can be legitimately shown as a place customers visit (see india-seo-plan section 5 - GBP eligibility). If not customer-facing, use `Organization` + `areaServed` instead and do not fake opening hours. |
| Product + Offer | product pages | built (basic) but broken in prod (F1) | name, description, sku, brand, image[] (>= 3), `offers`: `price` (incl. GST for India), `priceCurrency`, `availability` (full URL: `https://schema.org/InStock` / `PreOrder` / `BackOrder` for made-to-order - pick `InStock` for ready stock, `BackOrder` when made-to-order), `itemCondition: NewCondition`, `url`, `priceValidUntil`, `seller`, `shippingDetails` (OfferShippingDetails: `shippingRate`, `shippingDestination: IN`, `deliveryTime` with `handlingTime` = production days + `transitTime`), `hasMerchantReturnPolicy` (MerchantReturnPolicy: `returnPolicyCategory`, `merchantReturnDays`, `returnMethod`, `returnFees`; for custom pieces state the real policy - "final sale" is allowed but must be true and visible on-page), `material`, `color`, `additionalProperty` (dimensions from 0039), `weight`. `mpn` = our SKU; no GTIN for handmade (Merchant Center: `identifier_exists = no`). |
| Review / AggregateRating | product pages | coded conditionally (`totalReviews > 0`) - good | **Only real, verified customer reviews** (`docs/claude/seo-rules.md`: never fake). Self-serving reviews about the Organization itself are not eligible for rich results; product reviews are. Homepage testimonials: never mark up. Until orders exist: emit none. |
| BreadcrumbList | product, category, taxonomy, collection, blog, artisans | built | Keep. |
| FAQPage | FAQ page + long guides | not built | Add for **content and AI-answer use**, not for rich results: Google restricted FAQ rich results in Aug 2023 to well-known government/health sites (ESTIMATE from memory - re-verify at developers.google.com/search/docs/appearance/structured-data/faqpage before promising anything). Cheap to add, near-zero risk. |
| Article / BlogPosting | blog posts | built (author = generic "Editorial") | Use a real named author (owner/master carpenter) with `Person` + `sameAs`, honest `datePublished/dateModified` (seed dates predate the site - fix at launch), `image` >= 1200 px wide. |
| VideoObject | product pages / "how it's made" posts with self-hosted or YouTube video | not built | `name`, `description`, `thumbnailUrl`, `uploadDate`, `duration`, `contentUrl/embedUrl`. Only for a video that is the main content of the page section. |
| ItemList | category/collection pages | ItemList on blog only | Optional; skip unless carousel-eligible. |
| HowTo | "how customisation works" | - | Google retired HowTo rich results in 2023; write the page for humans, skip the markup. |
| Offer catalogue for made-to-order | - | - | Show "Ships in ~N days" in both visible text and `handlingTime` - must match. |

Validation routine: Rich Results Test + Schema Markup Validator for every template (once per template, not per page), Search Console "Merchant listings"/"Products" reports weekly after launch.

---

## 9. Google Merchant Center (free listings, India) — steps and feed spec

Facts (VERIFIED from search results 2026-09-25; open the pages before submitting): free listings show products on the Shopping tab, Search, Images and knowledge panels at no cost (https://support.google.com/merchants/answer/13889434); create the account at merchants.google.com, country India, currency INR; for India the `price` attribute must **include GST** and equal the landing-page price (Google Merchant Center tax help https://support.google.com/merchants/answer/7052209 - snippet-level, re-check).

Steps:
1. Prereqs (also good SEO/trust): real contact page (phone, email, address), return + shipping + privacy pages, HTTPS, checkout that works, business name matching the site. Claim + verify the website URL in Merchant Center (via Search Console verification).
2. Feed: a scheduled-fetch feed hosted at e.g. `https://thewoodvintage.com/feeds/google-in.xml` (or TSV) generated from the product API for `country=IN` (W-14). Required attributes: `id` (SKU), `title` (<= 150 chars, front-load type + material + key attribute), `description`, `link`, `image_link` (+ `additional_image_link` up to 10), `availability` (`in_stock` / `preorder` / `backorder`; use `availability_date` for made-to-order), `price` (INR incl. GST) and `sale_price` (with `sale_price_effective_date` only when real), `brand` ("The Wood Vintage"), `condition: new`, `identifier_exists: no` (no GTIN on handmade), `mpn` (own SKU), `google_product_category` (e.g. "Furniture > Beds & Accessories > Beds & Bed Frames", "Furniture > Tables > Coffee Tables", "Home & Garden > Decor"), `product_type` (our category path), `color`, `material`, `size` (from 0039 dimensions), `product_weight`, `shipping_weight`, `shipping_label`, `item_group_id` (for variants).
3. Shipping/tax/returns configured in the Merchant Center account (India: flat/free-over-threshold, bulky-goods surcharge, delivery time = production + transit).
4. Wait for review (typically a few days; ESTIMATE). Fix "Automated item updates"/price mismatch warnings — price mismatch is the #1 rejection if the SSR price differs from the feed (0031/0039 size-based prices are a risk: feed the *starting* price and show "from" honestly, or one feed item per size).
5. Link Merchant Center to Search Console and GA4; enable "free listings" programme; after ~30 days consider Shopping ads/Performance Max (paid, out of scope here).
6. Keep Google's `Storebot-Google`/`Google-InspectionTool` crawlable (section 5).

Realistic expectation: free listings drive small but qualified traffic; for a new merchant with 15-50 SKUs expect tens, not hundreds, of clicks per month in the first 90 days (ESTIMATE; no benchmark found).

---

## 10. Search Console / Bing / Analytics setup (do all before launch; free)

1. **Google Search Console**: add a *Domain property* `thewoodvintage.com` (DNS TXT) — covers http/https, www and all `/in /us /ae` paths; ALSO add URL-prefix properties `https://thewoodvintage.com/in/` and later `/us/`, `/ae/` (per-market filtering; country reports without extra work). Submit sitemap after go-live (section 2). Settings -> Users: give the owner + agency read access.
2. **Bing Webmaster Tools**: import from GSC in one click; submit sitemap; verify robots.txt/IndexNow. (Bing also feeds DuckDuckGo/Yahoo/Copilot-style answers; India share is small but free — ESTIMATE.)
3. **GA4**: property + web stream; **do not** duplicate the custom analytics of decisions 0025/0026 — check that GA4 (if used) agrees with the internal event tracking; mark `generate_lead` (quote form/WhatsApp click), `begin_checkout`, `purchase` as key events; link to Search Console (Reports -> Collections). Turn on enhanced measurement. Set a filter for internal traffic (owner IP).
4. **Microsoft Clarity** (free heatmaps/session recordings) — helpful for conversion, mind the consent/privacy note.
5. **Google Business Profile** — see india-seo-plan.md section 5.
6. **Merchant Center** — section 9.
7. **UTM discipline**: every social/WhatsApp/ad/link in-bio uses `utm_source/medium/campaign`; organic-search is left untagged. Otherwise SEO gets "direct" traffic misattributed.
8. **Alerts**: GSC email for coverage/manual action; uptime monitor (UptimeRobot free) on `/in` and one product page — a 2-CPU box that times out kills crawling.
9. **Consent/privacy**: DPDP Act (India) notice on cookies/analytics - legal input needed (ASSUMPTION; not SEO).

---

## 11. On-page, internal linking, image SEO, thin content (rules; templates are in india-seo-plan.md section 3)

**Internal linking (currently: nav + footer + breadcrumbs + carousels; blog posts do not link to products - to verify)**
- Every guide links to its money page (category/collection/custom-furniture) with descriptive anchor text and to 2-3 sibling guides; every category links up to a hub (`/in/category/furniture`) and across to related material/room pages; product pages link to category + material + "care" guide + "how customisation works" + quote CTA.
- Add a **Guides hub** (`/in/blog` is a chronological list; a structured hub `/in/guides` with topic clusters helps) — W-15.
- Breadcrumbs exist (0021/0023) - keep.
- Footer: link the 6-8 money pages, not all 68 URLs.
- Avoid orphan pages (artisan pages linked from a directory only).

**Image SEO**
- File names are content-addressed/backend-generated (`seed-banner-hero-1.jpg`); for new uploads use descriptive slugs: `sheesham-wood-queen-bed-jodhpur.jpg` (W-12: admin upload slugifies from product name + angle).
- Alt text: product name + material + view ("Sheesham wood king bed, front view, honey finish"), no keyword stuffing; decorative images `alt=""`. VERIFIED 4 of 27 `<img>` on the homepage have no non-empty alt (some are legitimately decorative; the logo variants have alt).
- AVIF/WebP already done (F9). Provide 1200x1200 (1:1), 4:3 and 16:9 crops for Discover/Merchant listings; add `og:image` 1200x630 for each product.
- Image sitemap optional; Google Images traffic for furniture is real (Pinterest-like visual intent) — invest in photo quality.

**Thin content on a 2-product catalogue**
- Rule set: a page is indexable only if it has (a) >= 3 products or a >= 300-word original guide and (b) a unique title/description/H1. Otherwise `noindex,follow` and exclude from the sitemap (W-05).
- Until the catalogue grows, the *content* (guides, customisation pages, workshop story, real photos/video) is the indexable asset; category pages are secondary.
- Product descriptions: unique, never manufacturer-copied; the description formula is in india-seo-plan.md 3.3. The two live descriptions are already unique text (VERIFIED) but short (~90 words).
- Do **not** clone `/in/*` to `/us/*` copy 1:1 and index both when content is identical apart from price - hreflang handles it, but effort is better spent on US-specific pages (us-uae-seo-plan.md).

---

## 12. Website changes needed LATER (development is on hold — specification only)

| ID | Change | Route / file | Priority |
|---|---|---|---|
| W-01 | Make SSR `getProduct()` (and combo/collection/category fetches that depend on country) call the API over the internal URL (`INTERNAL_API_URL`, as middleware already does) or exempt server-to-server calls from `enforceRequestCountry` (trusted internal header/secret). Verify a `Product Not Found` never appears for an active product. | `app/[country]/(store)/product/[slug]/page.tsx`, `lib/*` fetch helpers, backend `requestCountry.ts` | P0 |
| W-02 | Same fix for `app/sitemap.ts` `getProducts/getCombos` and add a **post-deploy check**: sitemap product count == active products for the market. Set failure to *throw/log*, not silently return `[]`. | `app/sitemap.ts` | P0 |
| W-03 | Canonical + hreflang on every public page type (`shop`, `about`, `faq`, `contact`, `blog` index, `combos`, `collections` index, `artisans` index, `search`(noindex), policy pages). | each `layout.tsx` sibling (pattern from 0023) | P0 |
| W-04 | Sitemap index per country; real `lastmod`; drop priority/changefreq; exclude non-indexable URLs; image entries. | `app/sitemap.ts` | P1 |
| W-05 | **Indexability gate**: taxonomy/category pages emit `robots: noindex,follow` and drop out of the sitemap when product count < 3 (configurable) and no editorial text; flag in admin. | material/room/style/category/collection routes | P1 |
| W-06 | robots.txt additions (search, track, order-success, param patterns, not-available). | `app/robots.ts` | P1 |
| W-07 | Crawler verification (IP-range/rDNS, cached) for the 0036 exemption; add `googleother`, `storebot-google`, `google-safety` variants; log crawler decisions. | `middleware.ts` | P1 |
| W-08 | HTML caching for anonymous GET marketing pages (nginx `proxy_cache` or Next `revalidate` + `s-maxage`), keyed by path; purge on product/price change. | nginx + Next headers | P1 |
| W-09 | Preload/`fetchpriority=high` the real LCP image (hero, first product image); remove logo preload. | home + product template | P1 |
| W-10 | Self-host and subset fonts (1-2 families). | `app/layout.tsx` | P2 |
| W-11 | Bundle/third-party audit; defer non-critical tags. | build | P2 |
| W-12 | Image upload: descriptive filenames, mandatory alt in admin (`alt` required per image), min 4 images/product guidance, pre-generate width ladder at upload. | admin product form + backend `/img` | P1 |
| W-13 | Filter/sort/page parameter URLs: canonical to parent or `noindex,follow`; test `/in/shop?...`. | `shop`, `category` | P1 |
| W-14 | Product schema completion (shippingDetails, hasMerchantReturnPolicy, itemCondition, url, full-URL availability, BackOrder for made-to-order, AggregateOffer/ProductGroup for sizes, `og:type=product`); Organization schema completion; real-only Review; Google Merchant feed endpoint `feeds/google-in.xml`. | product page, root layout, new route | P0/P1 |
| W-15 | New pages: `/in/custom-furniture`, `/in/how-customisation-works`, `/in/made-in-jodhpur` (workshop), `/in/guides` hub, `/in/furniture-care` etc. (spec in india-seo-plan.md section 3.5). CMS route `[page]` already exists (0006 fixed?) - confirm `/cms/:slug` bug (0006) is closed before relying on it. | `app/[country]/(store)/[page]` or dedicated routes | P0 |
| W-16 | IndexNow ping on product/blog publish. | backend hook | P3 |
| W-17 | Artisan pages use `slug` not UUID; add `Person` schema (real makers only). | `artisans/[id]` -> `[slug]` (+ 301) | P2 |
| W-18 | `LocalBusiness/FurnitureStore` JSON-LD after `Store.lat/lng` migration (0023). | about/contact | P2 |
| W-19 | Remove seeded/placeholder content before launch: phone, testimonials, seed blog dates, artisan copy not matching the real workshop; Blog author -> real person. | CMS/DB | P0 |
| W-20 | 404 head cleanup (single robots meta); `/not-available` stays noindex 200. | `not-found.tsx` | P3 |
| W-21 | Localised Hindi content only if data justifies (`hi-IN` hreflang route). | later | P3 |

---

## 13. Pre-launch and post-launch check list (tick boxes)

Pre-launch (still noindex):
- [ ] W-01/W-02 verified with `curl` on 100% of active products
- [ ] Canonical + hreflang on all public templates
- [ ] Real contact data, policies, GST invoice, live payment test
- [ ] >= 12-15 products, 3+ photos each, taxonomy FKs set, alt text set
- [ ] Seeded/fake content removed (W-19)
- [ ] GSC domain + `/in/` property, Bing, GA4, Clarity verified
- [ ] Merchant Center account + feed built and validated (can be submitted before go-live; feed is not blocked by noindex... but Google's crawler checks pages, so submit after go-live)
- [ ] Rich Results Test passes on 1 product, 1 category, 1 blog post

Launch day: remove header -> curl checks -> submit sitemap -> inspect + request indexing (10 URLs) -> screenshot baseline.
Day 3 / 7 / 14 / 30: Pages report, sitemap "Discovered pages", Crawl Stats, brand query test (`"the wood vintage"` in Google.co.in), mobile PSI on 3 templates.

---
Sources (accessed 2026-09-25): Google locale-adaptive pages, spam policies, verifying Googlebot, Product structured data (URLs in section 5/7/9); Search Engine Land Mueller indexing-time item; Search Engine Journal Mueller sandbox item; repo files named above; live GET requests to thewoodvintage.com on 2026-09-25.
