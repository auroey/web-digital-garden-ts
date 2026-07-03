param(
  [string]$RepoPath = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path,
  [string]$Branch = "main",
  [string]$Remote = "origin",
  [switch]$Build
)

$ErrorActionPreference = "Stop"

function Write-Log {
  param([string]$Message)
  $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  Write-Host "[$timestamp] $Message"
}

Set-Location -LiteralPath $RepoPath

$contentPath = Join-Path $RepoPath "content"
if (-not (Test-Path -LiteralPath $contentPath)) {
  throw "Content folder not found: $contentPath"
}

Write-Log "Checking content changes..."

$trackedChanges = git status --porcelain -- content
if ([string]::IsNullOrWhiteSpace($trackedChanges)) {
  Write-Log "No content changes found."
  exit 0
}

Write-Log "Content changes detected."
git add content

if ($Build) {
  if (-not (Test-Path -LiteralPath (Join-Path $RepoPath "node_modules"))) {
    Write-Log "Installing dependencies..."
    npm ci
  }

  Write-Log "Building Quartz site..."
  node quartz\bootstrap-cli.mjs build
} else {
  Write-Log "Skipping local build. GitHub Actions will build after push."
}

$changedFiles = git diff --cached --name-only
if ([string]::IsNullOrWhiteSpace($changedFiles)) {
  Write-Log "No staged changes to commit."
  exit 0
}

$commitMessage = "Sync Obsidian notes: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m $commitMessage
Write-Log "Committed: $commitMessage"

Write-Log "Pulling latest changes..."
git pull $Remote $Branch --rebase

Write-Log "Pushing to GitHub..."
git push $Remote $Branch

Write-Log "Done. GitHub Pages will rebuild from the pushed commit."
