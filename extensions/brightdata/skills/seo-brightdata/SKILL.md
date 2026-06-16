---
name: seo-brightdata
description: >
  Unblockable web scraping (anti-bot bypass), Scraping Browser (Playwright +
  CAPTCHA solving), multi-platform AI visibility (ChatGPT, Grok, Perplexity),
  dataset collectors for recurring monitoring, e-commerce data (Amazon, Google
  Shopping, Walmart), social media (LinkedIn, TikTok, YouTube), and business
  intelligence (Crunchbase, ZoomInfo, Zillow). Requires Bright Data extension.
  Use when user says "brightdata", "bright data", "anti-bot", "unblockable",
  "CAPTCHA bypass", "ChatGPT visibility", "Grok", "Perplexity", "AI visibility",
  "amazon data", "google shopping", "competitor monitoring", "scraping browser".
user-invocable: true
argument-hint: "[command] [url or query]"
license: MIT
compatibility: "Requires Bright Data MCP server"
metadata:
  author: Mubashir Ahmed Siddiqui
  version: "2.2.0"
  category: seo
  original_author: Mubashir Ahmed Siddiqui
---

# Bright Data: Unblockable Scraping & Intelligence (Extension)

Unblockable web scraping that bypasses Cloudflare, Akamai, PerimeterX, and
DataDome. Cloud-hosted Scraping Browser with CAPTCHA solving. Multi-platform
AI visibility (ChatGPT, Grok, Perplexity). Dataset collectors for recurring
competitive monitoring. E-commerce, social media, and business intelligence.

## Prerequisites

Requires the Bright Data extension installed:
```bash
./extensions/brightdata/install.sh
```

**Check availability:** Verify MCP server is connected by checking if
`search_engine` or `scrape_as_markdown` is available. If not, inform
the user and provide install instructions.

## Credit Awareness

- Prefer batch endpoints (`search_engine_batch`, `scrape_batch`) over single calls
- Use `scrape_as_markdown` before `web_data_*` pro tools
- Don't re-fetch data already retrieved in the same session
- Warn user before expensive operations (large batches, dataset collections)
- Base tools: 1 credit/request; Pro tools: 1 credit/record

## Quick Reference

| Command | What it does |
|---------|-------------|
| **Scraping** | |
| `/seo brightdata scrape <url>` | Scrape any page — bypasses Cloudflare, Akamai, DataDome |
| `/seo brightdata scrape-batch <urls>` | Scrape multiple protected pages at once |
| `/seo brightdata extract <url> <fields>` | Extract structured data from any page |
| **Scraping Browser** | |
| `/seo brightdata screenshot <url>` | Browser screenshot with full JS rendering |
| `/seo brightdata snapshot <url>` | DOM snapshot of JS-rendered page |
| **SERP** | |
| `/seo brightdata serp <keyword>` | Google SERP (organic, ads, PAA, local, snippets) |
| `/seo brightdata serp-geo <keyword> <cc>` | Geo-targeted SERP for any country |
| `/seo brightdata serp-batch <keywords>` | Up to 5 SERP queries in one call |
| `/seo brightdata discover <query>` | AI-ranked web search with intent scoring |
| **AI Visibility / GEO** | |
| `/seo brightdata ai-chatgpt <query>` | ChatGPT citations, recommendations & insights |
| `/seo brightdata ai-grok <query>` | Grok analysis with X/Twitter real-time data |
| `/seo brightdata ai-perplexity <query>` | Perplexity answers with full source citations |
| **Dataset Collector** | |
| `/seo brightdata monitor <dataset_id> <inputs>` | Trigger recurring data collection |
| `/seo brightdata discover-new <dataset_id> <keyword>` | Discover new entities via keyword/category |
| **E-commerce** | |
| `/seo brightdata amazon <url>` | Amazon product data (price, BSR, reviews, bullets) |
| `/seo brightdata shopping <keyword>` | Google Shopping listings & pricing |
| `/seo brightdata walmart <url>` | Walmart product data |
| **Social Media** | |
| `/seo brightdata linkedin <url>` | LinkedIn post/profile data |
| `/seo brightdata tiktok <url>` | TikTok content & engagement metrics |
| `/seo brightdata youtube <url>` | YouTube video metadata |
| **Business Intelligence** | |
| `/seo brightdata crunchbase <url>` | Company profiles, funding, team size |
| `/seo brightdata zoominfo <url>` | Revenue, tech stack, company intelligence |
| `/seo brightdata zillow <url>` | Real estate listing data |

---

## Unblockable Scraping

Bright Data's Web Unlocker bypasses Cloudflare, Akamai, PerimeterX, DataDome,
and other anti-bot protections with automatic CAPTCHA solving and fingerprint
rotation.

