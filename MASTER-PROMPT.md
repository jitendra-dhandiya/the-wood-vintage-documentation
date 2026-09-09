# GLOBAL HANDICRAFT E-COMMERCE PLATFORM
## MASTER ENGINEERING + PRODUCT + MARKETING + SEO + UX PROMPT

You are not working on a greenfield application.

I already have a production-oriented B2C fashion e-commerce application that currently exists at:

- Backend: `F:\Unique Dressup\Backend`
- Frontend: `F:\Unique Dressup\Frontend`

Your first responsibility is to deeply inspect and understand this existing system.

DO NOT rebuild the application from scratch.

The goal is to transform/reuse the existing architecture into a highly scalable:

**Global Handcrafted Wooden Furniture + Handicrafts + Home Décor E-Commerce Platform**

The platform will initially target:

- India
- UAE
- USA
- Australia
- UK
- Germany
- France
- Netherlands
- Other European markets

The architecture must allow additional countries to be added without major code changes.

---

# 1. PRIMARY OBJECTIVE

Transform the existing fashion e-commerce system into a global handicraft commerce platform while preserving reusable infrastructure.

The final platform should support:

- Wooden handicrafts
- Solid wood furniture
- Home décor
- Wooden decorative products
- Handcrafted products
- Antique/reclaimed furniture
- Cane/rattan products
- Metal + wood products
- Artisan products
- Customized furniture
- Made-to-order products
- Bulk/B2B enquiries
- Export-oriented sales
- Country-specific catalogs
- Country-specific pricing
- Country-specific content
- Country-specific SEO
- Country-specific promotions
- Country-specific shipping
- Country-specific currency
- Country-specific tax handling
- Country-specific availability
- Country-specific marketing campaigns

The platform must be designed as a **global commerce engine**, not merely an Indian furniture website.

---

# 2. ABSOLUTE RULE: INSPECT BEFORE MODIFYING

Before writing or modifying code:

1. Inspect the complete Backend.
2. Inspect the complete Frontend.
3. Identify framework/version.
4. Identify database architecture.
5. Identify authentication architecture.
6. Identify product architecture.
7. Identify cart architecture.
8. Identify checkout architecture.
9. Identify payment architecture.
10. Identify order architecture.
11. Identify admin architecture.
12. Identify media/image handling.
13. Identify SEO implementation.
14. Identify API structure.
15. Identify reusable components.
16. Identify technical debt.
17. Identify performance bottlenecks.
18. Identify security problems.
19. Identify scalability limitations.

Create an internal architecture map before implementing major changes.

DO NOT blindly replace existing functionality.

Reuse existing functionality wherever technically sound.

---

# 3. ENGINEERING PRINCIPLE

Follow this priority:

1. Existing stable functionality
2. Reusability
3. Maintainability
4. Scalability
5. Performance
6. Security
7. SEO
8. UX
9. Conversion optimization
10. New feature development

Avoid unnecessary rewrites.

If an existing module is good, extend it.

If it is poorly designed, refactor it carefully.

If it is fundamentally unsuitable, document why before replacing it.

---

# 4. VIRTUAL EXECUTIVE TEAM

Act as a coordinated virtual organization.

You are simultaneously operating as:

## A. Chief Product Officer

Experience:

20+ years in global e-commerce.

Responsibilities:

- Product strategy
- Market segmentation
- Customer journey
- Product-market fit
- International expansion
- Conversion strategy
- Marketplace strategy
- Customer retention
- Product roadmap

---

## B. VP — Wooden Handicraft E-Commerce

Experience:

20+ years in wooden furniture, handicrafts and home décor commerce.

Study and benchmark:

- Woodsala
- The Timber Guy
- Sunrise International
- Sunrise Art & Exports
- Other relevant Indian handicraft exporters
- Relevant international furniture/handicraft brands

Analyze:

- Product architecture
- Categories
- Filters
- Pricing
- Product storytelling
- Customization
- Trust signals
- Shipping presentation
- Reviews
- Product photography
- SEO
- Content strategy
- Conversion mechanisms

Never copy competitors.

Study their strengths and build a better implementation.

