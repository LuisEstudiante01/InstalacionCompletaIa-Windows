# Update everything installed by install.ps1. Safe to run unattended.
$ErrorActionPreference = 'Continue'
$fail = @()
. "$PSScriptRoot\packages.ps1"
function Run($n, [scriptblock]$b) { Write-Host "==> $n" -ForegroundColor Cyan; $global:LASTEXITCODE = 0; try { & $b; if ($LASTEXITCODE -ne 0 -and $LASTEXITCODE -ne -1978335189 -and $LASTEXITCODE -ne -1978335212) { $script:fail += $n } } catch { $script:fail += $n } }
if (Get-Command winget -ErrorAction SilentlyContinue) { foreach ($id in $IaPackages) { Run "winget $id" { winget upgrade --id $id -e --source winget --silent --accept-package-agreements --accept-source-agreements } } }
if (Get-Command npm -ErrorAction SilentlyContinue)    { Run 'npm globals' { npm update -g } }
if (Get-Command go -ErrorAction SilentlyContinue)    { Run 'gentle-ai binary' { go install github.com/gentleman-programming/gentle-ai/v4/cmd/gentle-ai@latest } }
if (Get-Command engram -ErrorAction SilentlyContinue) { Run 'engram binary' { $env:IA_FORCE = '1'; & "$PSScriptRoot\install.ps1" engram; Remove-Item Env:IA_FORCE } }
if (Get-Command gentle-ai -ErrorAction SilentlyContinue) { Run 'gentle-ai sync' { gentle-ai sync } }
if ($fail.Count) { Write-Warning ("Failed: " + ($fail -join ', ')) } else { Write-Host 'Everything updated.' }
