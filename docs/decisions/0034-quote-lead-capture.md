# 0034. Quote and lead capture on the product page

Date: 2026-09-21

## Decision
Turn the product page into a lead-capture surface for paid traffic. "Get Best Quote & Price" is the
primary CTA, "Chat on WhatsApp" the strong secondary, "Add to Bag" stays but is outlined (online
checkout still exists). Full conversion-psychology rationale, copy and animation spec:
`docs/architecture/quote-lead-capture-spec.md`.

## Why
Customisable high-ticket furniture converts through consultation, not impulse add-to-bag, and the
owner runs Instagram, Facebook and Google SEM traffic to product pages (mostly mobile).

## What was built
- **Backend:** `Lead` model (+ `LeadStatus`, `LeadSource` enums, migration `add_lead`). Module `leads`:
  public `POST /leads` (Joi, honeypot field `website` answered with a normal 200 before validation,
  per-IP limit 5 per 15 min active in all environments, country-aware phone validation to E.164 via
  `utils/phone.ts`, same phone + product dedupe within 10 min, consent stored with timestamp, country
  resolved server-side); admin/sub-admin `GET /leads` (status/source/date/search + pagination),
  `GET /leads/:id`, `PATCH /leads/:id` (status/notes/assignedTo), `GET /leads/export` (CSV, formula-injection
  safe). Admin email on new lead via existing mailer, fire-and-forget, never fails the request, skipped and
  logged when mail is not configured. `GET /analytics/leads-summary` (by source, UTM, status, day).
  Five new event names allow-listed in `metrics.controller`.
- **Settings** (group `leads`, public via `/settings/public`): `whatsapp_number` (PLACEHOLDER 919876543210),
  `whatsapp_default_message`, `lead_response_promise`, `lead_notification_email`, `whatsapp_float_sitewide`
  (default false). New "Leads" tab in Admin > Settings.
- **Frontend:** `components/product/QuoteLead.tsx` (animated CTA, WhatsApp button, mobile sticky bar, 2-step
  dialog that is a full-screen slide-up sheet on mobile), CTA hierarchy in `ProductDetailClient`, CSS-only
  pulse ring + shimmer (4 cycles, stops on hover/focus/touch, none under reduced motion), `lib/phone.ts`,
  `lib/leadSettings.ts` (settings hook + wa.me link builder including product, link, room/style/needs),
  optional `WhatsAppFloat`, admin Leads page (filters, status chips, detail drawer with WhatsApp/call/email
  actions and notes, CSV export, skeleton and empty state), sidebar entry, dashboard "Leads (30 days)" card.
- **Attribution:** lead carries `utm*` from the `wv_attribution` cookie and `sessionId` (decisions 0025/0026).
  Events: `QUOTE_CTA_VIEW`, `QUOTE_CTA_CLICK`, `QUOTE_STEP1_DONE`, `LEAD_SUBMITTED`, `WHATSAPP_CLICK`.

## Key calls
- Sticky mobile bar sits directly above the existing 58px `MobileBottomNav` (stacked, both stay usable) and is
  portaled to `<body>`: the page transition wrapper leaves a transformed ancestor that made `position: fixed`
  resolve against the whole page (found in testing).
- Phone rules are a small in-house table (IN, AE, US, CA, GB, AU, DE, FR, NL, generic fallback), not
  libphonenumber, to avoid a dependency for a handful of markets. Frontend and backend tables must be kept in sync.
- No fake urgency, counters or testimonials. The only scarcity shown is the pre-existing real variant stock line.
- The `Lead` has no foreign key to `Product` (snapshot name instead), like `AnalyticsEvent`, so deleting a
  product never touches leads.

## Verification
tsc clean both repos, `npm run build` clean. Real HTTP: valid lead (E.164 normalised, product name snapshot),
dedupe, bad phone/email/no consent rejected, honeypot dropped silently (nothing stored), 6th request from one IP
429, UTM+session captured from the cookie in a real browser submit, admin list/filter/search/patch/CSV/summary,
anonymous 401 and customer 403. Headless Chrome (CDP) at 1440 and 390: CTA hierarchy, ring opacity sampled
0..0.56 then stops, step 1, step 2, inline errors, success, sticky bar above bottom nav, admin leads
(loaded/empty/drawer), settings tab, dashboard card, reduced motion (animation-name none), no console errors.
All test leads and events removed (0 leads, 46 products).

## Gaps and follow-ups
- Owner must set the real WhatsApp number, notification email and response promise (Admin > Settings > Leads).
  Mail is not configured in dev (Brevo/SMTP placeholders), so the notification email is untested end to end.
- No consent-withdrawal or retention job yet; deletion on request is manual. Privacy policy copy should mention leads.
- Rate limit is in-memory (per process); use a shared store if the API scales horizontally.
- No lead-to-order linking, assignment UI (field exists), or reminder for uncontacted leads.
- Dashboard leads card is a lone card in its own row; funnel report UI still shows only the original 5 stages.
