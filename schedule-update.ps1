# Weekly update via Task Scheduler (runs at logon if the PC was off; low priority, no admin).
$act = New-ScheduledTaskAction -Execute 'pwsh.exe' -Argument "-NoProfile -WindowStyle Hidden -File `"$PSScriptRoot\update.ps1`""
$trg = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 3am
$set = New-ScheduledTaskSettingsSet -StartWhenAvailable -RunOnlyIfNetworkAvailable -Priority 7
Register-ScheduledTask -TaskName 'IA-Update' -Action $act -Trigger $trg -Settings $set -Force | Out-Null
Write-Host 'Scheduled: IA-Update (weekly, Sunday 03:00, catches up if missed).'
