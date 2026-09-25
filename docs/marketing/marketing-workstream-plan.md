# Marketing workstream plan — "first 100 orders"

Date: 2026-09-25. Development is ON HOLD; this is a research/strategy workstream. Everything lives in this
repo (`documentation/`) as markdown — the local repo is the single source of truth (no hosted docs/artifacts).

## Business facts (from the owner)
- Manufacturing in-house with a carpenter team in **Jodhpur** (Rajasthan, India) — all types of wooden
  furniture / home décor; **customisable** products made to the customer's requirements.
- Cost position: can sell ~**30% below the current market price** (market price not yet measured — to be
  established by competitor research).
- Channels: Instagram + Facebook, freshly created (0 posts / 0 reels). Website live at thewoodvintage.com
  (India market enabled; other markets switchable; US payments/tax/shipping not built).
- **Goal: the first 100 orders.** Need: country choice, best-selling products per country, competitor &
  price analysis, USP, positioning, social plan, combos + coupon strategy, budget, real target audience, SEO.
- Also wanted: a tracker of website gaps vs customer-psychology, and a log of bugs/challenges met so far.

## Evidence rules (all agents)
Cite every number with URL + date; mark each figure VERIFIED / ESTIMATE / ASSUMPTION; never invent data.
Say what could not be found. Prefer recent (2024–2026) sources. Flag legal/tariff/compliance facts that change.

## Phases and deliverables
| Phase | Work | Output (under `docs/`) |
|---|---|---|
| 1 | Where is demand? Country selection with feasibility (tariffs, freight, compliance, payments, competition) | `countries/market-selection.md` |
| 1 | Website gaps vs customer psychology + bugs/challenges log | `ux/customer-psychology-gap-tracker.md`, `engineering/challenges-and-bugs-log.md` |
| 2 | Best-selling products, prices, competitors, price ladder, USP, white space (per shortlisted market) | `competitor-research/<market>-*.md`, `marketing/positioning-and-usp.md` |
| 2 | Brand presence + social media: content pillars, monthly reels, daily posts, growth plan | `marketing/social-media-playbook.md` |
| 2 | Customisation offer + funnel, combos, coupon strategy, audience, budget, channel mix, 100-order plan | `marketing/first-100-orders-plan.md` |
| 2 | SEO plan for the chosen market(s) | `seo/<market>-seo-plan.md` |
| 3 | Synthesis: master 30/60/90 execution plan, KPIs, tracking sheet spec | `marketing/master-growth-plan.md`, `tasks/TASKS.md` |

Phase 2 depends on Phase 1's shortlist. Website changes discovered along the way go to the psychology tracker,
not into code (development is on hold).
