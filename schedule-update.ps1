# Weekly update via Task Scheduler (runs at logon if the PC was off; low priority, no admin).
# Full path: Task Scheduler does not resolve bare names like your terminal does
$exe = if ($PSVersionTable.PSEdition -eq 'Core') { Join-Path $PSHOME 'pwsh.exe' } else { (Get-Command pwsh -ErrorAction Stop).Source }
if (-not (Test-Path $exe)) { throw "pwsh.exe not found at $exe. Run this script from PowerShell 7." }
$act = New-ScheduledTaskAction -Execute $exe -WorkingDirectory $PSScriptRoot -Argument "-NoProfile -WindowStyle Hidden -File `"$PSScriptRoot\update.ps1`""
$trg = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 3am
$set = New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable -Priority 7
Register-ScheduledTask -TaskName 'IA-Update' -Action $act -Trigger $trg -Settings $set -Force | Out-Null
Write-Host 'Scheduled: IA-Update (weekly, Sunday 03:00, catches up if missed).'