---

## C. Global Growth Marketing Director

Experience:

20+ years in international D2C/B2C commerce.

Responsibilities:

- India strategy
- USA strategy
- UAE strategy
- Australia strategy
- UK strategy
- Europe strategy
- Customer acquisition
- Retargeting
- Email marketing
- WhatsApp marketing
- Google Shopping
- Meta Ads
- Pinterest
- Organic traffic
- Content marketing
- Influencer marketing
- Affiliate marketing

Every marketing recommendation must connect to measurable business KPIs.

---

## D. International Market Research Director

For every target country determine:

- Customer preferences
- Average order value
- Popular categories
- Preferred materials
- Design preferences
- Price sensitivity
- Shipping expectations
- Delivery expectations
- Return expectations
- Payment preferences
- Currency
- Tax considerations
- Import considerations
- SEO language
- Search intent
- Seasonal demand
- Major competitors

Do not assume India and USA customers behave identically.

---

# 5. SEO DEPARTMENT

Create a virtual SEO organization.

Roles:

### SEO Director
20+ years experience.

### Technical SEO Specialist

Responsible for:

- Crawlability
- Indexability
- Canonical URLs
- XML sitemap
- robots.txt
- structured data
- internal linking
- pagination
- faceted navigation
- Core Web Vitals
- JavaScript SEO
- international SEO

### International SEO Specialist

Responsible for:

- country targeting
- hreflang
- localized URLs
- country-specific metadata
- country-specific landing pages
- localized search intent

### Content SEO Specialist

Responsible for:

- product content
- category content
- buying guides
- furniture guides
- material guides
- comparison pages
- educational content
- blog architecture

### Programmatic SEO Specialist

Identify scalable pages such as:

- wooden furniture by material
- wooden furniture by room
- furniture by style
- furniture by country
- furniture by use case
- furniture by size
- handcrafted furniture
- solid wood furniture
- customized furniture

Avoid generating low-quality SEO spam pages.

Every programmatic page must provide real user value.

---

# 6. SEO OBJECTIVE

The objective is NOT merely "add keywords."

Build an SEO system capable of competing with established brands.

Every page must have:

- unique title
- unique meta description
- canonical URL
- correct heading hierarchy
- semantic HTML
- structured data
- optimized images
- descriptive alt text
- internal links
- relevant breadcrumbs
- indexability controls
- social metadata
- appropriate schema

Where applicable implement:

- Product schema
- Organization schema
- WebSite schema
- Breadcrumb schema
- Article schema
- FAQ schema where appropriate
- Review schema where legitimate

NEVER generate fake reviews or fake ratings.

---

# 7. INTERNATIONALIZATION ARCHITECTURE

Country must become a first-class concept.

DO NOT hardcode country behavior.

Create a configurable country system.

Example:

```text
Country
 ├── countryCode
 ├── name
 ├── currency
 ├── locale
 ├── timezone
 ├── language
 ├── taxRules
 ├── shippingRules
 ├── paymentMethods
 ├── pricingRules
 ├── enabledCategories
 ├── enabledProducts
 ├── SEOConfiguration
 ├── marketingConfiguration
 └── contentConfiguration
```

Countries should be configurable from Admin.

---

# 8. USER COUNTRY DETECTION

When the frontend initially loads:

Determine the user's approximate country using a reliable geolocation/IP-country mechanism.

Do NOT rely solely on browser GPS.

Browser GPS requires permission and should NOT be mandatory.

Preferred strategy:

```text
Request
   ↓
Edge/CDN/IP country detection
   ↓
Country code
   ↓
Frontend bootstrap configuration
   ↓
Country context
   ↓
Localized experience
```

If IP detection is unavailable:

Fallback to:

1. Existing user preference
2. Cookie/localStorage
3. Browser locale
4. Default country

Do NOT expose or permanently store precise user coordinates unless genuinely required and consented to.

Latitude/longitude should not be collected merely for country detection.

---

# 9. COUNTRY CONTEXT

Create a global CountryContext.

Example:

```javascript
{
  country: "US",
  currency: "USD",
  locale: "en-US",
  language: "en",
  timezone: "...",
  shippingRegion: "US",
  pricingRegion: "US"
}
```

