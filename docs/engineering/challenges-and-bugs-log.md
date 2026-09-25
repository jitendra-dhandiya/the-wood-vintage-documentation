# Challenges and bugs log

Compiled 2026-09-25 from `docs/decisions/`, `daily-log/`, `CHANGELOG.md`, `docs/qa/2026-09-20-rebrand-qa.md`,
`docs/operations/server-runbook.md` and `docs/operations/server/*`, `skills/SKILLS.md`, `tasks/TASKS.md`,
`docs/claude/technical-debt.md`, and `git log` of the backend, frontend and documentation repos.

Purpose: a searchable memory of real bugs, non-obvious gotchas and deployment traps so they are not rediscovered.
Entries marked **(from project knowledge)** were described to the log's author but have no written record in the
repo docs I could open; the symptom/cause is stated as reported and should be confirmed by whoever hit it.
Commit hashes are from the repos named in each row (BE = `backend`, FE = `frontend`, DOC = `documentation`).
No entry claims a fix that the repo does not show.

Format per entry: **Symptom / Root cause / Fix / Prevent-detect / Status / Refs.**

---

## 1. Chronological timeline

| Date | ID | One-line |
|---|---|---|
| 2026-09-09 | SEC-01 | Client-controlled prices in order totals |
| 2026-09-09 | DAT-01 | Stock not restored on cancel; InventoryLog unused |
| 2026-09-09 | CFG-01 | Frontend `API_URL` hard-coded to the old production API |
| 2026-09-09 | ROU-01 | CMS pages 404 (`/cms` vs `/seo/cms`) |
| 2026-09-09 | DEP-01 | Critical/high npm vulnerabilities (next, swiper) |
| 2026-09-09 | DAT-02 | `db push` only, no migration history |
| 2026-09-10 | TST-01 | Orphaned dev server produced a phantom 500 |
| 2026-09-10 | TST-02 | Hydration warning that was Chrome autofill |
| 2026-09-10 | TST-03 | Test-data drift from direct SQL deletes |
| 2026-09-10 | TST-04 | claude-in-chrome cannot reach the sandbox localhost |
| 2026-09-10 | PAY-05 | Checkout ignored per-product shipping override |
| 2026-09-13 | BUG-01 | `GET /orders/my` NaN pagination |
| 2026-09-13 | TST-05 | `.next` mixing build and dev output |
| 2026-09-13 | ARC-01 | Country middleware already existed; spec assumption wrong |
| 2026-09-13 | ARC-02 | `CmsPage.slug` globally unique blocked country overrides |
| 2026-09-17 | SEO-01 | Fashion-era metadata, hard-coded INR in JSON-LD, footer 307 hops |
| 2026-09-17 | PAY-01 | Currency mischarge on Razorpay/Cashfree |
| 2026-09-17 | DAT-03 | `Order` had no country FK |
| 2026-09-20 | BUG-02..05 | Blog 404, `/admin-login` 404, fashion data on boot, free-shipping threshold |
| 2026-09-20 | BRD-01..02 | Rebrand leftovers, doubled brand in titles |
| 2026-09-21 | PAY-02 | Coupon engine defects (case, limits, currency, silent drop) |
| 2026-09-21 | UI-01..03 | Breadcrumbs covered, fixed-position sticky bar, framer SSR `opacity:0` |
| 2026-09-21 | GEO-01 | Geo-lock design traps (cache, crawler, fail-open) |
| 2026-09-24 | OPS-01..07 | Production provisioning and deploy gotchas |
| 2026-09-25 | PAY-03 | Variant sale price ignored by checkout |

---

## 2. Categorised log

### A. Security and data integrity

#### SEC-01 Order totals trusted client-supplied prices
- **Symptom:** ordering a real Rs 399 product while sending `price: 1` charged Rs 1 (reproduced before the fix).
- **Root cause:** `order.service.ts` computed `subtotal` from `data.items[].price`.
- **Fix:** `effectivePrice()` re-derives price server-side (`variant.price ?? product.salePrice ?? product.basePrice`). Later generalised into the single pricing engine (0035) and `unitPriceFor`.
- **Prevent/detect:** verify security fixes by attempting the exploit, not by reading the diff (SKILLS 2026-09-09). Add an automated test that posts a tampered price.
- **Status:** Fixed. **Refs:** 0003, BE `2e2f827`, 0035.

