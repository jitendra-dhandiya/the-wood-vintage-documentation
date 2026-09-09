# 0005. Media/CDN architecture: reuse existing pipeline, defer CDN fronting

Date: 2026-09-09

## Decision

Reuse the inherited image-derivative pipeline (`backend/src/utils/imagePipeline.ts`, `/img` route,
`lib/imageLoader.ts` on the frontend) as-is for handicraft product photography — no changes needed
to satisfy MASTER-PROMPT §19's requirements (CDN-readiness, responsive images, AVIF/WebP, lazy
loading, blur placeholders, compression, caching). Defer actually fronting `/img` and `/uploads`
with a real CDN (Cloudflare or equivalent) to Phase 5 (Performance) / Phase 8 (Scale), not Phase 1.

## Why

The discovery report (§10, §14, §22) already established this pipeline is sophisticated and
directly reusable: AVIF-primary/WebP-fallback, a responsive width ladder, blur-up placeholders,
resolution-floor enforcement on upload, per-surface admin cropping, a background re-encode queue,
and content-addressed cache keys (mtime+size). None of that is fashion-specific — it operates on
"an uploaded image," not on garment photography specifically. Nothing about the handicraft/furniture
domain requires changing it.

Actually fronting it with a CDN is valuable once there's real cross-region traffic (multiple
countries live, meaningful request volume) — before that, it adds infra/DNS complexity (a real cost
for a small team, per the discovery report's Phase 5 CDN note) without a corresponding benefit,
since the pipeline already serves cached, compressed, correctly-sized derivatives directly.

## Alternatives considered

- **Build a new media pipeline for handicraft photography specifically** (e.g., assuming 360°
  product views, video needs different handling). Rejected — MASTER-PROMPT §15 lists 360° media as
  a product-architecture field, not a media-*pipeline* requirement; the existing pipeline already
  handles video (reel uploads, `MAX_VIDEO_SIZE`) and can serve 360°-sequence frames as ordinary
  images once that content model exists (Phase 2 work, not a pipeline change).
- **Front the pipeline with a CDN now, in Phase 1.** Rejected — no traffic yet to justify it;
  premature infra investment ahead of the country/pricing/product foundation actually shipping.
  Revisit explicitly at Phase 5, not silently skipped — tracked in `tasks/TASKS.md`.

## Chosen approach

No code changes in Phase 1. `docs/claude/technical-debt.md` and `tasks/TASKS.md` Phase 5 carry the
"add CDN in front of `/img`/`/uploads`" item forward so it isn't forgotten once it becomes relevant.

## Consequences

- Closes out the "Media/CDN architecture" line item in `tasks/TASKS.md` Phase 1 as "decided: reuse,
  no changes needed now" rather than leaving it looking like unstarted work.
- If international traffic materializes faster than expected (e.g., a specific market's launch
  drives real volume before Phase 5 is reached), revisit this decision explicitly rather than
  reactively bolting on a CDN under pressure — the pipeline's cache-key design (content-addressed,
  not path-addressed) means adding a CDN later is a fronting change, not a pipeline rewrite, so
  there's no real cost to waiting.