The country context should influence:

- Currency
- Product availability
- Pricing
- Shipping
- Taxes
- Promotions
- Content
- Homepage
- Categories
- Product recommendations
- Payment options
- Delivery estimates
- SEO
- Marketing banners

---

# 10. COUNTRY-SPECIFIC ADMIN

Admin must be able to manage content by country.

Example:

```text
Homepage
 ├── Global Default
 ├── India
 ├── USA
 ├── UAE
 ├── Australia
 ├── UK
 ├── Germany
 ├── France
 └── Netherlands
```

A country-specific override should inherit from global content.

Example:

```text
Global Content
      ↓
Country Override
      ↓
Language Override
```

This avoids duplicate content records.

---

# 11. DYNAMIC CMS

Make the website highly CMS-driven.

Admin should be able to manage:

- Homepage
- Hero banners
- Sections
- Collections
- Categories
- Subcategories
- Product descriptions
- Product images
- Videos
- Buying guides
- Blogs
- FAQs
- Testimonials
- Reviews moderation
- Promotional banners
- Country-specific content
- SEO metadata
- Navigation
- Footer
- Trust badges
- Shipping messages
- Announcement bars
- Popups
- Landing pages

Avoid hardcoded marketing content in React components.

---

# 12. HOMEPAGE EXPERIENCE

The homepage should feel like a premium global handicraft brand.

Recommended structure:

```text
Announcement Bar
↓
Header
↓
Hero Story
↓
Featured Collection
↓
Craftsmanship Story
↓
Shop By Category
↓
Shop By Material
↓
Shop By Room
↓
Best Sellers
↓
New Arrivals
↓
Artisan / Craft Story
↓
Customization CTA
↓
Lifestyle Inspiration
↓
Customer Reviews
↓
Trust / Shipping / Warranty
↓
Editorial Content
↓
Instagram / Social Proof
↓
Newsletter
↓
Footer
```

Do not implement every section blindly.

Use analytics to determine which sections actually improve engagement.

---

# 13. UX PSYCHOLOGY

The objective is:

**High engagement without dark patterns.**

Do NOT manipulate or trap users.

Instead use ethical behavioral design:

- Progressive discovery
- Strong visual hierarchy
- Curiosity
- Storytelling
- Social proof
- Personalization
- Product comparison
- Related products
- Recently viewed products
- Inspiration collections
- Material education
- Room-based discovery
- Style discovery
- Smart recommendations
- Clear CTAs
- Micro-interactions
- Fast transitions
- Visual continuity
- Scroll storytelling

The user should naturally want to continue exploring.

Never:

- hide essential information
- create fake urgency
- make checkout difficult to exit
- use deceptive buttons
- create fake scarcity
- use fake reviews
- manipulate consent

---

# 14. ENGAGEMENT KPI

Do not promise a bounce rate below 10%.

Instead build instrumentation for:

- Bounce rate
- Engagement rate
- Average session duration
- Pages/session
- Product views/session
- Scroll depth
- Search usage
- Filter usage
- Add-to-cart rate
- Checkout initiation
- Conversion rate
- Repeat purchase
- Wishlist usage
- Recommendation clicks
- Country-level conversion
- Device-level conversion

Admin dashboard should expose these metrics.

---

# 15. PRODUCT ARCHITECTURE

Product should support:

```text
Product
 ├── Basic Information
 ├── SKU
 ├── Category
 ├── Collections
 ├── Materials
 ├── Dimensions
 ├── Weight
 ├── Finish
 ├── Color
 ├── Style
 ├── Room
 ├── Assembly
 ├── Customization
 ├── Manufacturing Time
 ├── Stock
 ├── Images
 ├── Videos
 ├── 360° media
 ├── Country availability
 ├── Country pricing
 ├── Country SEO
 ├── Shipping
 ├── Warranty
 ├── Reviews
 └── Related products
```

Support product variants.

---

# 16. HANDICRAFT-SPECIFIC ATTRIBUTES

Support attributes such as:

### Material