#### DAT-01 Stock never restored when an order was cancelled
- **Symptom:** cancelled orders leaked inventory and inflated `totalSold`; `InventoryLog` written nowhere.
- **Root cause:** `cancelOrder()` did not reverse stock; no writes to `InventoryLog`.
- **Fix:** transaction restoring `stockQuantity`/`totalSold` and writing `SALE`/`RETURN` log rows.
- **Prevent/detect:** invariant check job: `stock + sum(open order qty) == initial`; tests for cancel.
- **Status:** Fixed for `POST /orders/:id/cancel`. **Still open:** admin status change to CANCELLED does not restore stock (0035, 0037).
- **Refs:** 0008, BE `bf811c8`, OPN-02.

#### DAT-02 No migration history (`db push`)
- **Symptom/risk:** `db push` can silently drop columns; no audit trail.
- **Fix:** reset the seed-only dev DB and generated baseline `20260909115445_init`; `prisma migrate` from then on; production uses `prisma migrate deploy` (deploy.sh).
- **Prevent:** never `db push` against shared data; CI check that `prisma migrate diff` is empty. **Status:** Fixed. **Refs:** 0003, BE `2e2f827`.

#### DAT-03 Fashion-era demo data re-created by `initDatabase()` on every boot
- **Symptom:** after seeding handicraft data, restarting the backend re-created fashion categories, collections, coupons, CMS copy and "Unique Dressup" settings; stale fashion collections reappeared.
- **Root cause:** boot-time create-if-missing defaults in `server.ts` still held fashion values (a `Home Decor` name also needed to match the seeded slug).
- **Fix:** boot defaults are handicraft (`a2d1305`); `seed:handicraft` removes a hard-coded list of old rows (0028).
- **Prevent/detect:** boot-time defaults should live in one seed module shared with the catalogue seed; a smoke test that boots on an empty DB and asserts no `Unique Dressup` string anywhere (`grep -ri` in DB dump).
- **Status:** Fixed. **Refs:** 0028, 0029, BE `a2d1305`, QA defect 3.

#### DAT-04 `Order.countryId` missing entirely
- **Symptom:** country-level dashboards impossible; only a free-text country name in a JSON snapshot.
- **Fix:** FK + `GET /analytics/country-breakdown`. **Status:** Fixed. **Refs:** 0024, BE `ce44722`.

#### DAT-05 `CmsPage.slug` globally unique
- **Symptom:** country overrides of a CMS page could not exist. **Fix:** uniqueness reworked so country overrides can coexist (exact key per 0010). **Status:** Fixed. **Refs:** 0010, BE `9c7d0ad`.

#### DAT-06 Seeded content idempotency
- **Symptom:** a failed homepage seed run left the homepage empty (delete then create not atomic); sort orders skipped on re-runs.
- **Fix:** delete+create in one transaction; photo slots carry a sidecar signature (source|crop|size) so changes are detected. First run after adding images takes about 10 min to pre-warm derivatives (`SEED_SKIP_PREWARM=1`).
- **Status:** Fixed. **Refs:** 0030, BE `975b5c0`.

### B. Payments, pricing and money

#### PAY-01 Currency mischarge on Razorpay/Cashfree for non-INR orders
- **Symptom (latent):** an AED order total would have been submitted to the gateway labelled INR, charging about 22x too little, silently.
- **Root cause:** `payment.controller.ts` hard-coded `currency: 'INR'` while `order.total` was already in the order's country currency.
- **Fix:** resolve the order's real currency and refuse online payment when it is not INR (COD unaffected). Verified by temporarily enabling AE, then cleaning up.
- **Prevent/detect:** unit test asserting gateway payload currency equals order currency; never enable a market without a settlement-capable gateway.
- **Status:** Fixed (guard, not a multi-currency solution). **Refs:** 0027, BE `fd084de`, OPN-01.