### `/seo brightdata scrape <url>`

Scrape any webpage into clean markdown. Works on sites that block standard
scrapers and headless browsers.

**MCP tools:** `scrape_as_markdown`

**Output:** Clean markdown with preserved links and code blocks. Main content
extracted (nav/footer stripped).

**SEO use cases:** Competitor content from protected sites, landing page copy
behind Cloudflare, e-commerce product pages, JS-rendered SPAs, content inventory.

### `/seo brightdata scrape-batch <urls>`

Scrape multiple URLs in a single call (up to 5).

**MCP tools:** `scrape_batch`

### `/seo brightdata extract <url> <fields>`

Extract specific structured data from a page using AI-assisted extraction.

**MCP tools:** `extract`

**Parameters:** url (required), fields (what to extract — e.g., "product name,
price, rating, FAQ questions")

**SEO use cases:** Competitor pricing tables, product schema validation, FAQ
content for schema generation, review sentiment data.

---

## Scraping Browser

Cloud-hosted browser with JavaScript execution, CAPTCHA solving, and
Playwright/Puppeteer integration via WebSocket.

### `/seo brightdata screenshot <url>`

Full-page screenshot with JS rendering. Handles CAPTCHAs automatically.

**MCP tools:** `scraping_browser_screenshot`

**SEO use cases:** Visual rendering verification, above-the-fold audit,
competitor landing page analysis, mobile vs desktop comparison.

### `/seo brightdata snapshot <url>`

Capture DOM structure of a JS-rendered page.

**MCP tools:** `scraping_browser_snapshot`

**SEO use cases:** DOM structure analysis, JS rendering verification,
hidden content detection, element visibility audit.

---

## SERP Analysis

### `/seo brightdata serp <keyword>`

Google SERP with full feature data: organic results, paid ads, PAA,
featured snippets, local pack, knowledge panel.

**MCP tools:** `search_engine` (default: engine=google, geo_location=us)

**SEO analysis:** SERP feature inventory, competitor positions, featured
snippet opportunities, PAA for content ideation, paid ad density.

### `/seo brightdata serp-geo <keyword> <country>`

Geo-targeted SERP. Country code: us, uk, de, fr, jp, br, au, etc.

**MCP tools:** `search_engine`

**SEO use cases:** Hreflang validation, local pack presence, country-specific
SERP features, international content strategy.

### `/seo brightdata serp-batch <keywords>`

Up to 5 SERP queries simultaneously.

**MCP tools:** `search_engine_batch` (engine: google|bing|yandex)

**SEO use cases:** Keyword cluster comparison, multi-engine validation,
batch competitor tracking, content gap analysis.

### `/seo brightdata discover <query>`

AI-ranked web search with intent-based relevance scoring.

**MCP tools:** `discover`

**SEO use cases:** Deep topic research, intent-based competitor discovery,
content gap identification, pillar content research.

---

## AI Visibility / GEO

Multi-platform AI visibility tracking across ChatGPT, Grok, and Perplexity.

### `/seo brightdata ai-chatgpt <query>`

ChatGPT insights, citations, and recommendations.

**MCP tools:** `web_data_chatgpt_ai_insights`

**SEO analysis:** Brand citation check, competitor mentions, source analysis,
content gap identification, AI citation earning recommendations.

### `/seo brightdata ai-grok <query>`

Grok analysis powered by real-time X/Twitter data.

**MCP tools:** `web_data_grok_ai_insights`

**SEO use cases:** Brand sentiment on X, trending topic identification,
crisis detection, competitor social perception, newsjacking opportunities.

### `/seo brightdata ai-perplexity <query>`

Perplexity answers with full source citations and follow-up questions.

**MCP tools:** `web_data_perplexity_ai_insights`

**SEO analysis:** Citation source analysis, brand presence check, preferred
content format, competitor citation frequency, content expansion ideas.

**Cross-platform workflow:** Always run all three for GEO analysis. Compare
citations across platforms, identify multi-engine authority signals, flag
brand presence/absence, generate visibility recommendations.

---

## Dataset Collector

Recurring data collection with webhook delivery for ongoing monitoring.

### `/seo brightdata monitor <dataset_id> <inputs>`

Trigger a data collection job.

**API:** `POST /datasets/v3/trigger`

**Parameters:** dataset_id (required), inputs (JSON array), custom_output_fields
(pipe-separated, optional), notify (webhook URL, optional), format (json|ndjson|csv)

**SEO use cases:** Recurring competitor monitoring, scheduled SERP tracking,
content change detection, price monitoring, brand mention collection.

### `/seo brightdata discover-new <dataset_id> <keyword>`

Discover new entities by keyword, category, or location.

**API:** `POST /datasets/v3/trigger` with `type=discover_new`

**Parameters:** dataset_id (required), keyword/category_url/location (required),
discover_by (keyword|category_url|best_sellers_url|location), limit_per_input

**SEO use cases:** New competitor discovery, new product tracking,
geographic listing monitoring, automated competitive intelligence.

---

## E-commerce Intelligence

### `/seo brightdata amazon <url>`

**MCP tools:** `web_data_amazon_product`

**Output:** Title, price, rating, review count, bullet points, description,
images, BSR, seller info, ASIN.

**SEO use cases:** Competitor product analysis, keyword extraction, review
sentiment, price positioning, product schema validation.

### `/seo brightdata shopping <keyword>`

**MCP tools:** `web_data_google_shopping`

**Output:** Product name, price, merchant, rating, URL, image.

**SEO use cases:** Shopping SERP analysis, price comparison, PLA intelligence,
merchant visibility, feed optimization.

### `/seo brightdata walmart <url>`

**MCP tools:** `web_data_walmart_product`

**Output:** Title, price, rating, reviews, availability, seller.

**SEO use cases:** Multi-marketplace price parity, listing optimization
benchmarks, cross-platform positioning.

---

## Social Media Intelligence

### `/seo brightdata linkedin <url>`

**MCP tools:** `web_data_linkedin_posts`

**Output:** Post content, engagement metrics, author info, comments.

**SEO use cases:** B2B content performance, thought leadership tracking,
competitor LinkedIn strategy, social signal analysis.

### `/seo brightdata tiktok <url>`

**MCP tools:** `web_data_tiktok_posts`

**Output:** Title, description, views, likes, comments, shares, hashtags.

**SEO use cases:** Video trend analysis, TikTok hashtag research,
competitor video strategy, social signal monitoring.

### `/seo brightdata youtube <url>`

**MCP tools:** `web_data_youtube_videos`

**Output:** Title, channel, views, likes, description, tags, publish date.

**SEO use cases:** YouTube SEO analysis, video keyword research from tags,
channel strategy analysis, video schema validation.

---

## Business Intelligence

### `/seo brightdata crunchbase <url>`

**MCP tools:** `web_data_crunchbase_company`

**Output:** Company name, description, funding rounds, total funding,
employee count, industry, location.

**SEO use cases:** Competitor funding intel, industry landscape mapping,
entity research for Knowledge Panel optimization.

### `/seo brightdata zoominfo <url>`

**MCP tools:** `web_data_zoominfo_company_profile`

**Output:** Revenue, employee count, industry, tech stack, contact info.

**SEO use cases:** Competitor tech stack detection, industry segmentation,
revenue-based competitor prioritization.

### `/seo brightdata zillow <url>`

**MCP tools:** `web_data_zillow_properties_listing`

**Output:** Property details, price, location, specs, listing agent.

**SEO use cases:** Real estate SEO analysis, local SEO data, property listing
schema validation, market data for content.

---

## Cross-Skill Integration

- **seo-audit**: Scrape protected competitor sites, real SERP, multi-AI GEO
- **seo-technical**: Test anti-bot pages, visual verification via screenshots
- **seo-content**: Competitor content extraction, structured data extraction
- **seo-geo**: ChatGPT + Grok + Perplexity visibility tracking
- **seo-ecommerce**: Amazon, Google Shopping, Walmart marketplace data
- **seo-local**: Geo-targeted SERP, real estate data via Zillow
- **seo-plan**: Crunchbase/ZoomInfo competitor intelligence
- **seo-drift**: Dataset collector for recurring change monitoring

## Error Handling

| Error | Cause | Resolution |
|-------|-------|-----------|
| Tool not available | MCP not connected | Run install script, check PRO_MODE |
| 401 Unauthorized | Invalid token | Check API_TOKEN in settings.json |
| 402 Payment Required | Credits exhausted | Add credits at brightdata.com/cp |
| 429 Rate Limited | Rate limit hit | Wait and retry, reduce batch size |
| 403 Forbidden | Zone not authorized | Check WEB_UNLOCKER_ZONE settings |
| Timeout | Page too slow | Try scrape_as_markdown |

**Fallback:** If unavailable, suggest `fetch_page.py` (free), `WebFetch`, or
install Bright Data: `./extensions/brightdata/install.sh`

## Output Formatting

- Tables for comparative data, priority: Critical > High > Medium > Low
- Scores as XX/100, actionable recommendations
- Note source as "Bright Data (live)" to distinguish from static analysis
- Include geo_location when showing SERP data