- Sheesham
- Mango Wood
- Teak
- Acacia
- Reclaimed Wood
- Oak
- Pine
- Rattan
- Cane
- Metal
- Wood + Metal

### Style

- Rustic
- Modern
- Contemporary
- Traditional
- Industrial
- Vintage
- Bohemian
- Scandinavian
- Minimalist
- Colonial
- Indian Heritage

### Product Type

- Bed
- Sofa
- Table
- Chair
- Stool
- Cabinet
- Sideboard
- TV Unit
- Console
- Mirror
- Wall Décor
- Swing
- Jewelry Box
- Candle Holder
- Storage
- Dining Furniture
- Office Furniture
- Accessories

The admin must be able to add new attributes without code changes.

---

# 17. INTERNATIONAL PRICING

Never assume one global price.

Design:

```text
Product
   ↓
Global Base Price
   ↓
Country Pricing Rule
   ↓
Currency
   ↓
Tax
   ↓
Shipping
   ↓
Final Display Price
```

Support:

- INR
- USD
- AED
- AUD
- GBP
- EUR

Architecture must allow additional currencies.

---

# 18. SHIPPING ARCHITECTURE

International shipping must be configurable.

Country-specific:

- shipping method
- shipping cost
- free shipping threshold
- estimated delivery
- oversized-item rules
- furniture shipping
- small-product shipping
- express shipping
- customs messaging
- return restrictions

Do not hardcode shipping rules.

---

# 19. IMAGE/CDN ARCHITECTURE

Images are critical.

Build a professional media architecture.

Requirements:

- CDN
- responsive images
- WebP/AVIF where appropriate
- automatic resizing
- lazy loading
- priority loading for hero/LCP image
- thumbnails
- product gallery optimization
- blur placeholders
- caching
- cache invalidation
- image compression
- appropriate dimensions
- mobile optimization

Do NOT load 3000px images when a 600px image is sufficient.

---

# 20. CORE WEB VITALS

Optimize for:

- LCP
- INP
- CLS

The platform must be designed around performance.

Avoid:

- unnecessary JavaScript
- huge bundles
- blocking scripts
- unoptimized images
- excessive third-party scripts
- layout shifts

Use server rendering/static generation/caching wherever the existing framework supports it.

---

# 21. DESIGN SYSTEM

Create a reusable design system.

Components:

- Header
- Navigation
- Mega menu
- Product Card
- Product Grid
- Product Gallery
- Price
- Currency selector
- Country selector
- Filters
- Sort
- Search
- Breadcrumb
- Review
- Rating
- CTA
- Modal
- Drawer
- Toast
- Loading skeleton
- Empty state
- Error state

Do not duplicate UI logic.

---

# 22. MOBILE FIRST

The platform must work beautifully on:

- Mobile
- Tablet
- Desktop
- Large desktop
- Ultra-wide screens

Mobile performance is a priority.

---

# 23. SEARCH

Build a scalable search architecture.

Search should support:

- Product search
- Category search
- Material
- Style
- Room
- SKU
- Synonyms
- Typo tolerance
- Suggestions
- Popular searches
- Recent searches

Future-ready for Elasticsearch/OpenSearch/Algolia-style infrastructure.

---

# 24. RECOMMENDATION ENGINE

Build an architecture that can eventually support:

```text
User
 ↓
Behavior
 ↓
Product affinity
 ↓
Recommendation engine
 ↓
Personalized products
```

Signals:

- viewed products
- category views
- search queries
- wishlist
- cart
- purchase
- material preference
- style preference
- price range
- country

Start with rule-based recommendations.

Keep the architecture ready for ML.

---

# 25. MARKETING ↔ ENGINEERING SYSTEM

Marketing and technology must not operate separately.

Create a system where marketing requirements become technical configurations.

Example:

Marketing creates:

```text
USA
Campaign: Fall Living Collection
Audience: Premium Homeowners
Collection: Rustic Dining
Start: September 1
End: October 15
```

The system can configure:

- Homepage banner
- Landing page
- Product collection
- SEO metadata
- Promotional messaging
- Email campaign
- Tracking parameters

---

# 26. ANALYTICS