#### PAY-02 Coupon engine: many silent failures
- **Symptoms:** case-sensitive codes; `userLimit` never enforced; limit overshoot under concurrency; invalid coupon silently ignored yet stored on the order; `/cart/coupon` trusted client `cartTotal`; public `/coupons/:code/check` leaked the row; rupee amounts applied in any currency; `BUY_X_GET_Y` validated and did nothing; admin create/update spread `req.body` into Prisma; cancel never returned the coupon; WELCOME10 claimed "first order" but nothing enforced it.
- **Fix:** one `PricingService.quote()` + `CouponService`; `SELECT ... FOR UPDATE`, conditional increment, `CouponUsage` ledger, per-country money terms, revert on cancel/return/refund, whitelisted input. Verified with 6 parallel orders on a limit-1 coupon (1 wins).
- **Prevent:** preview and charge must call the same function (a test that compares them). **Status:** Fixed; abandoned PENDING online orders still hold redemptions (OPN-05).
- **Refs:** 0035, BE `c15781b`.

#### PAY-03 Variant sale price ignored by checkout
- **Symptom:** seeded size variants (price = list, salePrice = selling) were charged list price; Queen bed showed 64,900 only after the fix.
- **Root cause:** `unitPriceFor` and cart add ignored `ProductVariant.salePrice`.
- **Fix:** honour variant sale price (sale < price) in engine and cart add; PDP shows the chosen variant's price.
- **Prevent:** golden test of price precedence (variant sale > variant price > market override > sale > base). **Status:** Fixed; variant prices remain base-currency (OPN-06).
- **Refs:** 0039, BE `857b69c`.

#### PAY-04 Free-shipping threshold announced but not applied
- **Symptom:** banner said above Rs 4,999, cart used 999, backend never applied any threshold; a 5,590 order would have been charged shipping.
- **Root cause:** three unsynchronised sources (marquee copy, frontend constant, no backend logic).
- **Fix:** backend applies `free_shipping_threshold` to Standard delivery; checkout mirrors; constants and copy set to 4,999; verified a 5,590 order totals 5,590.
- **Prevent:** derive banner copy and cart threshold from `/settings/public`; contract test comparing cart preview and order total. Constants still carry a "keep in sync" comment (`constants/index.ts`), so drift is possible.
- **Status:** Fixed, with residual drift risk. **Refs:** 0029, BE `b398220`, FE `93e000e`, OPN-03.

#### PAY-05 Checkout displayed flat shipping despite per-product override
- **Fix:** frontend mirrors the backend max-across-items rule. **Gap:** first verified without a browser; combo-only overrides still not mirrored (0037). **Refs:** 0011, FE `76c55e4`. **Status:** Fixed (display); server total authoritative.

#### PAY-06 Cashfree/Razorpay keys are placeholders; COD needs Cashfree
- **Symptom:** payment step 500s; COD path collects a delivery deposit through Cashfree so COD was no workaround.
- **Root cause:** no real credentials; design couples COD to an online deposit.
- **Status:** Open: needs real keys (TASKS "THE remaining blocker"). Cashfree SDK mode is hard-coded `production` in `checkout/page.tsx`. **Refs:** 0013, TASKS.

#### PAY-07 Shipping charge single-source-of-truth
- **Symptom:** FAQ/shipping policy quote 79/149/249 (code), admin settings say 199/499 (unused by the order service). Production settings show 199/499.
- **Status:** Open. **Refs:** QA 2026-09-20, OPN-03.

### C. Routing, middleware and geo

#### BUG-01 `GET /orders/my` threw a Prisma validation error with no query string
- **Symptom:** 500/Prisma error for `GET /orders/my` without params.
- **Root cause:** `getUserOrders`/`getAllOrders` destructured only `{ skip }` from `paginationParams()` and passed raw `Number(req.query.limit)` (NaN) to `take`. JS defaults apply only to `undefined`, not `NaN`. Response metadata echoed NaN too.
- **Fix:** destructure sanitised `page` and `limit`; same fix in admin list. Grep found no other callers with the pattern.
- **Prevent:** validate/coerce query params in one Joi middleware; test each list endpoint with no params. **Status:** Fixed. **Refs:** 0019, BE `68db808`.

#### BUG-02 Blog detail 404 and empty covers/authors
- **Root cause:** frontend fetched `/blog/:slug`, API is `/blogs/:slug`; frontend used `coverImage`, `category`, `author` that the API does not return.
- **Fix:** endpoint corrected plus `lib/blog.ts` normaliser. **Prevent:** typed API client generated from route table; e2e check that each seeded post URL returns 200. **Status:** Fixed. **Refs:** QA defect 1, FE `408efba`.

