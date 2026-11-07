<#
.SYNOPSIS  Windows (PowerShell) installer for the terminal + AI-agent environment.
.USAGE     .\install.ps1 [all|packages|tools|link|engram]
           Run in PowerShell 7 (pwsh). No admin needed (winget user scope).
#>
param([ValidateSet('all','packages','tools','link','engram')][string]$Step = 'all')
$ErrorActionPreference = 'Continue'
$Root = $PSScriptRoot
. "$Root\packages.ps1"
$Missing = New-Object System.Collections.Generic.List[string]
function Say($m) { Write-Host "==> $m" -ForegroundColor Cyan }
function Has($c) { [bool](Get-Command $c -ErrorAction SilentlyContinue) }

function Winget-Install($id) {
  winget install --id $id -e --source winget --silent --accept-package-agreements --accept-source-agreements 2>&1 | Out-Host
  if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne -1978335189) { $Missing.Add("winget:$id") }  # -1978335189 = already installed / no upgrade
}

function Refresh-Path { $env:Path = [Environment]::GetEnvironmentVariable('Path','Machine') + ';' + [Environment]::GetEnvironmentVariable('Path','User') }
function Add-UserPath($dir) {
  $u = [Environment]::GetEnvironmentVariable('Path','User')
  if (($u -split ';') -notcontains $dir) { [Environment]::SetEnvironmentVariable('Path', "$u;$dir", 'User') }
  if (($env:Path -split ';') -notcontains $dir) { $env:Path += ";$dir" }
}

function Step-Packages {
  if (-not (Has winget)) { Write-Warning 'winget not found. Install "App Installer" from the Microsoft Store.'; return }
  Say 'Packages (winget)'
  $ids = $IaPackages
  foreach ($i in $ids) { Winget-Install $i }
  Refresh-Path
}

function Step-Engram {
  # engram: official Windows release zip (no Go needed) -> ~\.local\bin, added to the user PATH
  if ($env:IA_FORCE -or -not (Has engram)) {
    try {
      $rel = Invoke-RestMethod https://api.github.com/repos/Gentleman-Programming/engram/releases/latest
      $arch = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'arm64' } else { 'amd64' }
      $asset = $rel.assets | Where-Object { $_.name -like "engram_*_windows_$arch.zip" } | Select-Object -First 1
      $tmp = Join-Path $env:TEMP 'engram-dl'; Remove-Item $tmp -Recurse -Force -ErrorAction SilentlyContinue
      New-Item -ItemType Directory -Force $tmp | Out-Null
      Invoke-WebRequest $asset.browser_download_url -OutFile "$tmp\engram.zip"
      Expand-Archive "$tmp\engram.zip" -DestinationPath $tmp -Force
      $bin = Join-Path $HOME '.local\bin'; New-Item -ItemType Directory -Force $bin | Out-Null
      Copy-Item (Get-ChildItem $tmp -Filter engram.exe -Recurse | Select-Object -First 1).FullName $bin -Force
      Add-UserPath $bin
    } catch { Write-Warning "engram: $($_.Exception.Message). Manual: https://github.com/Gentleman-Programming/engram/releases"; $Missing.Add('engram') }
  }
}

function Step-Tools {
  Say 'AI tools'
  Refresh-Path
  if (-not (Has claude)) { try { Invoke-RestMethod https://claude.ai/install.ps1 | Invoke-Expression } catch { $Missing.Add('claude-code') } }
  if (-not (Has opencode) -and (Has npm)) { npm install -g opencode-ai 2>&1 | Out-Host; if (-not (Has opencode)) { $Missing.Add('opencode') } }
  if (-not (Has codegraph) -and (Has npm)) { npm install -g '@colbymchenry/codegraph' 2>&1 | Out-Host }
  if (-not (Has herdr)) { try { Invoke-RestMethod https://herdr.dev/install.ps1 | Invoke-Expression } catch { Write-Warning 'herdr: see https://herdr.dev/docs/windows-beta/'; $Missing.Add('herdr') } }
  Step-Engram
  # gentle-ai has no Windows release asset: install Go automatically, then `go install`
  if (-not (Has gentle-ai)) {
    if (-not (Has go)) { Winget-Install 'GoLang.Go'; Refresh-Path }
    $goBin = Join-Path $HOME 'go\bin'
    if (Has go) {
      go install github.com/gentleman-programming/gentle-ai/v4/cmd/gentle-ai@latest 2>&1 | Out-Host
      Add-UserPath $goBin
    }
    if (-not (Has gentle-ai)) { $Missing.Add('gentle-ai') }
  }
  if ((Has gentle-ai) -and (Has claude)) {
    $agents = if ($env:IA_AGENTS) { $env:IA_AGENTS } else { 'claude-code,opencode' }
    gentle-ai install --agent $agents --preset full-gentleman 2>&1 | Out-Host
  }
  # Font (IosevkaTerm Nerd Font) via winget when available
  winget install --id DEVCOM.IosevkaTermNerdFont -e --source winget --silent --accept-package-agreements --accept-source-agreements 2>&1 | Out-Null
}

function Link($src, $dst) {
  if (-not (Test-Path $src)) { return }
  New-Item -ItemType Directory -Force -Path (Split-Path $dst) | Out-Null
  if (Test-Path $dst) {
    $bk = Join-Path $HOME ".ia-install-backup\$(Get-Date -Format yyyyMMdd-HHmmss)"
    New-Item -ItemType Directory -Force -Path $bk | Out-Null
    Move-Item $dst $bk -Force; Write-Host "!! Moved $dst -> $bk"
  }
  try { New-Item -ItemType SymbolicLink -Path $dst -Target $src -ErrorAction Stop | Out-Null }
  catch { Copy-Item $src $dst -Recurse -Force; Write-Warning "No symlink permission (enable Developer Mode); copied $dst instead." }
}

function Step-Link {
  Say 'Linking configs'
  Link "$Root\nvim"                 "$env:LOCALAPPDATA\nvim"
  Link "$Root\wezterm\wezterm.lua"  "$HOME\.wezterm.lua"
  Link "$Root\powershell\profile.ps1" $PROFILE.CurrentUserAllHosts
  Link "$Root\herdr\config.toml"    "$env:APPDATA\herdr\config.toml"   # path unverified, see README
}

if ($Step -in 'all','packages') { Step-Packages }
if ($Step -in 'all','tools')    { Step-Tools }
if ($Step -eq 'engram')         { Step-Engram }
if ($Step -in 'all','link')     { Step-Link }
if ($Missing.Count) { Write-Warning ("Not installed: " + ($Missing -join ', ')) } else { Say 'Done.' }