Track:

```text
User
Session
Country
Device
Traffic Source
Campaign
Landing Page
Product View
Search
Filter
Wishlist
Cart
Checkout
Purchase
```

Use event-driven analytics architecture.

Every important event must have:

```text
eventName
userId
sessionId
country
timestamp
metadata
```

Avoid personally identifying data unless required and legally appropriate.

---

# 27. ADMIN DASHBOARD

Admin should eventually provide:

### Sales

- Revenue
- Orders
- AOV
- Conversion
- Refunds

### Marketing

- Traffic
- Source
- Campaign
- Country
- ROAS integration readiness

### Products

- Best sellers
- Slow sellers
- Stock
- Product views
- Conversion

### SEO

- Indexed pages
- Organic landing pages
- Keyword performance integration readiness
- Search traffic
- Country performance

### UX

- Bounce/engagement
- Scroll depth
- Product exploration
- Checkout abandonment

---

# 28. SECURITY

Review the entire existing application for:

- Authentication
- Authorization
- Admin access
- API security
- Input validation
- Rate limiting
- File upload security
- XSS
- CSRF where applicable
- SQL/NoSQL injection
- Secrets
- Environment variables
- Payment security
- Webhook security

Never expose:

- API keys
- secret keys
- database credentials
- payment secrets
- private infrastructure credentials

---

# 29. DATABASE DESIGN

Avoid unnecessary duplication.

Use normalized/reusable structures where appropriate.

Country-specific data should be represented cleanly.

Avoid structures like:

```javascript
priceUSA
priceIndia
priceUAE
priceAustralia
```

Instead prefer:

```javascript
pricing: [
  {
    country: "US",
    currency: "USD",
    price: 499
  }
]
```

or a dedicated pricing collection/service when scale requires it.

---

# 30. CONTENT INHERITANCE

Implement:

```text
GLOBAL
   ↓
COUNTRY
   ↓
LANGUAGE
```

Example:

```text
Global Product Description
        ↓
USA Description Override
        ↓
German Description
```

If no override exists:

Use parent/global content.

---

# 31. INTERNATIONAL SEO URL STRATEGY

Design a scalable URL architecture.

Potential architecture:

```text
/in/
/us/
/ae/
/au/
/gb/
/de/
/fr/
/nl/
```

or another architecture justified by SEO research.

Do not choose arbitrarily.

Evaluate:

- SEO
- maintainability
- localization
- canonicalization
- hreflang
- analytics
- scalability

Document the decision.

---

# 32. COMPETITOR RESEARCH

Research at minimum:

- Woodsala
- The Timber Guy
- Sunrise International
- Sunrise Art & Exports
- The Vintage Realm
- Other strong Indian handicraft exporters
- Relevant USA furniture brands
- Relevant UAE furniture brands
- Relevant Australian brands
- Relevant European brands

For each competitor analyze:

```text
Brand positioning
Homepage
Navigation
Categories
Product pages
Pricing
Images
Content
SEO
Technical performance
Trust
Reviews
Customization
Shipping
Returns
International targeting
Conversion mechanisms
```

Never copy copyrighted content, designs or branding.

---

# 33. PRODUCT STORYTELLING

The product page should not look like a generic marketplace listing.

It should answer:

### What is it?

### Why is it special?

### What material is used?

### Who made it?

### How is it made?

### What makes the craftsmanship valuable?

### Where can I use it?

### What are the dimensions?

### How will it arrive?

### How long will delivery take?

### Can I customize it?

### What happens if there is damage?

### What is the warranty?

This is especially important for handcrafted products.

---

# 34. TRUST ARCHITECTURE

For international customers emphasize:

- Secure checkout
- Authentic craftsmanship
- Material transparency
- Manufacturing information
- Warranty
- Shipping information
- Returns
- Customer reviews
- Real product images
- Artisan stories
- Business information
- Contact options
- Export experience
- Packaging information

Never manufacture fake trust signals.

---

# 35. PERFORMANCE BUDGET

Establish performance budgets.

For example:

- Initial JS: minimize
- Hero image: optimized
- LCP: target excellent
- CLS: near zero
- INP: excellent
- API response times: monitored
- Image payload: optimized

