# 0036. Storefront country locked by visitor location (no switcher)

Date: 2026-09-21

## Decision
The storefront market is decided by where the visitor is, not by what they choose. The country
selector is removed everywhere (navbar desktop + mobile drawer; the footer never had one) and replaced
by a read-only label ("US · $" / "Shipping to United States · $"). A visitor in the US who opens `/in/...`
is redirected (307) to `/us/...`; an Indian visitor on `/us/...` is sent to `/in/...`. A visitor located
in a country with no ENABLED market sees a designed "Not available in your region yet" page instead of a
wrong-market storefront. Supersedes the user-selectable `wv_country` behaviour of 0010 and the
"switching navigates to the equivalent path" rule of 0018.

## Why
Client requirement: users must not change country through the UI; country always comes from their
location (lat/lng). Also stops URL/cookie tampering from buying at another market's price.

## How
- **Backend `GET /api/v1/geo/resolve`** (`src/utils/geo.ts`, `src/modules/geo`) returns
  `{countryCode, lat, lng, source}`; `source` is `dev-override | cdn-header | geoip | default-private | unknown`.
  Order: dev override (non-prod) -> trusted CDN header (`cf-ipcountry`, `x-vercel-ip-country`) -> offline
  GeoIP (`geoip-lite`) -> private/localhost IP = default market (`default-private`) -> unknown public IP.
- **Trust model.** Client-controlled headers (XFF, x-real-ip, CDN country headers) are honoured only when
  `GEO_TRUST_PROXY=true`; otherwise only the TCP peer is used, so header spoofing cannot change location.
  `app.set('trust proxy', 1)` is unchanged but `geo.ts` deliberately does not use `req.ip`. With the flag on,
  the RIGHTMOST XFF entry is used (what the trusted hop saw). Deploy note: nginx must OVERWRITE, e.g.
  `proxy_set_header X-Forwarded-For $remote_addr;`, and the backend must not be publicly reachable except via
  nginx/Next.
- **Dev/test override (never when NODE_ENV=production):** env `GEO_DEV_OVERRIDE=US`, or `?__geo=US`
  (middleware also stores it in a `__geo` cookie).
- **Frontend `middleware.ts`** calls `/geo/resolve` (forwarding the client IP and CDN headers, 1.5 s timeout,
  cached 60 s per IP+headers) and enforces: wrong/missing segment -> 307 to the visitor's market; no enabled
  market -> rewrite to `/not-available` (noindex, static, mailto contact — no lead form, kept trivial).
  Exempt: `/admin*`, `/admin-login`, `/account`, `/login`, `/register`, `/api`, `/_next`, `/not-available`,
  static assets/robots/sitemap (matcher), and search-engine crawlers.
- **`wv_country` cookie** is now a derived hint written by middleware (24 h) so routes without a country
  segment (`/account`, `/login`) know the market. Nothing in the UI writes it; `CountryContext` has no
  `setCountry`, resolves URL -> hint (validated against `/countries`) -> default.
- **Server-side hardening** (`src/utils/requestCountry.ts`, `enforceRequestCountry`): product list/detail/
  featured/trending/new/best/search and `POST /orders` derive the market from the request's resolved
  location. Mismatching client claim: logged (`[geo-lock]`), located market wins; order creation is strict
  (403 `COUNTRY_MISMATCH`). Located country with no enabled market: 403 `REGION_UNAVAILABLE`. Admins/sub-admins
  exempt. No real location (localhost/private, unknown IP) -> claim passes through unchanged. The order change
  is a one-line edit in `order.controller.ts` (not the service).
- **Dependency:** `geoip-lite` 1.4.10 (Apache-2.0 code; bundles MaxMind GeoLite data, CC BY-SA 4.0 /
  GeoLite EULA — attribution "This product includes GeoLite data created by MaxMind, http://www.maxmind.com"
  belongs in the site's legal/credits page; refreshing the data needs a free MaxMind licence key via
  `npm run-script updatedb`). Data loads into ~100 MB of RAM at first lookup. Chosen over a hosted API for
  zero per-request latency/cost and no third-party data sharing.

## Honest limits
- IP geolocation is approximate (city-level at best, wrong for some mobile/corporate/satellite IPs).
- VPN/proxy users can appear in any country; this is a commercial default, not a security boundary.
- Browser Geolocation (true lat/lng) needs a permission prompt, so IP-derived coordinates are used.
- **SEO/crawler exemption:** Googlebot, Bingbot, etc. are matched by User-Agent and skip the lock so every
  enabled `/<country>/` page stays crawlable with hreflang. The UA is spoofable (risk: a spoofer sees another
  market's pages; the backend still prices from its own rules) and reverse-DNS verification was not
  implemented. Google may also crawl from a US IP and would otherwise be redirected away from `/in`.
- **Fail-open:** if the geo service is down/slow, or the IP is not in the database, the visitor gets the default
  market — availability over strictness. During an outage the lock is not enforced. If the enabled-country list
  cannot be fetched at all, middleware passes through instead of showing everyone the region page.
- Middleware still caches the enabled-country list for 5 minutes (known), so a newly enabled/disabled market
  takes up to 5 minutes to affect the lock. Visitor-location cache is 60 s.
- Server-side enforcement only bites when the visitor IP is visible to the backend (production with
  `GEO_TRUST_PROXY=true`). SSR calls from the Next server carry no visitor IP and are treated as internal
  (already gated by middleware). In dev, use `GEO_DEV_OVERRIDE`.
- A shopper travelling abroad is moved to the local market (or the region page); their cart does not follow.
- `/not-available` returns HTTP 200 (a rewrite cannot set a status).

## Consequences
Multi-market SEO is unchanged for bots; humans get exactly one market. Follow-ups: wire the same helper into
other country-aware endpoints (homepage/banners/CMS) if needed; reverse-DNS crawler verification; MaxMind
attribution text; optional notify-me capture on the region page.

## Verification (2026-09-21)
Real requests via `?__geo=` on the running dev stack (see CHANGELOG): IN->/in ok, IN->/us => /in, US->/in => /us,
US->/us ok with `$`, FR => region page, Googlebot serves /in and /us, admin/robots/sitemap unaffected, localhost =>
default market, geo service down (stub returning 500) => default market. Backend helper unit-checked with real IPs
(8.8.8.8 -> US, 49.36.0.1 -> IN) and CDN header (DE, FR->403).
