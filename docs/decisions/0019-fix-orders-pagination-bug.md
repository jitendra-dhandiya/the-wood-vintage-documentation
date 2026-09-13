# 0019. Fix `GET /orders/my` pagination bug

Date: 2026-09-13

## Decision

Fixed a real, pre-existing bug found by the URL-restructuring agent while re-verifying the full
E2E flow (see `0018`, "A real, unrelated bug found along the way"): `GET /orders/my` threw a Prisma
validation error when called with no query parameters. `wood-vintage/backend` commit `68db808`.

## Root cause

`OrderService.getUserOrders(userId, page, limit)` and `OrderService.getAllOrders(page, limit, ...)`
both called `const { skip } = paginationParams(page, limit);` — destructuring only `skip` and
discarding the sanitized `page`/`limit` values `paginationParams()` computes. The Prisma
`findMany()` calls then used the raw, unsanitized `limit` **parameter** directly as `take`. The
controllers call these with `Number(req.query.limit)`, which is `NaN` when the client sends no
`limit` at all (not `undefined` — `Number(undefined)` is `NaN`, and JS default parameters only
apply on `undefined`, not `NaN`) — so `take: NaN` reached Prisma, which rejects it as an invalid
`take` value.

`paginationParams()` itself was never the problem — it safely defaults `NaN`/`undefined` inputs via
`|| default`. The bug was entirely in the callers discarding its sanitized output.

## Chosen approach

Destructure all three fields Prisma actually needs: `const { skip, page: currentPage, limit: take }
= paginationParams(page, limit)`, and use `take`/`currentPage` both in the Prisma query and in the
returned `{ page, limit }` metadata (previously that metadata echoed the raw, potentially-`NaN`
input back to the client too — a second, lower-severity instance of the same bug).

## Verification

- `npx tsc --noEmit` — clean.
- Booted the backend for real, minted a real JWT for the seeded admin user via `signAccessToken`'s
  actual secret (not a fabricated token), and called both affected endpoints live:
  - `GET /orders/my` with **no query params** (the exact failure case) → `200`, not the previous
    Prisma error.
  - `GET /orders/my?page=2&limit=5` → `200`, correct `meta.page`/`meta.limit` echoed back.
  - `GET /orders` (admin, `getAllOrders`, same bug pattern) with no query params → `200`.
- Confirmed the dev server process was cleanly stopped afterward (port 5000 free); noted unrelated
  `tsx`/`tsoa` processes on this shared machine belong to a different project, not this one.

## Consequences

- `tasks/TASKS.md`'s `GET /orders/my` item closes.
- The identical pattern in `getAllOrders` (admin order list) was fixed proactively even though only
  `getUserOrders` was reported — same root cause, same fix, verified separately.
- No other `paginationParams()` call sites in the codebase showed this discard pattern (only these
  two callers destructure `{ skip }` alone); worth a quick grep if a similar report surfaces
  elsewhere.
