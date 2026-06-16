# Bright Data Setup Guide

## 1. Create Account & Get API Token

1. Go to [brightdata.com](https://brightdata.com) and sign up
2. Log in to the dashboard
3. Navigate to **Settings -> API**
4. Copy your **API token**

Bright Data offers pay-as-you-go pricing. Base tools (search_engine,
scrape_as_markdown, discover) are available in rapid mode (free tier).
Pro mode tools (60+ tools) require a paid plan.

## 2. Run the Installer

The installer handles everything automatically:

```bash
./extensions/brightdata/install.sh
```

It will:
1. Prompt for your API token
2. Ask if you want to enable Pro mode (60+ tools)
3. Install skill and agent files
4. Configure the MCP server in `~/.claude/settings.json`
5. Pre-download the `@brightdata/mcp` npm package

## 3. Manual MCP Configuration

If the installer fails, add this to `~/.claude/settings.json` manually:

**Basic (rapid mode only):**

```json
{
  "mcpServers": {
    "brightdata": {
      "command": "npx",
      "args": ["-y", "@brightdata/mcp"],
      "env": {
        "API_TOKEN": "your-api-token-here"
      }
    }
  }
}
```

**With Pro mode (all 60+ tools):**

```json
{
  "mcpServers": {
    "brightdata": {
      "command": "npx",
      "args": ["-y", "@brightdata/mcp"],
      "env": {
        "API_TOKEN": "your-api-token-here",
        "PRO_MODE": "true"
      }
    }
  }
}
```

**Advanced (custom zones and rate limiting):**

```json
{
  "mcpServers": {
    "brightdata": {
      "command": "npx",
      "args": ["-y", "@brightdata/mcp"],
      "env": {
        "API_TOKEN": "your-api-token-here",
        "PRO_MODE": "true",
        "RATE_LIMIT": "100/1h",
        "WEB_UNLOCKER_ZONE": "custom",
        "BROWSER_ZONE": "custom_browser"
      }
    }
  }
}
```

## 4. Verify Installation

Start Claude Code and try:

```
/seo brightdata serp coffee shops near me
```

You should see search results. If you get a "tool not available" error,
restart Claude Code to reload MCP servers.

## 5. Understanding Tools & Credits

### Rapid Mode (Free)

| Tool | Description | Cost |
|------|-------------|------|
| `search_engine` | Web search | 1 credit/request |
| `search_engine_batch` | Batch search (up to 5) | 1 credit/request |
| `scrape_as_markdown` | Scrape any page | 1 credit/request |
| `scrape_batch` | Batch scrape | 1 credit/request |
| `discover` | AI-ranked search | 1 credit/request |

### Pro Mode (Paid)

| Tool Category | Examples | Cost |
|--------------|---------|------|
| AI Visibility | ChatGPT, Grok, Perplexity insights | 1 credit/record |
| E-commerce | Amazon, Google Shopping, Walmart | 1 credit/record |
| Social Media | LinkedIn, TikTok, YouTube | 1 credit/record |
| Business Intel | Crunchbase, ZoomInfo | 1 credit/record |
| Real Estate | Zillow listings | 1 credit/record |
| Browser | Screenshots, DOM snapshots | 1 credit/request |

## 6. Tool Groups (Pro Mode)

Pro mode can be configured with specific tool groups:

| Group | Tools |
|-------|-------|
| `ecommerce` | Amazon, Walmart, Google Shopping |
| `social` | LinkedIn, TikTok, YouTube |
| `finance` | Yahoo Finance |
| `business` | Crunchbase, ZoomInfo, Zillow |
| `research` | GitHub, Reuters |
| `app_stores` | Google Play, Apple App Store |
| `travel` | Booking.com |
| `geo` | ChatGPT, Grok, Perplexity AI insights |
| `code` | npm, PyPI |
| `browser` | Screenshot, snapshot, click |

To enable only specific groups, set the `TOOLS` environment variable:

```json
{
  "env": {
    "API_TOKEN": "your-token",
    "PRO_MODE": "true",
    "TOOLS": "ecommerce,social,geo"
  }
}
```
