# Update everything installed by install.ps1. Safe to run unattended.
$ErrorActionPreference = 'Continue'
$fail = @()
function Run($n, [scriptblock]$b) { Write-Host "==> $n" -ForegroundColor Cyan; try { & $b; if ($LASTEXITCODE -gt 0 -and $LASTEXITCODE -ne -1978335189) { $script:fail += $n } } catch { $script:fail += $n } }
if (Get-Command winget -ErrorAction SilentlyContinue) { Run 'winget' { winget upgrade --all --silent --accept-package-agreements --accept-source-agreements } }
if (Get-Command npm -ErrorAction SilentlyContinue)    { Run 'npm globals' { npm update -g } }
if (Get-Command claude -ErrorAction SilentlyContinue) { Run 'claude' { claude update } }
if (Get-Command gentle-ai -ErrorAction SilentlyContinue) { Run 'gentle-ai sync' { gentle-ai sync } }
if ($fail.Count) { Write-Warning ("Failed: " + ($fail -join ', ')) } else { Write-Host 'Everything updated.' }