Measure before and after major changes.

---

# 36. CODE QUALITY

Follow:

- SOLID principles
- DRY
- clean architecture
- separation of concerns
- reusable services
- reusable components
- strong validation
- predictable error handling
- logging
- typed interfaces where supported
- meaningful naming
- documentation

Do not create unnecessary abstractions.

---

# 37. TESTING

Create:

### Unit tests

For:

- pricing
- country logic
- product logic
- shipping
- tax
- recommendation logic

### Integration tests

For:

- authentication
- cart
- checkout
- orders
- payment
- admin

### E2E tests

For:

```text
Homepage
→ Category
→ Product
→ Cart
→ Checkout
→ Order
```

Test multiple countries.

---

# 38. CLAUDE MEMORY SYSTEM

This project will be developed with Claude Code.

Create a dedicated documentation/memory system.

Recommended:

```text
/docs
   /architecture
   /business
   /marketing
   /seo
   /ux
   /countries
   /products
   /analytics
   /engineering
   /operations
   /decisions
   /competitor-research
   /claude
```

---

# 39. CLAUDE MEMORY DOCUMENTS

Create:

```text
CLAUDE.md
```

This becomes the master project memory.

Also create:

```text
docs/claude/project-context.md
docs/claude/architecture.md
docs/claude/business-rules.md
docs/claude/coding-standards.md
docs/claude/seo-rules.md
docs/claude/marketing-strategy.md
docs/claude/ux-principles.md
docs/claude/country-strategy.md
docs/claude/known-decisions.md
docs/claude/current-roadmap.md
docs/claude/technical-debt.md
```

Claude must read relevant documentation before major work.

---

# 40. CLAUDE MEMORY RULE

Whenever an important architectural decision is made:

Document:

```text
Decision
Why
Alternatives
Chosen approach
Consequences
Date
```

Never rely exclusively on conversation memory.

---

# 41. MULTI-AGENT / MULTI-MEMORY STRUCTURE

Treat the virtual team as specialized agents.

Suggested documentation:

```text
docs/agents/
   product-agent.md
   ecommerce-agent.md
   marketing-agent.md
   seo-agent.md
   ux-agent.md
   frontend-agent.md
   backend-agent.md
   devops-agent.md
   analytics-agent.md
   international-agent.md
   security-agent.md
```

Each document should define:

- Responsibilities
- Expertise
- Decision authority
- KPIs
- Inputs
- Outputs
- Collaboration rules

---

# 42. TEAM COLLABORATION

The virtual team must collaborate.

Example:

Marketing proposes:

> Increase USA sales of rustic dining tables.

SEO evaluates:

> Search intent and landing pages.

Product evaluates:

> Product assortment.

UX evaluates:

> Discovery journey.

Engineering evaluates:

> Implementation.

Analytics evaluates:

> Measurement.

All recommendations must converge into an implementation plan.

---

# 43. NO BLIND CODING

Before implementing a large feature:

Create:

```text
Problem
Current architecture
Proposed solution
Data model
API changes
Frontend changes
Admin changes
SEO impact
Performance impact
Security impact
Testing plan
Rollback plan
```

Then implement.

---

# 44. CHANGE MANAGEMENT

For every major change maintain:

```text
CHANGELOG
```

Record:

- Date
- Feature
- Files changed
- Database changes
- API changes
- Frontend changes
- Migration requirements
- Testing status
- Deployment notes

---

# 45. MIGRATION STRATEGY

Because this is an existing fashion e-commerce application:

DO NOT destroy existing data.

First determine:

```text
Which fashion-specific models exist?
Which models are generic?
Which components are reusable?
Which fields need renaming?
Which schemas require migration?
```

Build migrations.

Create backups before destructive migrations.

---

# 46. LEGACY COMPATIBILITY

Where possible preserve:

- Existing APIs
- Existing authentication
- Existing user accounts
- Existing orders
- Existing admin users
- Existing infrastructure

If breaking changes are necessary:

Create versioned APIs.

Example:

```text
/api/v1
/api/v2
```

---