#### BUG-03 `/admin-login` 404 behind the country middleware
- **Root cause:** middleware matcher redirected it under the country prefix. **Fix:** exempt route (and later the geo middleware exempts `/admin*`, `/admin-login`, `/account`, `/login`, `/register`). **Prevent:** route-smoke test listing every non-country route. **Status:** Fixed. **Refs:** FE `c964491`, 0036.

#### ROU-01 CMS pages 404
- **Root cause:** frontend called `/cms`, backend serves `/seo/cms`. **Fix:** URL. **Status:** Fixed. **Refs:** BE CLAUDE §25 #7, FE `3f4763c`.

#### ARC-01 Spec assumed the app had no middleware
- **Symptom:** the URL-restructuring spec said "no middleware"; a deliberate one already existed. **Fix:** spec corrected; middleware extended for country prefix. **Lesson:** verify assumptions against code before writing specs. **Refs:** 0018, DOC `0eda436`, FE `a866124`.

#### SEO-01 Fashion-era metadata, INR in JSON-LD, unprefixed footer links
- **Symptoms:** five indexed pages shipped fashion fallback titles; Product JSON-LD hard-coded `priceCurrency: 'INR'` and brand `LUXÉ`; every footer link forced a 307; blog detail missing canonical/hreflang; titles doubled the brand ("X | The Wood Vintage | The Wood Vintage") because `NEXT_PUBLIC_SITE_NAME` was set wrong.
- **Fix:** sibling `layout.tsx` metadata for client pages, `withCountry()` in footer, Article/Breadcrumb JSON-LD, title fix. **Prevent:** SEO crawl test asserting no `Unique Dressup`/fashion tokens and correct currency. **Status:** Fixed; bottom-nav and some account links are still not country-prefixed (see GAP tracker CON-12). **Refs:** 0023, FE `0319c4a` `77fe00d` `ebba75b` `0547b50`.

#### GEO-01 Geo-lock design traps
- **Traps recorded:** country list cached 5 minutes in middleware (a newly enabled/disabled market takes up to 5 min to bite; visitor cache 60 s); crawlers must be exempt by UA or Google (US IP) is redirected away from `/in`; fail-open to the default market when the geo service is down; `/not-available` returns 200; header spoofing only safe with `GEO_TRUST_PROXY` and an overwriting proxy; SSR calls from the Next server carry no visitor IP.
- **Prevent:** monitor `[geo-lock]` log lines and the share of `source=unknown`; reverse-DNS verify crawlers (not implemented).
- **Status:** Known limits. **Refs:** 0036, BE `ee593ef`, FE `ff42086`.

### D. Frontend rendering and UI

#### UI-01 Breadcrumbs covered by the product grid and not clickable
- **Symptom:** breadcrumb links on the PDP did nothing. **Root cause (as reported):** the image/summary grid used a 48px negative-margin overlap that painted over the breadcrumb row **(48px figure from project knowledge; commit message only says "covered by the image grid")**. **Fix:** breadcrumb row given `position: relative; zIndex: 2` (`ProductDetailClient.tsx`); combo page verified with `elementFromPoint`. **Prevent:** click-through test with `document.elementFromPoint` on key links. **Status:** Fixed. **Refs:** FE `bede855`, 0037.

#### UI-02 Sticky mobile quote bar resolved against the whole page
- **Root cause:** page-transition wrapper left a transformed ancestor, so `position: fixed` was relative to it. **Fix:** portal to `<body>`. **Prevent:** avoid transforms on layout wrappers; visual test scrolling a PDP at 390px. **Status:** Fixed. **Refs:** 0034, FE `56fbb2f`.

#### UI-03 Reveal animations rendered content invisible until hydration
- **Root cause:** framer-motion SSR `opacity:0`, and framer disabled below 900px so phones behaved differently. **Fix:** CSS + IntersectionObserver `Reveal`, hero entrance CSS-only, reduced-motion catch-all. **Prevent:** disable JS in a test render and assert text visible. **Status:** Fixed. **Refs:** 0033, FE `34eeee3`.

#### UI-04 Placeholder images baked in titles that duplicated overlays
- **Fix:** quiet placeholders, regenerate with `SEED_FORCE_IMAGES=1`. **Status:** Fixed; real photography outstanding. **Refs:** QA defect 8, BE `594ad46`.

