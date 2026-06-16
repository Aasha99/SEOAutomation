# Bright Data Extension Uninstaller for Claude SEO (Windows)
$ErrorActionPreference = 'Stop'

Write-Host "Removing Bright Data extension..." -ForegroundColor Yellow

$SkillDir = "$env:USERPROFILE\.claude\skills\seo-brightdata"
$AgentFile = "$env:USERPROFILE\.claude\agents\seo-brightdata.md"
$SettingsFile = "$env:USERPROFILE\.claude\settings.json"

if (Test-Path $SkillDir) {
    Remove-Item -Recurse -Force $SkillDir
    Write-Host "v Removed skill files" -ForegroundColor Green
}

if (Test-Path $AgentFile) {
    Remove-Item -Force $AgentFile
    Write-Host "v Removed agent file" -ForegroundColor Green
}

if (Test-Path $SettingsFile) {
    $settings = Get-Content $SettingsFile -Raw | ConvertFrom-Json
    if ($settings.mcpServers.'brightdata') {
        $settings.mcpServers.PSObject.Properties.Remove('brightdata')
        $settings | ConvertTo-Json -Depth 10 | Set-Content $SettingsFile -Encoding UTF8
        Write-Host "v Removed MCP server from settings.json" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "v Bright Data extension uninstalled." -ForegroundColor Green
Write-Host "  Core Claude SEO skills are unchanged."
