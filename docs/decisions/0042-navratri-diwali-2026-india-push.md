# 0042. Navratri + Diwali 2026 India push (documentation only)

Date: 2026-10-06

## Decision
Adopt `docs/marketing/diwali-2026/navratri-diwali-marketing-strategy.md` as a **time-boxed, India-domestic
festive push for Navratri (11 Oct 2026) and Diwali (8 Nov 2026)**, running **alongside** the US-first export
plan (decision 0041) and reactivating the India D2C motion that 0041's banner marked superseded, for this
window only. **This decision does not replace 0040 or 0041** — both tracks stay in the repo; this is a third,
parallel, short-lived track that reuses 0040's India method and data wholesale.

1. **Scope and timing:** India domestic only, INR prices on `thewoodvintage.com/in` (already live, decisions
   0031/0036). Navratri (11-19 Oct) is explicitly a **content/community-building + early-bird phase**, not a
   sales push — 5 days' notice is too short to build new stock. The real commercial push is **22 Oct - 8
   Nov**, gated on fixing Gate A items that were already open in decision 0040 and remain open today (real
   WhatsApp/phone/Instagram, real photos, honest policies, fake content removed).
2. **Combos (decision 0037 engine):** 9 Diwali combos, 7 newly designed (D1 Pooja Thali Set, D2 Housewarming
   Diwali Gift Box, D3 Corporate Gifting Crate, D4 Mithai & Dry Fruit Tray Set, D5 Diya & Torans Combo —
   flagged stretch/uncosted, D6 Festive Home Refresh, D7 Return Gift Pack) plus 2 carried over unchanged from
   the existing first-100 combo set (D8 = Mandir Corner, D9 = Cook's Gift Set), re-launched with festive
   creative. Margins computed with the same formula as `unit-economics-model.md` and the same combo costing
   method as `first-100/04-combo-strategy.md` (validated by reproducing that file's published C3 numbers
   exactly before computing new ones).
3. **Coupons (decision 0035 engine):** 8 codes for the festive window — NAVRATRI26 (early-bird), DHAN26
   ("Dhanteras collection"), DIWALI-FLASH (real-stock-count urgency only, no fake scarcity), a referral
   give/get pair re-badged for gifting, CORP-\<FIRM\> (the genuine B2B/corporate-gifting angle the owner
   asked for), NUDGE-DIW (abandoned-cart), and FIRST100 carried over unchanged. **WELCOME10 is confirmed
   retired** (0040/0041 already flagged it breaks the floor on several of this push's own hero SKUs — mirror,
   mandir, console); it is not reintroduced for Diwali.
4. **Budget:** three scenarios for the 33-day window — Lean ~INR 39,000, **Base ~INR 1.3 lakh (recommended,
   staged: Lean-rate spend through Navratri, full Base from 22 Oct only if Gate A has closed)**, Growth
   ~INR 3.16 lakh (not recommended — ready stock is capped at ~45 units and workshop custom capacity for
   this volume was never confirmed). Expected orders by 8 Nov: Lean 15-25, Base 25-45, Growth 40-65
   theoretical/~35-45 realistically achievable.
5. **Operational precondition:** none of this should spend a rupee until Gate A closes — specifically the
   real WhatsApp number/phone/Instagram, which the latest read of
   `docs/ux/customer-psychology-gap-tracker.md` confirms is still a placeholder as of this date, 11 days
   after decision 0040 first flagged it.

## Why
- The owner's direction today (2026-10-06) is to focus on India for this specific festive window while the
  US-first export plan (0041) continues in parallel — both are real, neither cancels the other.
- Decision 0040's India method, cost model and 16-SKU catalogue are still the only costed India data this
  project has; reusing them (rather than re-deriving new numbers) keeps the two documents arithmetically
  consistent and avoids inventing a second, possibly contradictory, set of India assumptions.
- Diwali (33 days out) is commercially real but logistically tight: made-to-order lead times (12-30 working
  days + transit) leave almost no safety margin from a 6 Oct start, so this plan deliberately treats Diwali
  as a **ready-stock and gifting** festival, the same honest conclusion decision 0040 already reached for
  its own Diwali handling — this decision does not relax that conclusion, it operationalises it with
  Diwali-specific combos, coupons and a compressed timeline.
- The order estimates in this plan are **more optimistic than decision 0040's own week-6 roadmap figure**
  (~10 cumulative orders by 2 Nov) because this plan assumes Gate A closes about 4 days earlier and that
  corporate/bulk-gifting and referral channels are worked from day one of the push instead of from week 8+.
  That assumption is explicit and reversible: if Gate A slips past 20 Oct, the plan says to fall back to
  0040's original, more conservative trajectory rather than spend Base-scenario money against an unmet
  precondition.

## Alternatives considered
- **Do nothing for Navratri/Diwali 2026, wait for the US container and Gate B/C work instead.** Rejected by
  the owner's explicit direction today; also leaves a real, if short, India commercial window and a near-
  guaranteed gifting occasion unaddressed for no cost saving, since the combos/coupons here are config-only
  (no dev, no code change) and the Navratri phase costs almost nothing.
- **Treat Diwali as a made-to-order occasion and advertise custom lead times.** Rejected: the arithmetic in
  section 2 of the new timeline shows made-to-order décor lead times (12-18 working days + transit) leave no
  safety margin from a 6 Oct start, and furniture lead times (21-30 days) cannot meet Diwali at all — the
  same conclusion 0040 already reached. Promising otherwise would break the "a delivery date we keep" USP
  this whole project is built on (`positioning-and-usp.md`).
- **Reuse WELCOME10 as the festive welcome code for extra reach.** Rejected: it already breaks the floor on
  several of this push's own hero SKUs (mirror, mandir, console) per 0040/0041; FIRST100 (5%, already floor-
  safe) is kept instead.