#### UI-05 Rebrand leftovers
- **Symptoms:** "Unique Dreessup" misspelt in admin sidebar, Gender selector/filter, fashion category names, email layout brand, export creator, env defaults, contact page `+91 XXXXX XXXXX`, footer with 13 grid columns, Finish filter chips matching no product.
- **Fix:** many commits (`3c4b56a`, `96709fb`, `271935b`, `c8a7057`). **Still open:** Gender selector in Add/Edit Product and `seedGenderDemo.ts`. **Prevent:** repo-wide brand-string grep in CI.
- **Status:** Mostly fixed. **Refs:** 0029, QA defects 4-13.

#### UI-06 Size/Finish vocabulary was fashion-shaped
- **Fix:** Size / Dimensions and Finish system with derived structured dimensions; duplicate size+finish 409; 60-char cap. **Status:** Fixed. **Refs:** 0039.

### E. Testing and tooling

#### TST-01 Orphaned `next-server` caused a phantom 500
- **Root cause:** `TaskStop` did not kill a detached child; new dev server hit `EADDRINUSE` and the stale server answered. **Fix/prevent:** after stopping, `ss -ltn | grep :PORT`; kill by PID, not pattern. `pkill -f <pattern>` also missed a headless Chrome whose argv did not match. **Related trap (from project knowledge):** `pkill -f <pattern>` run over `ssh 'pkill -f pattern'` can match the ssh command line/remote shell itself and kill its own session; use `pgrep -x`/PID files or a bracket pattern (`[p]attern`). **Status:** Process rule. **Refs:** SKILLS 2026-09-10, daily-log 2026-09-10.

#### TST-02 Hydration mismatch that was Chrome autofill
- **Root cause:** reused Chrome profile autofilled `firstName`/`phone` before hydration. **Detect:** re-run with a fresh `--user-data-dir`. **Status:** Not a bug. **Refs:** SKILLS 2026-09-10.

#### TST-03 Test-data drift from deleting orders directly
- **Symptom:** `stockQuantity/totalSold` of the demo product drifted (98/2, 99/1) after direct SQL deletes of test orders. **Root cause:** deleting rows bypasses the cancel flow that restores stock. **Fix:** corrected manually; rule: cancel via `POST /orders/:id/cancel`, then delete. Recurred in 0024/0025, so it was a repeated lesson. **Prevent:** a `scripts/reset-test-data` that cancels then deletes, and an invariant check after every QA run (0 orders, stock = seed). **Status:** Process rule. **Refs:** 0013, 0024, 0025, daily-log 2026-09-10.

#### TST-04 claude-in-chrome cannot reach the sandbox localhost
- **Fix:** use local headless Chrome via CDP (SKILLS). User preference: never use claude-in-chrome on this project. **Refs:** SKILLS, memory.

#### TST-05 `.next` mixing production build and dev output
- **Symptom:** page loads but nothing interactive; dev chunk names 404 silently. **Fix:** `rm -rf .next` between `npm run build` and `npm run dev`. **Refs:** SKILLS 2026-09-13.

#### TST-06 Login validator rejects `.local` emails; OTP login broken in dev
- **Symptom:** `admin@woodvintage.local` cannot log in via `POST /auth/login`; QA had to mint a JWT from the backend secret. **Root cause:** Joi email validation with TLD list (pre-existing). **Fix:** none; use a real-TLD admin email. **Prevent:** `ADMIN_EMAIL` must have a valid TLD; seed script should validate it against the same schema. **Status:** Open (by design). **Refs:** 0028, QA.

#### TST-07 Only SSR/`curl` verification for client components
- **Symptom:** several early fixes shipped with "disclosed gap: not browser verified". **Fix:** local headless Chrome CDP scripts. **Status:** Resolved for later work; no automated suite exists (backend CLAUDE §23).

### F. Operations and deployment (production VPS, 2026-09-24)

#### OPS-01 nginx overwrote X-Forwarded-For and mislocated visitors
- **Symptom:** the geo lock received the proxy's IP for server-to-server calls made by Next middleware, so visitors were mislocated. **Root cause:** nginx `proxy_set_header X-Forwarded-For $remote_addr` (required for trust) replaced the chain for calls that went through nginx. **Fix:** middleware calls the API over `INTERNAL_API_URL=http://127.0.0.1:5000/api/v1` (build-time and PM2 env) forwarding the visitor IP itself. **Prevent:** integration test from a non-local IP; ensure `INTERNAL_API_URL` is in `deploy.sh` (it is). **Status:** Fixed. **Refs:** runbook, FE `76c8c26`, 0036.