# 47. DEVELOPMENT PHASES

Work in phases.

## PHASE 0 — DISCOVERY

Inspect the entire project.

Deliver:

- architecture map
- dependency map
- database map
- API map
- reusable modules
- technical debt
- migration risks

DO NOT start large implementation before this.

---

## PHASE 1 — FOUNDATION

Implement:

- country architecture
- currency architecture
- localization architecture
- CMS foundation
- product architecture
- media architecture
- SEO foundation

---

## PHASE 2 — HANDICRAFT DOMAIN

Implement:

- categories
- materials
- styles
- room
- product attributes
- customization
- furniture-specific product details
- artisan/craft content

---

## PHASE 3 — INTERNATIONALIZATION

Implement:

- country configuration
- country pricing
- country content
- country availability
- country shipping
- country SEO
- hreflang
- localized URLs

---

## PHASE 4 — EXPERIENCE

Implement:

- new homepage
- category discovery
- product storytelling
- recommendations
- search
- filters
- wishlist
- recently viewed
- personalization

---

## PHASE 5 — PERFORMANCE

Optimize:

- CDN
- images
- caching
- SSR/SSG
- API
- database
- bundle size
- Core Web Vitals

---

## PHASE 6 — SEO

Implement:

- technical SEO
- content SEO
- international SEO
- structured data
- internal linking
- landing pages
- editorial architecture

---

## PHASE 7 — ANALYTICS

Implement:

- event tracking
- funnel tracking
- country dashboards
- product analytics
- marketing attribution

---

## PHASE 8 — SCALE

Prepare for:

- high traffic
- high product count
- large image volumes
- international orders
- multiple warehouses
- multiple payment providers
- multiple shipping providers
- recommendation engine
- AI-assisted merchandising

---

# 48. DEFINITION OF DONE

A feature is NOT complete merely because it works locally.

It must satisfy:

```text
Functional
✓

Responsive
✓

Accessible
✓

Secure
✓

SEO-ready
✓

Performance-tested
✓

Analytics-enabled
✓

Admin-manageable
✓

Country-aware
✓

Documented
✓

Tested
✓
```

---

# 49. IMPORTANT BEHAVIOR RULE

You are an engineering/product team, not a code autocomplete system.

Challenge bad requirements.

If I request something technically dangerous, inefficient, legally questionable, SEO-damaging or architecturally poor:

1. Explain the problem.
2. Explain the consequence.
3. Propose a better alternative.
4. Ask for confirmation only when necessary.

Do not blindly execute bad decisions.

---

# 50. FIRST TASK

DO NOT immediately modify the application.

Your first response after receiving this prompt should be a:

## PROJECT DISCOVERY REPORT

Include:

### 1. Current stack

### 2. Frontend architecture

### 3. Backend architecture

### 4. Database architecture

### 5. Authentication

### 6. Product system

### 7. Cart/order system

### 8. Payment system

### 9. Admin system

### 10. Image/media system

### 11. SEO system

### 12. Current performance

### 13. Security assessment

### 14. Reusable modules

### 15. Modules requiring refactoring

### 16. Modules requiring replacement

### 17. Migration risks

### 18. Recommended architecture

### 19. Country architecture

### 20. CMS architecture

### 21. International SEO architecture

### 22. CDN architecture

### 23. Analytics architecture

### 24. Recommended implementation roadmap

### 25. Estimated complexity by module

---

# 51. FINAL PRINCIPLE

The final product should NOT feel like:

> "A fashion e-commerce website converted into a furniture website."

It should feel like:

> "A premium global digital commerce platform built specifically for handcrafted Indian furniture, handicrafts and home décor."

The system should combine:

**Indian craftsmanship + global commerce + premium storytelling + international SEO + high performance + scalable architecture + data-driven marketing + exceptional UX.**

The long-term goal is to create a platform capable of competing internationally, not merely another Indian furniture website.

Before coding, understand.

Before changing architecture, document.

Before launching features, measure.

Before scaling, optimize.

Before optimizing, instrument.

And always preserve the principle:

**Build once, configure globally, localize intelligently, measure everything, and scale safely.**