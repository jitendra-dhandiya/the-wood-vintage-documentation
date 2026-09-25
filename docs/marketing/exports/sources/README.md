# Sources and method: top-50-us-best-selling-products.xlsx

Fetched 2026-09-25 (UTC times per row in column P). Internal research only. Thumbnails belong to their owners: do not reuse on our site, ads or listings.

"Top selling" is a proxy (public review counts, retailer best-seller sort order), not sales data. See the workbook sheet "Method & caveats".

## Pages read (public HTML and product JSON, sequential, about 1 s delay)
- World Market: `https://www.worldmarket.com/search?q=<term>&srule=top-sellers` (tile price, rating, review count, sort position) and each `/p/<slug>.html` product page (price, list price, dimensions, image).
- Timbergirl: `https://timbergirl.com/collections/<collection>?sort_by=best-selling`, `/products/<handle>.js`.
- World Interiors: `https://worldinteriors.com/collections/<collection>?sort_by=best-selling`, `/products/<handle>.js`.
- The Vintage Realm: `https://thevintagerealm.com/collections/<collection>?sort_by=best-selling`, `/products/<handle>.js`.
- Urli Utsav Decor: `https://urliutsav.com/collections/<collection>?sort_by=best-selling`, `/products/<handle>.js`.
- The Mandir Store: `https://themandirstore.us/collections/pooja-mandirs?sort_by=best-selling`, `/products/<handle>.js`.

## Blocked or unusable (no data taken, no values invented)
Etsy (403), Amazon.com (bot check, no product data), Wayfair (429), eBay (403), The Home Depot (403), Walmart and Target (JavaScript shells), Novica (JavaScript), Overstock (404), Pottery Barn / CB2 / Crate and Barrel / West Elm (blocked earlier), Jaipur Living and Kalalou (no usable feed). Result: no Amazon, Etsy or Wayfair rows.

## Refresh
See "How to refresh" in the workbook. Missing next step: capture Etsy 'Bestseller' badge and sales counts and Amazon Best Sellers Rank in a normal browser.

## Related repo docs
competitor-research/us-b2c-price-benchmark.md, us-b2c-competitor-analysis.md, marketing/best-selling-products-by-market.md, marketing/us-first-100/03-starter-catalogue.md (our SKUs and planned prices).