#### OPS-02 Next behind nginx built `https://localhost:3000` URLs
- **Symptom:** redirects leaked `https://localhost:3000/...`; the region-page rewrite returned 500. **Root cause:** Next derived the request URL from the upstream Host. **Fix:** tried `trustHostHeader` (`c3548de`, type error `f6bab87`), then dropped it and used a redirect instead of a rewrite (`c700c4b`) plus an nginx `proxy_redirect` safety net (`nginx-site.conf`). **Prevent:** after each Next upgrade, curl a foreign-country request and assert `Location` host. **Status:** Fixed. **Refs:** runbook gotcha 3.

#### OPS-03 sharp's prebuilt libvips crashes on a CPU without SSSE3/SSE4
- **Symptom:** image processing crashed (illegal instruction) on the VPS. **Root cause:** virtual CPU model lacks SSSE3/SSE4. **Fix:** `deploy.sh` rebuilds sharp 0.33.2 against system `libvips-dev` if `require("sharp")` fails; ask the provider for a `host` CPU model. **Prevent:** `node -e 'require("sharp")'` in deploy (already there) and a startup health check that encodes a tiny image. **Status:** Workaround in place. **Refs:** runbook gotcha 1, `deploy.sh`.

#### OPS-04 nginx 1.24 does not support `http2 on;`
- **Fix:** use `listen 443 ssl http2;` (`nginx-site.conf`). **Prevent:** `nginx -t` before reload in deploy; pin config to distro version. **Status:** Fixed. **Refs:** DOC `65b6db7`.

#### OPS-05 Certbot and DNS propagation **(from project knowledge)**
- **Symptom:** certificate issuance failed until DNS pointed at the server. **Repo evidence:** `nginx-http-bootstrap.conf` serves `/.well-known/acme-challenge/` from `/var/www/certbot` and 0038 says "TLS + vhost wait on DNS". **Fix/approach:** bring up an HTTP-only bootstrap vhost, verify `dig`, then run certbot and switch to the TLS vhost. **Prevent:** check `dig +short domain` matches the VPS IP before running certbot to avoid rate limits. **Status:** Resolved (site live on HTTPS).

#### OPS-06 Long frontend builds on 2 vCPU/3.7 GB
- **Symptom:** a frontend build takes about 10 minutes. **Mitigation:** PM2 cluster reload keeps the old build serving; 2 GB swap. **Risk:** memory pressure during build with MySQL and API running. **Prevent:** build off-box (CI or a beefier builder) and rsync `.next`, or resize before launch. **Status:** Open (accepted). **Refs:** runbook, 0038.

#### OPS-07 Interrupted build left `node_modules` half-installed (ENOTEMPTY) **(from project knowledge)**
- **Symptom:** subsequent `npm ci/install` failed with `ENOTEMPTY` (rename/rmdir on a partially written directory). **Fix:** `rm -rf node_modules` then `npm ci` (deploy.sh already uses `npm ci`, which removes it first, but an interrupted SSH session can still leave it mid-way). **Prevent:** run deploy inside `tmux`/`nohup` so an SSH drop does not kill it; `set -euo pipefail` (present) aborts before reload.
- **Status:** Process rule.

#### OPS-08 Legacy PM2 config names and paths
- **Risk:** repo `ecosystem` files carried `luxestore-api` and `/var/www/ud-webiste/ud-c`; replaced on first deploy (0038). **Prevent:** grep for old brand/paths in ops files.

#### OPS-09 Secrets exposure and hardening
- **Event:** root password shared in chat during setup; treated as burned, password auth off. **Prevent:** SSH keys only; rotate anything pasted into chat. **Open:** off-host backups, monitoring/alerting, staging, CDN. **Refs:** runbook, 0038.

#### OPS-10 Site is `noindex` until go-live
- **Gotcha:** `X-Robots-Tag` header in the nginx vhost; must be removed at launch or nothing ranks. **Detect:** checklist item and a post-launch `curl -I` check. **Refs:** runbook.

### G. Dependencies and environment

#### DEP-01 Critical/high npm vulnerabilities
- **Fix:** next `^15.5.25`, swiper `^14`, postcss override; backend 17 -> 2 remaining (`exceljs` transitive `uuid`, confirmed unreachable). **Prevent:** `npm audit` in CI; scheduled Dependabot. **Refs:** 0007, 0008.

