# Update N8n Version Script
# Author: Claude AI
# Purpose: Get latest version from GitHub tags and update .env file

param(
    [string]$EnvFile = ".env",
    [switch]$Force
)

# Set error handling
$ErrorActionPreference = "Stop"

Write-Host "Starting N8n version update..." -ForegroundColor Green

# GitHub repository info
$Repository = "msola-ht/n8n-i18n-chinese-docker"
$ApiUrl = "https://api.github.com/repos/$Repository/tags"

try {
    # Get latest tags
    Write-Host "Fetching latest version information..." -ForegroundColor Yellow
    $response = Invoke-RestMethod -Uri $ApiUrl -Headers @{
        "User-Agent" = "PowerShell-Script"
        "Accept" = "application/vnd.github.v3+json"
    } -TimeoutSec 30

    if ($response.Count -eq 0) {
        throw "No version tags found"
    }

    # Get latest version and clean it (remove "n8n@" prefix)
    $rawVersion = $response[0].name
    $latestVersion = $rawVersion -replace '^n8n@', ''
    Write-Host "Latest version: $latestVersion" -ForegroundColor Green

    # Check if .env file exists
    if (-not (Test-Path $EnvFile)) {
        Write-Host ".env file not found, creating..." -ForegroundColor Yellow

        # Create default .env content
        $defaultContent = @"
# N8n Chinese Docker Configuration
# Auto generated on $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')

# N8n version
N8N_VERSION=$latestVersion

# Docker image repository
IMAGE_REPOSITORY=lunare/n8n-chinese

# Web port
WEB_PORT=5678

# Data directory
DATA_DIR=./data

# Input/Output directories
INPUT_DIR=./input
OUTPUT_DIR=./output

# Chinese environment settings
N8N_DEFAULT_LOCALE=zh-CN
GENERIC_TIMEZONE=Asia/Shanghai

# Other settings
N8N_BASIC_AUTH_ACTIVE=false
N8N_BASIC_AUTH_USER=
N8N_BASIC_AUTH_PASSWORD=
"@

        $defaultContent | Out-File -FilePath $EnvFile -Encoding UTF8
        Write-Host "Created .env file with version: $latestVersion" -ForegroundColor Green
    } else {
        # Read existing .env file
        $envContent = Get-Content -Path $EnvFile -Encoding UTF8
        $currentVersion = ""
        $newContent = @()
        $versionUpdated = $false

        # Parse and update version
        $foundVersionLine = $false
        foreach ($line in $envContent) {
            if ($line -match '^N8N_VERSION\s*=\s*(.+)$') {
                $foundVersionLine = $true
                $currentVersion = $matches[1].Trim()

                if ($currentVersion -ne $latestVersion -or $Force) {
                    $newContent += "N8N_VERSION=$latestVersion"
                    $versionUpdated = $true
                    Write-Host "Version update: $currentVersion -> $latestVersion" -ForegroundColor Yellow
                } else {
                    $newContent += $line
                    Write-Host "Current version is already latest: $currentVersion" -ForegroundColor Cyan
                }
            } else {
                $newContent += $line
            }
        }

        # Add N8N_VERSION only if no version line was found at all
        if (-not $foundVersionLine) {
            $newContent += "`nN8N_VERSION=$latestVersion"
            $versionUpdated = $true
            Write-Host "Added version: $latestVersion" -ForegroundColor Green
        }

        # Write file only if version actually changed
        if ($versionUpdated) {
            $newContent | Out-File -FilePath $EnvFile -Encoding UTF8
            Write-Host ".env file updated with version: $latestVersion" -ForegroundColor Green
        }
    }

    # Display current configuration
    Write-Host "`nCurrent configuration:" -ForegroundColor Cyan
    Write-Host "   Repository: $Repository" -ForegroundColor White
    Write-Host "   Latest version: $latestVersion" -ForegroundColor White
    Write-Host "   Config file: $EnvFile" -ForegroundColor White

    # Read and display N8N_VERSION
    if (Test-Path $EnvFile) {
        $envContent = Get-Content -Path $EnvFile -Encoding UTF8
        $versionLine = $envContent | Where-Object { $_ -match '^N8N_VERSION\s*=' }
        if ($versionLine) {
            Write-Host "   Current configured version: $($versionLine.Trim())" -ForegroundColor White
        }
    }

    Write-Host "`nVersion update completed!" -ForegroundColor Green

} catch {
    Write-Host "Update failed: $($_.Exception.Message)" -ForegroundColor Red

    # Provide troubleshooting tips
    Write-Host "`nTroubleshooting tips:" -ForegroundColor Yellow
    Write-Host "   1. Check network connection" -ForegroundColor White
    Write-Host "   2. Verify GitHub repository name: $Repository" -ForegroundColor White
    Write-Host "   3. Check API access permissions" -ForegroundColor White
    Write-Host "   4. Try again later" -ForegroundColor White

    exit 1
}

# Usage tips
Write-Host "`nUsage tips:" -ForegroundColor Cyan
Write-Host "   Run script: .\Update-N8nVersion-Simple.ps1" -ForegroundColor White
Write-Host "   Force update: .\Update-N8nVersion-Simple.ps1 -Force" -ForegroundColor White
Write-Host "   Specify config file: .\Update-N8nVersion-Simple.ps1 -EnvFile '.env.production'" -ForegroundColor White