[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$nvimSource = Join-Path $env:LOCALAPPDATA 'nvim'
$weztermSource = Join-Path $env:USERPROFILE '.wezterm.lua'
$nvimTarget = Join-Path $repoRoot 'nvim'
$weztermTarget = Join-Path $repoRoot 'wezterm\.wezterm.lua'

if (-not (Test-Path -LiteralPath $nvimSource)) {
    throw "Neovim config not found: $nvimSource"
}

if (-not (Test-Path -LiteralPath $weztermSource)) {
    throw "WezTerm config not found: $weztermSource"
}

New-Item -ItemType Directory -Force -Path $nvimTarget | Out-Null
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $weztermTarget) | Out-Null

Copy-Item -LiteralPath (Join-Path $nvimSource 'init.lua') -Destination (Join-Path $nvimTarget 'init.lua') -Force
Copy-Item -LiteralPath (Join-Path $nvimSource 'lazy-lock.json') -Destination (Join-Path $nvimTarget 'lazy-lock.json') -Force
Copy-Item -LiteralPath $weztermSource -Destination $weztermTarget -Force

git -C $repoRoot status --short

