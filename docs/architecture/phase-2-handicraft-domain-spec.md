# Phase 2 — Handicraft Domain: Implementation Spec

Per MASTER-PROMPT §43 (No Blind Coding), written before implementing. Covers MASTER-PROMPT §15–16
and §33: handicraft-specific product attributes and artisan/craft storytelling.

## Problem

The current `Product` model is fashion-shaped: `fabric`, `careInstructions`, `sizeChart`, a generic
`weight`, and `gender` — nothing for material taxonomy, style, room, physical dimensions, assembly,
customization, made-to-order lead time, or artisan/craftsmanship storytelling (MASTER-PROMPT §33's
"who made it, how, why is it special" questions have no field to hold the answer in today).

## Current architecture (reuse, don't duplicate)

Already exists and is directly reusable, not being replaced:
- `ProductVariant.material` — free-text, already lets a specific SKU/variant record its material
  (e.g. two otherwise-identical listings differing only in wood type). **Untouched by this spec.**
- `ProductTag` — free-text, admin-addable without code changes. Could be used for loose,
  unstructured labels, but MASTER-PROMPT §16's explicit lists (11 materials, 11 styles, 18 product
  types) plus the "Shop By Material"/"Shop By Room" homepage sections (§12) and programmatic SEO
  pages "furniture by material"/"by room" (§5) need a **real taxonomy**, not free tags — filtering,
  dedicated landing pages, and consistent facets all need a stable, admin-manageable list, the same
  reason `Category` is a model and not just a tag.
- `Category` model is the closest existing precedent for shape: id, name, slug, description, image,
  sortOrder, isActive. New taxonomy models below copy this shape rather than inventing a new one.

## Proposed solution

Three new lightweight taxonomy models (`Material`, `Style`, `Room`) shaped like `Category`, each
admin-CRUDable with no code change needed to add a new value (satisfies §16's explicit requirement)
— plus new nullable fields/relations on `Product` for dimensions, assembly, customization,
manufacturing time, and artisan storytelling. Additive only — no existing `Product` field is
renamed, removed, or repurposed.

## Data model

```prisma
model Material {
  id          String    @id @default(uuid())
  name        String
  slug        String    @unique
  description String?   @db.Text
  image       String?
  isActive    Boolean   @default(true)
  sortOrder   Int       @default(0)
  createdAt   DateTime  @default(now())
  updatedAt   DateTime  @updatedAt
  products    Product[]

  @@index([slug])
  @@map("materials")
}

model Style {
  id          String    @id @default(uuid())
  name        String
  slug        String    @unique
  description String?   @db.Text
  image       String?
  isActive    Boolean   @default(true)
  sortOrder   Int       @default(0)
  createdAt   DateTime  @default(now())
  updatedAt   DateTime  @updatedAt
  products    Product[]

  @@index([slug])
  @@map("styles")
}

model Room {
  id          String    @id @default(uuid())
  name        String
  slug        String    @unique
  description String?   @db.Text
  image       String?
  isActive    Boolean   @default(true)
  sortOrder   Int       @default(0)
  createdAt   DateTime  @default(now())
  updatedAt   DateTime  @updatedAt
  products    Product[]

  @@index([slug])
  @@map("rooms")
}

model Artisan {
  id       String    @id @default(uuid())
  name     String
  bio      String?   @db.Text
  photo    String?
  region   String?
  isActive Boolean   @default(true)
  products Product[]

  @@map("artisans")
}
```

On `Product`, additive nullable fields/relations:

```prisma
materialId            String?
material              Material? @relation(fields: [materialId], references: [id])
styleId               String?
style                 Style?    @relation(fields: [styleId], references: [id])
roomId                String?
room                  Room?     @relation(fields: [roomId], references: [id])
artisanId             String?
artisan               Artisan?  @relation(fields: [artisanId], references: [id])

lengthCm              Decimal?  @db.Decimal(8, 2)
widthCm               Decimal?  @db.Decimal(8, 2)
heightCm              Decimal?  @db.Decimal(8, 2)
finish                String?
assemblyRequired      Boolean   @default(false)
assemblyInstructions  String?   @db.Text

isCustomizable        Boolean   @default(false)
customizationNotes    String?   @db.Text

manufacturingTimeDays Int?

craftStory            String?   @db.LongText
```

**Single-select, not many-to-many, for Material/Style/Room.** MASTER-PROMPT §16's own material list
already includes combination values ("Wood + Metal") as a single discrete option — the list is
designed to be picked from, not composed. Style and Room could arguably be multi-value (a piece
could suit multiple rooms or blend styles), but starting single-select matches `Category`'s existing
pattern, keeps filtering/faceting simple, and can be widened to many-to-many later (additive schema
change, no data loss) if real catalog needs it — not assumed necessary from the spec alone.

**`Artisan` is a separate reusable entity, not a `Product` field**, because MASTER-PROMPT §33 asks
"who made it" as a repeatable fact — the same artisan/workshop plausibly makes many products, and a
free-text field per product would duplicate their bio on every listing and make it unmaintainable to
update. `craftStory` stays a `Product` field because it's product-specific narrative (how *this*
piece is made), not the artisan's own bio.

