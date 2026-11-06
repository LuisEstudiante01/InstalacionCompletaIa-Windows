# PowerShell profile: prompt (starship), zoxide, fzf, PSReadLine, aliases
if (Get-Command starship -ErrorAction SilentlyContinue) { Invoke-Expression (&starship init powershell) }
if (Get-Command zoxide -ErrorAction SilentlyContinue) { Invoke-Expression (& { (zoxide init powershell | Out-String) }) }
if (Get-Module -ListAvailable PSReadLine) {
  Set-PSReadLineOption -PredictionSource History -PredictionViewStyle ListView
  Set-PSReadLineOption -EditMode Emacs
}
if (Get-Command eza -ErrorAction SilentlyContinue) { function ll { eza -la --icons @args }; function ls { eza --icons @args } }
if (Get-Command bat -ErrorAction SilentlyContinue) { function cat { bat --paging=never @args } }
Set-Alias -Name lg -Value lazygit -ErrorAction SilentlyContinue
Set-Alias -Name vim -Value nvim -ErrorAction SilentlyContinue