#### CFG-01 Hard-coded API URL and a debug console.log leaking the backend host
- **Fix:** env-driven `API_URL`; removed `console.log`. **Refs:** FE `97e502d`.

#### ENV-01 Port conflicts on the shared dev machine
- **Rule:** frontend on 3030, backend 5000; check `ss -ltn` first (SKILLS 2026-09-09; CLAUDE.md).

#### ENV-02 Unsplash/Pexels blocked (403) from the sandbox
- **Workaround:** Wikimedia Commons with per-file attribution (0030). **Open:** credits page not built.

---

## 3. Recurring themes and recommended engineering guardrails

| Theme | Where it recurred | Guardrail |
|---|---|---|
| **Same fact stored in several places** | free-shipping threshold (marquee, constant, backend), shipping rates (constants vs settings 199/499 vs policy copy), site name (env vs DB), brand strings | One source in `/settings/public` or one server quote; frontend reads it, never mirrors. Add a "no duplicated business constants" review rule; CI grep for literals like `4999`, `79`. |
| **Client trusted for money** | client price (SEC-01), client `cartTotal` (coupons), client country claim, hard-coded INR | Server derives every monetary and market decision; tests that tamper with each client-supplied field. |
| **Preview vs charge divergence** | shipping display (PAY-05), coupon preview, combo pricing | One evaluator called by cart, preview and order (0035/0037 pattern). Contract test asserting equality for a matrix of carts. |
| **Legacy fashion/brand data leaking back** | `initDatabase`, seed, admin, metadata, JSON-LD | Single seed module, brand-string grep in CI, boot-on-empty-DB smoke test. |
| **Frontend/backend contract drift** | blog endpoint and shape, `/cms`, `orders/my` params | Shared route constants or generated client, e2e crawl of every public route, Joi coercion on all list endpoints. |
| **Proxy/host/IP assumptions in production** | XFF, `localhost:3000` URLs, `X-Forwarded-*`, http2 syntax | Treat the reverse proxy as part of the app: a production-parity local nginx (or Docker compose) and a post-deploy smoke script (`curl` foreign IP, check `Location`, `nginx -t`). |
| **Environment/hardware surprises on the VPS** | sharp/SSSE3, 10-min builds, swap, ENOTEMPTY | Deploy from CI-built artefacts; health check that encodes an image; run deploy in `tmux`; resize before traffic. |
| **Test hygiene** | data drift, orphan processes, `.next` mixing, autofill false alarms | Scripted setup/teardown that goes through the cancel flow; PID-based process management; fresh Chrome profile by default; invariant check after each QA session. |
| **Unverified client-side behaviour** | multiple "not browser verified" disclosures | Keep a CDP/Playwright smoke suite (home, PDP, cart, checkout with COD and cancel, admin login) run before each deploy; there is currently no automated test suite (backend CLAUDE §23). |
| **Truthful content debt** | fictional testimonials/artisans/counters, placeholder contact details in production | Content lint: fail deploy when seed content flagged `demo: true` is active in production; settings checklist for placeholders (`whatsapp_number == 919876543210`). |
| **In-memory/state assumptions** | rate limit in-process, 5-min country cache, geo cache | Prefer Redis when the deployment grows; log cache ages; document TTLs next to the config. |

## 4. Known open issues

From `docs/claude/technical-debt.md`, `tasks/TASKS.md` and the decisions above. IDs are stable references for other docs.

