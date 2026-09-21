# Quote and lead capture on the product page (spec)

Date: 2026-09-21. Decision record: `docs/decisions/0034-quote-lead-capture.md`.

## 1. Why

Paid traffic (Instagram, Facebook, Google SEM) lands on product pages. A high-ticket, customisable
piece is rarely bought on impulse; the buyer wants to know "will it fit my room, can you change the
size or finish, what is the real price". The page therefore has to capture a **lead** and start a
consultation, with online checkout kept as the secondary path.

## 2. Psychology levers and how each is used (truthfully)

| Lever | Application | Guardrail |
|---|---|---|
| Reciprocity | Give first: "Free design guidance from our team", no obligation, no payment. | Must actually be delivered. |
| Commitment / consistency | Step 1 is one easy question (what are you furnishing?) with tap chips. A person who has answered once is far more likely to finish step 2. | Step 1 has no personal data. |
| Personalisation | "Tell us your room and style and we will recommend the best customisable piece." Their answers are echoed back in the success state and the WhatsApp message. | Answers are used, not discarded. |
| Authority | "Our design team" replies, "handcrafted by artisans". | No invented credentials or awards. |
| Loss aversion / scarcity | Only real signals already on the page (real variant stock "Only N left", real made-to-order lead time). Nothing new added. | No fake urgency, countdowns, viewer counters or stock numbers. |
| Social proof | Only real data (real review count/rating if present). Otherwise none shown. | No fake testimonials. |
| Friction reduction | Two short steps, 3 required fields in step 2, progress "Step 1 of 2", mobile full-screen sheet, numeric keypad, country-aware phone check, WhatsApp as a zero-form alternative. | Optional fields never block. |
| Trust | Response promise from a setting (`lead_response_promise`, default "within 1 business day"), privacy line, no spam promise. | Owner must keep the promise; it is configurable. |

## 3. CTA hierarchy on the product page

1. **Get Best Quote & Price** primary: full width, filled walnut with copper accent, animated (see 6).
2. **Chat on WhatsApp** strong secondary: filled WhatsApp-green outline button beside/below.
3. **Add to Bag** stays but demoted to an outlined button (online checkout still exists).
4. Wishlist and share remain small icon buttons.

CTA copy options considered: "Request a Quote", "Get a Free Design Consultation", "Check Availability",
"Get Best Quote & Price". **Chosen: "Get Best Quote & Price"** (owner's wording; names the benefit, price
transparency, and is low-commitment). Sub-line under the button: "Free design guidance. Reply {promise}."

## 4. Form

Modal on desktop (centered dialog), full-screen sheet on mobile. Product thumbnail and name at the top.

**Step 1 (no personal data)** headline "Let's find the right piece for you". Sub: "Two quick questions, about a minute."
- Which room? chips: Living room, Bedroom, Dining, Office, Outdoor / other (single select, optional but encouraged).
- Preferred style? chips: Traditional, Modern, Rustic, Not sure yet.
- Size or customisation needs (short textarea, optional, 500 chars): placeholder "Any dimensions, finish or changes you have in mind?"
- Button "Continue". A "Skip, just get my quote" link is not offered; all step-1 fields are optional, so Continue is always enabled.

**Step 2** headline "Where should we send your quote?"
- Name (required), Mobile number with country selector (required, validated for the chosen country, default +91), Email (required), Preferred contact (WhatsApp / Call / Email, default WhatsApp), consent checkbox (required, unchecked by default): "I agree to be contacted about this enquiry. We never share your details."
- Hidden honeypot field `website` (off-screen, `tabindex=-1`, `autocomplete=off`).
- Button "Send My Request". Back link "Edit answers".

**Success:** "Thank you, {firstName}. Your request is with our design team." Next steps: 1) "We review your room and needs", 2) "You hear from us {promise} on {preferred channel}", 3) "We share a quote with options". Echo of their answers, secondary buttons "Chat on WhatsApp now" and "Keep browsing".

**Errors:** inline per field, human wording ("Enter a 10-digit mobile number starting with 6-9", "Enter a valid email", "Please tick to let us contact you"); network/server failure keeps the form and data, shows "We could not send that just now. Please try again or chat with us on WhatsApp" with a WhatsApp link. Rate limited: "You have sent several requests. Please chat with us on WhatsApp." Duplicate (same phone, same product, within 10 minutes) returns success without a second lead.

## 5. Mobile sticky bar

Ad traffic is mostly mobile. Below `md` a fixed bar appears with **Get Best Quote & Price** (flex 1) and a **WhatsApp** icon button. It slides in only after the in-page CTA has scrolled out of view (IntersectionObserver) so it never duplicates a visible CTA, and hides while the modal is open. It sits directly above the existing 58px `MobileBottomNav` (bottom offset = 58px + safe-area inset) so neither hides the other; z-index just under the nav's. Page bottom padding is added so the footer is never covered.

## 6. CTA animation

Attention without nagging: a soft copper **pulse ring** (pseudo-element, `transform: scale` and `opacity` only) plus a slow **shimmer sweep** (a translated gradient inside an `overflow:hidden` button), 4 cycles of about 2.4s starting 1.5s after load, then stops. Stops immediately on hover or focus and never restarts. `prefers-reduced-motion: reduce` disables both (static button). Transform/opacity only, no layout shift. Uses the CSS-only approach of decision 0033 (no new dependency).

## 7. Analytics (extends decisions 0025/0026)

New allow-listed events via `trackEvent`: `QUOTE_CTA_VIEW` (primary CTA first enters the viewport, once), `QUOTE_CTA_CLICK` (either CTA, main or sticky), `QUOTE_STEP1_DONE`, `LEAD_SUBMITTED` (only after server success), `WHATSAPP_CLICK`. All carry the same `sessionId`/`productId`. The `Lead` row copies `utmSource/utmMedium/utmCampaign` from the first-touch `wv_attribution` cookie plus `sessionId`, so a lead joins back to its campaign and the funnel. `GET /analytics/leads-summary` groups leads by source, UTM and day; the funnel report is unchanged (lead events are not orders).

## 8. Spam and data protection

Honeypot field (filled: respond 200, store nothing), per-IP rate limit (5 per 15 minutes, in-memory, also active in dev), Joi server validation, country-aware phone validation, length caps, plain-text only (rendered escaped), dedupe of same phone + product within 10 minutes. Consent boolean and timestamp are stored on the lead; data is used only to answer the enquiry. Admin export and status changes are staff-only. Retention and deletion on request are an owner process (see decision record gaps). No third-party trackers are added.

## 9. Settings the owner must configure

`whatsapp_number` (international digits, placeholder `919876543210`), `whatsapp_default_message`, `lead_response_promise`, `whatsapp_float_sitewide` (default false), `lead_notification_email` (falls back to `site_email`). Configured in Admin > Settings, group "leads".

## 10. Metrics to watch

CTA view to click rate, click to step-1 completion, step-1 to submit rate, WhatsApp clicks vs form submits, leads per campaign/UTM, time-to-first-contact, lead-to-quoted and lead-to-won by source, and the bounce rate change on product pages after launch. Add-to-bag rate is monitored to confirm the demotion does not hurt direct sales.
