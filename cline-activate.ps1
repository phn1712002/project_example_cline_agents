# Get the root directory of the project (where this activate.ps1 script is located)
$ProjectRoot = if ($PSScriptRoot) { $PSScriptRoot } else { (Get-Location).Path }

$ProjectClineDataDir = Join-Path $ProjectRoot ".cline_data"
$ProjectClineDir = Join-Path $ProjectRoot ".cline"
$ProjectMcpDir   = Join-Path $ProjectRoot ".mcp"
$McpSettingsPath = Join-Path $ProjectMcpDir "mcp_settings.json"

# Configure environment variables: Global data, project-specific config & MCP settings
$env:CLINE_DATA_DIR          = $ProjectClineDataDir
$env:CLINE_DIR               = $ProjectClineDir
$env:CLINE_MCP_SETTINGS_PATH = $McpSettingsPath

# Create required directories and default MCP config file if they do not exist
if (-not (Test-Path -LiteralPath $ProjectClineDir)) {
    New-Item -ItemType Directory -Path $ProjectClineDir -Force | Out-Null
}

if (-not (Test-Path -LiteralPath $ProjectMcpDir)) {
    New-Item -ItemType Directory -Path $ProjectMcpDir -Force | Out-Null
}

if (-not (Test-Path -LiteralPath $McpSettingsPath)) {
    $encoding = if ($PSVersionTable.PSVersion.Major -ge 6) { 'utf8NoBOM' } else { 'UTF8' }
    @"
{
  "mcpServers": {
  }
}
"@ | Set-Content -LiteralPath $McpSettingsPath -Encoding $encoding
}

clear
Write-Host "Cline environment activated for project: $env:CLINE_DIR" -ForegroundColor Green