## API changes

- New CRUD modules mirroring existing simple-taxonomy patterns (look at `categories` or
  `collections` module structure): `GET /materials`, `GET /materials/:slug` (public);
  `GET/POST/PUT/DELETE /materials` admin-scoped (same for `styles`, `rooms`). `artisans`: same
  shape, admin-CRUD plus a public `GET /artisans/:id` for a future artisan bio page.
- `GET /products` gains `?materialSlug=&styleSlug=&roomSlug=` filters, alongside existing filters.
- `POST /products` / `PUT /products/:id` accept the new fields (materialId, styleId, roomId,
  artisanId, dimensions, finish, assembly*, isCustomizable, customizationNotes,
  manufacturingTimeDays, craftStory) — additive to the existing product form payload.
- Product detail response includes the new relations (material/style/room/artisan objects, not
  just ids) so the storefront can render them without extra round-trips — same pattern
  `category`/`images` already use on product responses.

## Admin changes

- Three new simple list-management screens (Materials, Styles, Rooms) — same shape as the existing
  Categories admin screen (name, slug, image, active toggle, reorder). Low effort: this is the
  third and fourth time this exact CRUD shape has been built in this codebase (Category, Collection,
  now Material/Style/Room) — a template, not new design work.
- Artisan admin screen: simple list + edit (name, bio, photo, region).
- Product edit form gains a new "Craft & Dimensions" section: material/style/room selectors
  (dropdowns from the new taxonomies), artisan selector, dimension inputs, finish, assembly
  fields, customization toggle + notes, manufacturing time, craft story textarea.

## SEO impact

Unlocks (not implemented in this pass) the programmatic pages MASTER-PROMPT §5 calls for —
"furniture by material," "furniture by room" — once real product data exists to populate them.
Building those pages now, before real products carry these attributes, would produce empty/thin
pages, which §5 explicitly warns against ("avoid generating low-quality SEO spam pages"). Tracked
as Phase 6 work, correctly sequenced after this.

## Performance impact

Negligible — three small lookup tables, a handful of nullable columns and indexed FKs on `Product`.
No change to existing hot-path queries unless a caller opts into the new filters.

## Security impact

None new — same admin-CRUD pattern as every other taxonomy model in this codebase (`isAdmin`
guard), same public-read pattern as `Category`/`Collection`.

## Testing plan

- CRUD for each new taxonomy model (create, list, update, soft-disable via `isActive`).
- Product create/update accepting and persisting the new fields.
- Product list filtering by `materialSlug`/`styleSlug`/`roomSlug`, including the "no match"
  empty-result case.
- Confirm existing products (no material/style/room set) continue to work unchanged — every new
  field is nullable, so this should require no data migration, but verify a pre-existing seeded
  product still renders/filters correctly with all-null new fields.

## Rollback plan

Fully additive — three new tables, nullable FKs, nullable columns on `Product`. Reverting drops the
new tables/columns; no existing data is altered.

## Status

Spec only, not yet implemented — implementation is the next step.