- **Build the 7 new combos from genuinely new Diwali-only SKUs.** Partially rejected for this cycle: the
  concurrent `50-diwali-products.md` list was not yet available when this was written, so 6 of the 7 new
  combos (D1-D4, D6, D7) are built entirely from the existing 16-SKU catalogue (already costed, already
  photographed-in-progress); only D5 (Diya & Torans) proposes genuinely new SKUs, and it is explicitly
  flagged stretch/do-not-configure-until-costed rather than launched on invented numbers.

## Consequences
- No code change, no schema change, no deployment change. Combos and coupons are **admin config only**
  (decisions 0035/0037 already built the engines); the only new work is: configure 9 combos + 8 coupons,
  fix Gate A (same open items as 0040, not new), take real photos of the ready-stock SKUs, and run the
  campaign.
- The 9 Diwali combos and 8 coupons sit alongside, and do not deactivate, the existing first-100 combos/
  coupons — D8 and D9 are literally the same combo rows as the existing C2/C3, re-launched with festive
  creative, not duplicated in the database.
- If the owner does not confirm the P0 rows in the new plan's owner-input-sheet section (budget, cash,
  current ready-stock status, WELCOME10 retirement) by roughly 12 Oct, the Navratri window is lost to
  inaction and the push effectively starts from the Dussehra/22-Oct point instead, which the plan's own
  funnel math (section 6) shows meaningfully lowers the expected order count.
- **Reconciliation finding (confirmed, not hypothetical):** `docs/marketing/diwali-2026/50-diwali-products.md`
  landed concurrently and checked the real seeded catalogue (`backend/prisma/seed-data/catalogue.ts`)
  directly. It confirms **no mandir/temple product exists in the real catalogue at all** — so neither this
  plan's D8 Mandir Corner nor the original first-100 plan's C2 Mandir Corner can actually be configured in
  admin today — and that several other combo items (mirror, jaali panel, serving tray) have real-catalogue
  prices materially higher than the planning-catalogue placeholders the margin tables in section 3 of the
  strategy doc use. The strategy doc's section 3 header now carries the full price-gap table and an explicit
  instruction: swap in real slugs and real workshop costs before configuring any combo in admin. This is
  tracked as a P0 task in `tasks/TASKS.md`, not deferred.

## Date
2026-10-06
