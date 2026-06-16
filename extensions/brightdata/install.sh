#!/usr/bin/env bash
set -euo pipefail

# Bright Data Extension Installer for Claude SEO
# Wraps everything in main() to prevent partial execution on network failure

main() {
    SKILL_DIR="${HOME}/.claude/skills/seo-brightdata"
    AGENT_DIR="${HOME}/.claude/agents"
    SEO_SKILL_DIR="${HOME}/.claude/skills/seo"
    SETTINGS_FILE="${HOME}/.claude/settings.json"

    echo "════════════════════════════════════════"
    echo "║   Bright Data Extension - Installer  ║"
    echo "║   For Claude SEO                     ║"
    echo "════════════════════════════════════════"
    echo ""

    # Support both traditional (curl|bash -> ~/.claude/skills/seo) and marketplace
    # (plugin install -> ~/.claude/plugins/cache/.../skills/seo) installations.
    _EARLY_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    _PLUGIN_SEO_DIR="$(cd "${_EARLY_SCRIPT_DIR}/../.." 2>/dev/null && pwd)/skills/seo"
    if [ ! -d "${SEO_SKILL_DIR}" ] && [ -d "${_PLUGIN_SEO_DIR}" ]; then
        SEO_SKILL_DIR="${_PLUGIN_SEO_DIR}"
    fi
    if [ ! -d "${SEO_SKILL_DIR}" ]; then
        _GLOB_MATCH=$(ls -d "${HOME}/.claude/plugins/cache/*/claude-seo/"*/skills/seo 2>/dev/null | tail -n1 || true)
        [ -n "${_GLOB_MATCH}" ] && [ -d "${_GLOB_MATCH}" ] && SEO_SKILL_DIR="${_GLOB_MATCH}"
    fi

    # Check prerequisites
    if [ ! -d "${SEO_SKILL_DIR}" ]; then
        echo "✗ Claude SEO is not installed."
        echo "  Install it first: curl -fsSL https://raw.githubusercontent.com/AgriciDaniel/claude-seo/main/install.sh | bash"
        exit 1
    fi
    echo "✓ Claude SEO detected"

    if ! command -v node >/dev/null 2>&1; then
        echo "✗ Node.js is required but not installed."
        echo "  Install Node.js 20+: https://nodejs.org/"
        exit 1
    fi

    NODE_VERSION=$(node -v | sed 's/v//' | cut -d. -f1)
    if [ "${NODE_VERSION}" -lt 20 ]; then
        echo "✗ Node.js 20+ required (found v${NODE_VERSION})."
        echo "  Update: https://nodejs.org/"
        exit 1
    fi
    echo "✓ Node.js v$(node -v | sed 's/v//') detected"

    if ! command -v npx >/dev/null 2>&1; then
        echo "✗ npx is required but not found (comes with npm)."
        exit 1
    fi
    echo "✓ npx detected"

    # Prompt for credentials
    echo ""
    echo "Bright Data API token required."
    echo "Sign up at: https://brightdata.com/cp"
    echo ""
    echo "To find your API token:"
    echo "  1. Log in to brightdata.com"
    echo "  2. Go to Settings -> API"
    echo "  3. Copy your API token"
    echo ""

    read -rsp "Bright Data API token: " BD_API_TOKEN
    echo ""
    if [ -z "${BD_API_TOKEN}" ]; then
        echo "✗ API token cannot be empty."
        exit 1
    fi

    # Ask about Pro mode
    echo ""
    echo "Enable Pro mode? (60+ tools: e-commerce, social media, AI insights, etc.)"
    echo "Pro mode tools cost 1 credit per record returned."
    echo ""
    read -rp "Enable Pro mode? [Y/n]: " PRO_MODE_INPUT
    if [[ "${PRO_MODE_INPUT}" =~ ^[Nn] ]]; then
        PRO_MODE="false"
        echo "  → Pro mode disabled (only base tools: search_engine, scrape, discover)"
    else
        PRO_MODE="true"
        echo "  → Pro mode enabled (all 60+ tools)"
    fi

    # Determine script directory (works for both ./install.sh and curl|bash)
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    # Check if running from repo or standalone
    if [ -f "${SCRIPT_DIR}/skills/seo-brightdata/SKILL.md" ]; then
        SOURCE_DIR="${SCRIPT_DIR}"
    elif [ -f "${SCRIPT_DIR}/extensions/brightdata/skills/seo-brightdata/SKILL.md" ]; then
        SOURCE_DIR="${SCRIPT_DIR}/extensions/brightdata"
    else
        echo "✗ Cannot find extension source files."
        echo "  Run this script from the claude-seo repo: ./extensions/brightdata/install.sh"
        exit 1
    fi

    # Install skill
    echo ""
    echo "→ Installing Bright Data skill..."
    mkdir -p "${SKILL_DIR}"
    cp "${SOURCE_DIR}/skills/seo-brightdata/SKILL.md" "${SKILL_DIR}/SKILL.md"

    # Install agent
    echo "→ Installing Bright Data agent..."
    mkdir -p "${AGENT_DIR}"
    cp "${SOURCE_DIR}/agents/seo-brightdata.md" "${AGENT_DIR}/seo-brightdata.md"

    # Merge MCP config into settings.json
    echo "→ Configuring MCP server..."

    # Credentials are passed as argv (never interpolated into the source string)
    # and the settings file is written atomically with 0600 permissions.
    python3 - "${SETTINGS_FILE}" "${BD_API_TOKEN}" "${PRO_MODE}" <<'PY'
import json, os, sys, tempfile

settings_path, api_token, pro_mode = sys.argv[1:4]

if os.path.exists(settings_path):
    try:
        with open(settings_path) as f:
            settings = json.load(f)
    except json.JSONDecodeError:
        settings = {}
else:
    settings = {}

env_vars = {
    'API_TOKEN': api_token,
}

if pro_mode == 'true':
    env_vars['PRO_MODE'] = 'true'

settings.setdefault('mcpServers', {})['brightdata'] = {
    'command': 'npx',
    'args': ['-y', '@brightdata/mcp'],
    'env': env_vars,
}

os.makedirs(os.path.dirname(settings_path) or '.', exist_ok=True)
fd, tmp = tempfile.mkstemp(dir=os.path.dirname(settings_path) or '.', prefix='.settings.', suffix='.json')
try:
    with os.fdopen(fd, 'w') as f:
        json.dump(settings, f, indent=2)
    os.chmod(tmp, 0o600)
    os.replace(tmp, settings_path)
except Exception:
    if os.path.exists(tmp):
        os.unlink(tmp)
    raise

print('  ✓ MCP server configured in settings.json')
PY
    if [ $? -ne 0 ]; then
        echo "  ⚠  Could not auto-configure MCP server."
        echo "  Add the brightdata server manually to ~/.claude/settings.json"
        echo "  See: extensions/brightdata/docs/BRIGHTDATA-SETUP.md"
    fi

    # Pre-warm npm package without starting the MCP server binary.
    echo "→ Pre-downloading @brightdata/mcp..."
    npx --yes --package=@brightdata/mcp -- node -e "" >/dev/null 2>&1 || true

    echo ""
    echo "✓ Bright Data extension installed successfully!"
    echo ""
    echo "Usage:"
    echo "  1. Start Claude Code:  claude"
    echo "  2. Run commands:"
    echo "     /seo brightdata serp best coffee shops"
    echo "     /seo brightdata scrape https://competitor.com"
    echo "     /seo brightdata ai-chatgpt your brand name"
    echo "     /seo brightdata amazon https://amazon.com/dp/B09V3KXJPB"
    echo ""
    if [ "${PRO_MODE}" = "true" ]; then
        echo "Pro mode: ENABLED (60+ tools available)"
    else
        echo "Pro mode: DISABLED (base tools only)"
        echo "  To enable later, set PRO_MODE=true in ~/.claude/settings.json"
    fi
    echo ""
    echo "Documentation: extensions/brightdata/README.md"
    echo "To uninstall: ./extensions/brightdata/uninstall.sh"
}

main "$@"