| ID | Issue | Source | Notes |
|---|---|---|---|
| OPN-01 | Real Razorpay/Cashfree credentials; non-INR online payment refused | TASKS blocker, 0027 | Blocks a completed online purchase; vendor decision for UAE/US/UK |
| OPN-02 | Admin status change to CANCELLED does not restore stock | 0035, 0037 | Only `POST /orders/:id/cancel` restores |
| OPN-03 | Shipping charges single source of truth (79/149/249 vs 199/499); constants say "keep in sync" | QA, 0029 | Also affects FAQ/policy copy |
| OPN-04 | No order confirmation email or GST invoice | 0035 | SMTP/Brevo keys are placeholders; lead-notification email empty in production |
| OPN-05 | Abandoned PENDING online orders keep coupon redemption (no expiry job) | 0035 | Also stock for online orders |
| OPN-06 | Variant prices are base-currency only | 0032, 0039 | Wrong for non-default markets |
| OPN-07 | No per-country tax model (`taxPercent` global, India-GST shaped); GST `taxAmount` on pre-discount subtotal | technical-debt, 0035 | Needs finance/legal input |
| OPN-08 | Search uses `LIKE '%..%'`; needs FULLTEXT at scale | technical-debt | Not urgent for 2-46 products |
| OPN-09 | In-memory rate limits and local-disk uploads assume one machine; leads rate limit too | technical-debt, 0034 | Redis / object storage when scaling out |
| OPN-10 | No CDN, no off-host backups, no monitoring, no staging; single-node SPOF | 0038, runbook, 0005 | Resize before real traffic |
| OPN-11 | Geo: crawler UA not reverse-DNS verified; MaxMind attribution and data refresh missing; `GEO_TRUST_PROXY` must be set and backend private | 0036, TASKS | Confirm production settings **(unverified)** |
| OPN-12 | Photo credits page for CC BY / CC BY-SA images; `Shixart1985` provenance; 3 of 46 products real photos | 0030 | Legal exposure and trust |
| OPN-13 | Fictional testimonials, artisans, blog posts, counters; placeholder WhatsApp/phone/email; empty Instagram | 0029, 0034, live settings | See gap tracker AWR-01, LOW-01 |
| OPN-14 | Newsletter form has no endpoint | 0030 | Dead form in footer/homepage |
| OPN-15 | Lead follow-ups: assignment UI, uncontacted reminders, consent withdrawal/retention, lead-to-order link, privacy policy wording | 0034 | |
| OPN-16 | Per-line discount allocation for partial returns; combo returns; variant-level stock; combo analytics events | 0035, 0037 | |
| OPN-17 | Admin Add/Edit Product still has Gender selector; `seedGenderDemo.ts` and `/admin/settings/gender` remain | QA, 0029 | |
| OPN-18 | Admin UI for country-scoped homepage/banner/CMS rows; product-form country pricing UI; funnel/country dashboard UI; admin homepage config forms | TASKS Phases 1/3/7, 0030 | |
| OPN-19 | Full translation (DE/FR/NL) undecided; payment providers per market undecided; multiple carriers not built (`DELHIVERY` enum only) | TASKS | |
| OPN-20 | Merge guest and signed-in recently-viewed; blog hreflang; `LocalBusiness` schema needs Store lat/lng migration | TASKS | Low priority |
| OPN-21 | CI/CD and automated tests absent; PM2 configs' legacy names replaced only at first deploy | TASKS Phase 5, 0038, backend CLAUDE §23-24 | |
| OPN-22 | 2 moderate `uuid` advisories through `exceljs` (unreachable) | 0008 | Accepted |
| OPN-23 | Country list cache in middleware 5 min; `/not-available` returns 200 | 0036 | Known limits |
| OPN-24 | Full competitor teardown and non-India competitor research not started | TASKS | |

## 2026-09-25 — Production product pages "Product Not Found" (found by the SEO audit)
- **Symptom:** `/in/product/<slug>` returned HTTP 200 with "Product Not Found" + noindex; sitemap had 0 product URLs. The API worked from outside.
- **Root cause:** Next SSR fetches the API through the public URL, so nginx saw the server's own IP (45.195.129.38, a datacentre in Mauritius per GeoIP) and forwarded it as the visitor IP; with `GEO_TRUST_PROXY=true` the backend's per-request market lock (decision 0036, `enforceRequestCountry`) returned 403 REGION_UNAVAILABLE, which the page rendered as "not found". Same family as the earlier middleware geo bug (0036 follow-ups).
- **Fix:** nginx `map $remote_addr $wv_xff` blanks X-Forwarded-For **and X-Real-IP** for the server's own IP (`docs/operations/server/nginx-site.conf`, `nginx-proxy.conf`). Verified: product page renders, US test IP still redirected to /not-available, IN IP allowed. The sitemap regenerates within its 1 h revalidate window.
- **Prevention:** post-deploy smoke test must fetch a product page and check for its title, not just HTTP 200; add `/in/product/<slug>` content assertion + sitemap product count to `deploy.sh` health step; consider a dedicated internal API URL for all SSR fetches (INTERNAL_API_URL) instead of the public one.
