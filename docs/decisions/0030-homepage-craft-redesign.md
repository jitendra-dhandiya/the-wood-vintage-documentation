# 0030. Homepage craft redesign: real photography and a craft-story layout

Date: 2026-09-21

## Decision

Rebuild the storefront homepage so it reads as a craft story rather than a stack of identical
wood-grain placeholder tiles, using real, licence-attributed photography and frontend-composed
sections fed by the existing homepage-section system. No schema change or migration.

## Why

`home-d.png` / `home-m.png` (QA, 2026-09-20) showed Shop by Category / Room / Material as near-identical
dark placeholder tiles with text on top. For the client presentation the page needs to feel
handmade, rich and worth scrolling.

## What changed

- **Sections** (all rows in `homepage_sections`, order and copy admin-editable; text/structure in
  `backend/prisma/seed-data/homepage.ts`, extra copy/images in each row's `config` JSON):
  `HERO_SLIDER` (split hero: walnut-texture copy panel + crossfading craft photography, progress bar,
  arrows, pause on hover/focus, Ken Burns drift; both off under `prefers-reduced-motion`),
  `MARQUEE`, `BRAND_SECTION` (craft story: photo collage, three promises, numbers),
  `FEATURED_CATEGORIES` (asymmetric 12-col editorial collage), `BEST_SELLERS`,
  `SHOP_BY_MATERIAL` ("Know your wood": expanding swatch panels on desktop, stacked on mobile),
  `ARTISAN_SPOTLIGHT` ("From the workshop": 4-step process with photos + maker cards),
  `SHOP_BY_ROOM` (asymmetric collage with hover reveal), `SHOP_BY_LOOK` (tabbed curated rooms listing
  the products of a Collection), `NEW_ARRIVALS`, `TESTIMONIALS` (serif quote cards on a light wood texture),
  `INSTAGRAM_GALLERY` (8-photo mosaic), `PROMO_STRIP` (trust row with icons, config-driven),
  `NEWSLETTER` (walnut-texture band; the footer's duplicate newsletter is hidden on the homepage).
  Existing section types were reused, so **no `prisma migrate`** was needed.
- **Components**: `frontend/components/home/craft/*` plus rewritten `HeroSlider.tsx`,
  `TestimonialsSection.tsx`; `ProductSection` headings now use Cormorant. `next/image` everywhere (only the
  first hero slide is `priority`), fixed aspect boxes so nothing shifts, reveals via framer-motion honour
  reduced motion.
- **Imagery**: 25 new Wikimedia Commons / Pixabay-on-Commons photos in `backend/prisma/seed-assets/`
  (max 2000 px, credited in `ATTRIBUTION.json` and below). They now drive the hero, categories, rooms,
  materials (Sheesham, Teak, Acacia, Rattan, Cane, Pine, Reclaimed, Wood+Metal), collections,
  promotional banners, section imagery and two textures. Each was viewed before use.
- **Truthful product photos only**: trunk (a carved storage chest, shown as the form), plus two new products
  whose photos are the product: *Hand-Carved Krishna Panel* and *Handcrafted Wooden Kitchen Utensil Set*.
  Every other product keeps the labelled PLACEHOLDER. Artisan portraits stay initials placeholders
  (real people's faces must not be attached to fictional artisans).
- **Textures** (`seed-site-texture-walnut/cream`) are the Sheesham and pine photos tinted dark / light in
  the seed; not new photography.
- **Seed** stays idempotent: photo-backed images carry a sidecar signature (source|crop|size) so changing a
  slot from placeholder to photo, or re-cropping, is picked up on the next run and unchanged images are
  skipped; the homepage-section delete+create now runs in one transaction (a failed run used to leave the
  homepage empty); sort orders are no longer skipped on re-runs.

## Alternatives

- New `HomepageSectionType` values + migration: unnecessary, existing types map cleanly.
- Unsplash/Pexels: their search/API is blocked from this environment (403), so Commons was used.
- Full-bleed hero: portrait craft photos (carpenter, carved panel) crop badly at 2.5:1, hence the split hero.

## Consequences / gaps

- Only 3 of 46 products have real photos; the rest need client photography.
- No mango wood or real artisan portrait photography was found; the mango swatch is a placeholder and is left
  out of "Know your wood".
- Images from `Shixart1985` (CC BY 2.0) look like stock/possibly generated; confirm provenance before launch.
- CC BY / CC BY-SA credits must appear on a public credits page before launch (not built yet).
- Newsletter form and Instagram handle are demo only (no subscribe endpoint exists; footer form was already inert).
- Admin homepage editor has no bespoke config forms for the new config JSON (edit via seed for now).
- First `npm run seed:handicraft` after adding images takes ~10 minutes while derivatives pre-warm
  (`SEED_SKIP_PREWARM=1` skips).

## New photo credits (all Wikimedia Commons; images resized/cropped only)

| Asset | Commons file | Author | Licence |
|---|---|---|---|
| `carved-storage-chest.jpg` | Traditional Wooden Storage Chest with Carved Panels (Indigenous Craftsmanship).jpg | Aliva Sahoo | CC BY-SA 4.0 |
| `teak-dining-table.jpg` | Dining table brown.jpg | Vaibhavratnaparkhi | CC BY-SA 4.0 |
| `pine-grain.jpg` | Pressed pine wood grain and texture close up.jpg | Kurt Kaiser | CC0 |
| `weathered-wood.jpg` | Weathered wood texture.jpg | Kelsey Todd | CC BY-SA 4.0 |
| `cut-logs.jpg` | Circles within circles - freshly cut logs.jpg | FotoFree | CC BY-SA 4.0 |
| `carpenter-workshop.jpg` | Skilled Carpenter Working on Wood in a Workshop.jpg | The open draft | CC BY-SA 4.0 |
| `craftsman-planing.jpg` | Craftsman shaping wood in a workshop during daylight hours with focus on precision and detail in woodworking.jpg | Shixart1985 | CC BY 2.0 |
| `living-room-coffee-table.jpg` | Modern living room with stylish furniture and a view of the outdoors in a cozy apartment setting.jpg | Shixart1985 | CC BY 2.0 |
| `krishna-carving.jpg` | Krishna holding flute.jpg | Joe M500 | CC BY 2.0 |
| `carved-door-south-india.jpg` | WLA haa Carved Wooden Doors South India ca 18th century.jpg | Hiart | CC0 |
| `teak-root-table.jpg` | USVI IMG 5443 - Large organic wooden table and chairs sit in a rustic stone-walled room with terracotta tiles.jpg | Category:Government of the United States Virgin Islands | Public domain |
| `hand-plane-shavings.jpg` | Plane (tool).jpg | Goldmund100 | CC BY-SA 3.0 |
| `bowl-turning.jpg` | Bowl turning.jpg | Grwoodturning | CC BY-SA 4.0 |
| `kerala-chariot-panelling.jpg` | WLA haa Chariot Panelling South Kerala 2.jpg | Hiart | CC0 |
| `bedroom-headboard.jpg` | DZ6 0461 Cozy neatly made hotel room with a king bed soft pillows bedside lamps and calming neutral decor.jpg | PattayaPatrol | CC BY-SA 4.0 |
| `bedroom-wood-headboard.jpg` | Modern bedroom design with wooden mountain headboard in cozy space.jpg | Shixart1985 | CC BY 2.0 |
| `home-office-desk.jpg` | Home-office-336377.jpg | By Free-Photos from Pixabay | CC0 |
| `dining-area.jpg` | Dining area with wooden table and chairs in a bright room.jpg | Shixart1985 | CC BY 2.0 |
| `kitchen-utensils-fair.jpg` | Wooden Kitchen Utensils.jpg | Subhadip Mukherjee | CC BY-SA 4.0 |
| `kitchen-utensils-set.jpg` | Set of seven handcrafted made in India wooden kitchen utensils.jpg | Badhan.kv | CC BY-SA 4.0 |
| `kitchen-utensils-set-2.jpg` | Set of seven handcrafted made in India wooden kitchen utensils (68607).jpg | Badhan.kv | CC BY-SA 4.0 |
| `rattan-furniture-set.jpg` | 06121 selangor wh4.JPG | Tolleya | CC BY-SA 3.0 |
| `cane-chair-weaving.jpg` | Flechten Sitzfläche Stuhl.JPG | 4028mdk09 | CC BY-SA 3.0 |
| `sheesham-surface.jpg` | Sheesham.jpg | Andy king50 | CC BY-SA 3.0 |
| `haveli-carved-door.jpg` | India Mandawa haveli 04 ni.JPG | Nicolás Pérez | CC BY-SA 3.0 |

