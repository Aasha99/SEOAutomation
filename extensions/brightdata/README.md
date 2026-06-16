# Bright Data Extension for Claude SEO

Unblockable web scraping, cloud-hosted Scraping Browser, multi-platform AI
visibility (ChatGPT, Grok, Perplexity), dataset collectors for recurring
monitoring, e-commerce data, social media intelligence, and business data
powered by [Bright Data](https://brightdata.com/).

## Prerequisites

- [Claude SEO](https://github.com/AgriciDaniel/claude-seo) installed
- Node.js 20+
- Bright Data account ([sign up](https://brightdata.com)) with API token

## Installation

### macOS / Linux

```bash
./extensions/brightdata/install.sh
```

### Windows (PowerShell)

```powershell
.\extensions\brightdata\install.ps1
```

The installer will prompt for your API token, ask about Pro mode, and
configure the MCP server automatically.

## Commands

### Unblockable Scraping

| Command | Description |
|---------|-------------|
| `/seo brightdata scrape <url>` | Scrape any page — bypasses Cloudflare, Akamai, DataDome |
| `/seo brightdata scrape-batch <urls>` | Scrape multiple protected pages at once |
| `/seo brightdata extract <url> <fields>` | Extract structured data from any page |

### Scraping Browser

| Command | Description |
|---------|-------------|
| `/seo brightdata screenshot <url>` | Browser screenshot with full JS rendering & CAPTCHA solving |
| `/seo brightdata snapshot <url>` | DOM snapshot of JS-rendered page |

### SERP Analysis

| Command | Description |
|---------|-------------|
| `/seo brightdata serp <keyword>` | Google SERP (organic, ads, PAA, local, snippets) |
| `/seo brightdata serp-geo <keyword> <cc>` | Geo-targeted SERP for any country |
| `/seo brightdata serp-batch <keywords>` | Up to 5 SERP queries in one call |
| `/seo brightdata discover <query>` | AI-ranked web search with intent scoring |

### AI Visibility / GEO

| Command | Description |
|---------|-------------|
| `/seo brightdata ai-chatgpt <query>` | ChatGPT citations, recommendations & insights |
| `/seo brightdata ai-grok <query>` | Grok analysis with X/Twitter real-time data |
| `/seo brightdata ai-perplexity <query>` | Perplexity answers with full source citations |

### Dataset Collector

| Command | Description |
|---------|-------------|
| `/seo brightdata monitor <dataset_id> <inputs>` | Trigger recurring data collection |
| `/seo brightdata discover-new <dataset_id> <keyword>` | Discover new entities via keyword/category |

### E-commerce

| Command | Description |
|---------|-------------|
| `/seo brightdata amazon <url>` | Amazon product data (price, BSR, reviews, bullets) |
| `/seo brightdata shopping <keyword>` | Google Shopping listings & pricing |
| `/seo brightdata walmart <url>` | Walmart product data |

### Social Media

| Command | Description |
|---------|-------------|
| `/seo brightdata linkedin <url>` | LinkedIn post/profile data |
| `/seo brightdata tiktok <url>` | TikTok content & engagement metrics |
| `/seo brightdata youtube <url>` | YouTube video metadata |

### Business Intelligence

| Command | Description |
|---------|-------------|
| `/seo brightdata crunchbase <url>` | Company profiles, funding, team size |
| `/seo brightdata zoominfo <url>` | Revenue, tech stack, company intelligence |
| `/seo brightdata zillow <url>` | Real estate listing data |

## What Makes This Extension Unique

### Unblockable Scraping

Bright Data's Web Unlocker bypasses Cloudflare, Akamai, PerimeterX,
DataDome, and other anti-bot protections. Automatic CAPTCHA solving,
fingerprint rotation, and header customization. Pages that block standard
scrapers and headless browsers work here.

### Cloud Scraping Browser

Full cloud-hosted Playwright/Puppeteer browser with:
- Automatic CAPTCHA solving via CDP commands
- Fingerprint rotation per session
- WebSocket connection for multi-step workflows
- Screenshot and DOM snapshot capabilities

### Multi-Platform AI Visibility

Track brand visibility across all three major AI search engines:
- **ChatGPT**: Citations, recommendations, insights
- **Grok**: Real-time X/Twitter-powered analysis
- **Perplexity**: Citation-heavy answers with sources

### Dataset Collector

Set up recurring data collection jobs with:
- Webhook delivery for real-time data
- Discovery pipelines that find new competitors/products
- Custom output fields to get only the data you need
- Scheduled collections for ongoing monitoring

## Tool Modes

### Rapid Mode (Default)

5 base tools available on free tier:
- `search_engine` / `search_engine_batch` — SERP data
- `scrape_as_markdown` / `scrape_batch` — unblockable page scraping
- `discover` — AI-ranked search

### Pro Mode (Paid)

60+ tools including all `web_data_*` endpoints for e-commerce, social media,
AI visibility, business intelligence, browser automation, and dataset collectors.

Enable during install or set `PRO_MODE=true` in settings.json.

## Integration with Claude SEO

When installed, other Claude SEO skills automatically leverage Bright Data:

- **`/seo audit`**: Scrapes protected competitor sites, real SERP data, multi-AI GEO
- **`/seo technical`**: Tests anti-bot protected pages, visual verification
- **`/seo content`**: Competitor content extraction from protected sites
- **`/seo geo`**: ChatGPT + Grok + Perplexity visibility tracking
- **`/seo ecommerce`**: Amazon, Google Shopping, Walmart marketplace data
- **`/seo local`**: Geo-targeted SERP, real estate data
- **`/seo plan`**: Crunchbase/ZoomInfo competitor intelligence
- **`/seo drift`**: Dataset collector for recurring change monitoring

## Cost

| Tool Type | Cost |
|-----------|------|
| Base tools (rapid mode) | 1 credit per request |
| Pro tools (web_data_*) | 1 credit per record |

See [Bright Data pricing](https://brightdata.com/pricing) for current rates.

## Troubleshooting

### MCP not connecting?

```bash
cat ~/.claude/settings.json | python3 -m json.tool | grep brightdata
```

Manual config: See [BRIGHTDATA-SETUP.md](docs/BRIGHTDATA-SETUP.md)

### API errors

- **401 Unauthorized**: Check API_TOKEN in settings.json
- **402 Payment Required**: Add credits at brightdata.com/cp
- **429 Rate Limited**: Wait and retry, reduce batch size

### Pro mode tools not available?

Check that `PRO_MODE=true` is set in your settings.json env vars.

## Uninstall

```bash
./extensions/brightdata/uninstall.sh      # macOS/Linux
.\extensions\brightdata\uninstall.ps1     # Windows
```

## Links

- [Bright Data MCP Server](https://github.com/luminati-io/brightdata-mcp)
- [Bright Data Documentation](https://docs.brightdata.com/)
- [Claude SEO](https://github.com/AgriciDaniel/claude-seo)
