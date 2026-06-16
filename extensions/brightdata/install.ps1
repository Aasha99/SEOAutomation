# Bright Data Extension Installer for Claude SEO (Windows)
$ErrorActionPreference = 'Stop'

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "  Bright Data Extension - Installer" -ForegroundColor Cyan
Write-Host "  For Claude SEO" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

$SkillDir = "$env:USERPROFILE\.claude\skills\seo-brightdata"
$AgentDir = "$env:USERPROFILE\.claude\agents"
$SeoSkillDir = "$env:USERPROFILE\.claude\skills\seo"
$SettingsFile = "$env:USERPROFILE\.claude\settings.json"

# Check prerequisites
if (-not (Test-Path $SeoSkillDir)) {
    Write-Host "x Claude SEO is not installed." -ForegroundColor Red
    Write-Host "  Install it first: irm https://raw.githubusercontent.com/AgriciDaniel/claude-seo/main/install.ps1 | iex"
    exit 1
}
Write-Host "v Claude SEO detected" -ForegroundColor Green

$nodeVersion = (node -v 2>$null) -replace 'v',''
if (-not $nodeVersion) {
    Write-Host "x Node.js is required but not installed." -ForegroundColor Red
    exit 1
}
$major = [int]($nodeVersion -split '\.')[0]
if ($major -lt 20) {
    Write-Host "x Node.js 20+ required (found v$nodeVersion)." -ForegroundColor Red
    exit 1
}
Write-Host "v Node.js v$nodeVersion detected" -ForegroundColor Green

# Prompt for API token
Write-Host ""
Write-Host "Bright Data API token required." -ForegroundColor Yellow
Write-Host "Sign up at: https://brightdata.com/cp"
Write-Host ""
Write-Host "To find your API token:"
Write-Host "  1. Log in to brightdata.com"
Write-Host "  2. Go to Settings -> API"
Write-Host "  3. Copy your API token"
Write-Host ""

$apiKey = Read-Host "Bright Data API token" -AsSecureString
$apiKeyPlain = [Runtime.InteropServices.Marshal]::PtrToStringBSTR(
    [Runtime.InteropServices.Marshal]::SecureStringToBSTR($apiKey))
if ([string]::IsNullOrWhiteSpace($apiKeyPlain)) {
    Write-Host "x API token cannot be empty." -ForegroundColor Red
    exit 1
}

# Ask about Pro mode
Write-Host ""
Write-Host "Enable Pro mode? (60+ tools: e-commerce, social media, AI insights, etc.)" -ForegroundColor Yellow
Write-Host "Pro mode tools cost 1 credit per record returned."
$proModeInput = Read-Host "Enable Pro mode? [Y/n]"
$proMode = if ($proModeInput -match '^[Nn]') { "false" } else { "true" }
if ($proMode -eq "true") {
    Write-Host "  -> Pro mode enabled (all 60+ tools)" -ForegroundColor Green
} else {
    Write-Host "  -> Pro mode disabled (base tools only)" -ForegroundColor Yellow
}

# Determine source directory
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SourceDir = $null
if (Test-Path "$ScriptDir\skills\seo-brightdata\SKILL.md") {
    $SourceDir = $ScriptDir
} elseif (Test-Path "$ScriptDir\extensions\brightdata\skills\seo-brightdata\SKILL.md") {
    $SourceDir = "$ScriptDir\extensions\brightdata"
} else {
    Write-Host "x Cannot find extension source files." -ForegroundColor Red
    exit 1
}

# Install skill
Write-Host ""
Write-Host "=> Installing Bright Data skill..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path $SkillDir | Out-Null
Copy-Item "$SourceDir\skills\seo-brightdata\SKILL.md" "$SkillDir\SKILL.md" -Force

# Install agent
Write-Host "=> Installing Bright Data agent..." -ForegroundColor Yellow
New-Item -ItemType Directory -Force -Path $AgentDir | Out-Null
Copy-Item "$SourceDir\agents\seo-brightdata.md" "$AgentDir\seo-brightdata.md" -Force

# Configure MCP server
Write-Host "=> Configuring MCP server..." -ForegroundColor Yellow
$settingsContent = if (Test-Path $SettingsFile) { Get-Content $SettingsFile -Raw | ConvertFrom-Json } else { @{} }
if (-not $settingsContent.mcpServers) { $settingsContent | Add-Member -NotePropertyName mcpServers -NotePropertyValue @{} -Force }

$envVars = @{ API_TOKEN = $apiKeyPlain }
if ($proMode -eq "true") { $envVars['PRO_MODE'] = "true" }

$settingsContent.mcpServers | Add-Member -NotePropertyName 'brightdata' -NotePropertyValue @{
    command = 'npx'
    args = @('-y', '@brightdata/mcp')
    env = $envVars
} -Force
$settingsContent | ConvertTo-Json -Depth 10 | Set-Content $SettingsFile -Encoding UTF8
# Restrict the credential-bearing settings file to the current user only.
try {
    icacls $SettingsFile /inheritance:r /grant:r "${env:USERNAME}:F" | Out-Null
} catch {
    Write-Host "  Note: could not restrict settings.json ACL; review manually." -ForegroundColor Yellow
}
Write-Host "  v MCP server configured" -ForegroundColor Green

# Pre-warm
Write-Host "=> Pre-downloading @brightdata/mcp..." -ForegroundColor Yellow
npx -y @brightdata/mcp --help 2>$null | Out-Null

Write-Host ""
Write-Host "v Bright Data extension installed!" -ForegroundColor Green
Write-Host ""
Write-Host "Usage:"
Write-Host "  /seo brightdata serp best coffee shops"
Write-Host "  /seo brightdata scrape https://competitor.com"
Write-Host "  /seo brightdata ai-chatgpt your brand name"
Write-Host "  /seo brightdata amazon https://amazon.com/dp/B09V3KXJPB"
