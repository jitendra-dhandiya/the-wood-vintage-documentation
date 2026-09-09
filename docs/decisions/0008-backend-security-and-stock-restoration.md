# 0008. Backend npm vulnerabilities fixed (17→2), stock-restoration bug fixed

Date: 2026-09-09

## Decision

Applied fixes for the backend's 17 npm vulnerabilities, reducing to 2 (both moderate, confirmed
unreachable). Fixed the critical stock-not-restored-on-cancel bug (`CLAUDE.md` §25 #3) and wired up
the previously-unused `InventoryLog` model for both order creation and cancellation.

## Why

Both were delegated to a background agent alongside the frontend security work (see `0007`), with
the same instruction: only keep a fix if verifiably still working, revert and report honestly
otherwise. The stock-restoration bug was already flagged critical in the inherited `CLAUDE.md`;
fixing it now (rather than deferring to "later") follows the same reasoning as the pricing fix in
`0003` — it's a correctness bug independent of the transformation itself, no reason to ship it
broken longer than necessary.

## What was fixed — npm vulnerabilities (17 → 2)

- `npm audit fix` (non-breaking): `form-data`, `joi`, `js-yaml`, `morgan`.
- Removed `csurf` — confirmed unused (`grep -rn` came up empty in `src/`, matching
  `CLAUDE.md` §25 #17's own note that it's "declared but unused") — this also cleared a `cookie`
  CVE that came in through it as a dependency.
- Added a `package.json` `overrides` entry pinning `qs` to `^6.16.0` (`express@4.22.2`'s own
  dependency range excludes the already-patched release).
- Bumped and individually verified (build + boot + `curl /health` + `curl /api/v1/products` after
  each): `uuid` 9→14 (only use: filename generation in `upload.ts`, API unchanged),
  `google-auth-library` 9→10 (only use: `OAuth2Client.verifyIdToken`, API unchanged — this also
  pulled in a non-vulnerable `gaxios` transitively), `sharp` 0.33→0.35 (runtime API unchanged,
  verified with a standalone resize/webp/avif smoke test; one import needed updating — `sharp.Sharp`
  → the new named `Sharp` export — in `imagePipeline.ts`), `nodemailer` 6→10 (only use:
  `createTransport`/`sendMail`, API unchanged).
- **Deliberately not fixed**: `uuid <11.1.1` via `exceljs`'s own pinned `uuid@8.3.0`. `exceljs`
  4.4.0 is the latest release; npm's only suggested fix is downgrading to 3.4.0, a real regression.
  Confirmed the vulnerable code path is unreachable — `exceljs` only calls `uuid.v4()` internally,
  never the `v3`/`v5`/`v6` + `buf` combination the advisory (GHSA-w5hq-g745-h8pq) requires. Correct
  call: a real regression to fix an unreachable vulnerability would be a bad trade.
- Also noted: `google-auth-library@11` requires Node ≥22; this environment runs Node 20.20.2, so it
  stayed on the 10.x line rather than force a Node upgrade as a side effect of a security patch.

## What was fixed — stock restoration on cancel

`cancelOrder()` now runs in a transaction: for every order line item, restores
`Product.stockQuantity` (+quantity) and reverses `totalSold` (-quantity, clamped at 0 defensively),
and writes an `InventoryLog` row (`type: 'RETURN'`). `createOrder()` now also writes an
`InventoryLog` row per line (`type: 'SALE'`) — the model existed in the schema but, per `CLAUDE.md`
§25 #21, was "written nowhere despite `createOrder` changing stock." Handles the edge case where a
product was hard-deleted since the order was placed (skips restoration for that line rather than
erroring the whole cancellation).

## Verification

Independently re-verified after the fact (this session, not just trusting the agent's report):
`git log` confirms both real commits (`044b79d`, `bf811c8`); re-ran `npm audit` myself — 2
vulnerabilities remain, matching the claim exactly; re-ran `npm run build` — clean; booted the
backend myself and confirmed `/health` and `/api/v1/products` both work; confirmed the dev DB has
zero leftover test rows (`inventory_logs`, `orders` both empty; the only user row is the real
`SUPER_ADMIN` from `.env`, not test pollution).

The agent's own verification (trusted, not independently re-run in full, but the numbers are
specific enough to be credible): created a test order for 3 units (stock 50→47, totalSold 0→3),
cancelled it (stock back to 50, totalSold back to 0), confirmed two `InventoryLog` rows (`SALE`
50→47, `RETURN` 47→50) referencing the real order number.

## Consequences

- `docs/claude/technical-debt.md`'s backend vulnerability entry is now mostly closed — 2 low-risk,
  confirmed-unreachable vulnerabilities remain, tracked but not urgent.
- `InventoryLog` now has real data going forward — useful for the future admin dashboard inventory
  views MASTER-PROMPT §27 calls for, and no longer "written nowhere" as the inherited doc noted.
- `backend/CLAUDE.md` §25 #3's stock-leak issue and #21's dead `InventoryLog` note are both now
  stale for `wood-vintage` (not backported to `unique-dressup`) — should be marked fixed there too.
