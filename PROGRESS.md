# Windows (PowerShell) installer: progress

Status as of 2026-11-06. `packages`, `tools`, `link` tested on a Windows 11 Hyper-V VM (all tools detected). `update.ps1` and `schedule-update.ps1` also tested (task result 0). Not yet tested: herdr config path, prompt/font.

## Done
- `install.ps1 [all|packages|tools|link]`: winget packages, Claude Code, opencode (npm), codegraph (npm), herdr, gentle-ai (go install), font, config links (symlink, falls back to copy).
- `update.ps1`: winget + npm + claude + `gentle-ai sync`, reports failures.
- `schedule-update.ps1`: weekly Task Scheduler job (replaces systemd timers), catches up if missed.
- `powershell/profile.ps1` (starship, zoxide, PSReadLine, eza/bat aliases), `wezterm/wezterm.lua` (pwsh), `nvim/`, `herdr/config.toml`.

## Replaced or left out (no native Windows equivalent)
- zsh, powerlevel10k, oh-my-zsh, zsh plugins -> PowerShell + Starship + PSReadLine.
- Homebrew -> winget/npm. systemd timers -> Task Scheduler.
- Claude `settings.json`/hooks/statusline: use `bash` and `python3`; not ported. gentle-ai generates its own.
- atuin, carapace, agy: not added (Windows support unverified).

## Unverified (check on Windows)
- winget ids: `Anthropic.ClaudeCode`, `DEVCOM.IosevkaTermNerdFont`, `wez.wezterm`, `Starship.Starship`, `BurntSushi.ripgrep.MSVC`.
- herdr: `https://herdr.dev/install.ps1` URL and config path `%APPDATA%\herdr\config.toml` (docs: https://herdr.dev/docs/windows-beta/).
- engram: only manual binary download from GitHub Releases is confirmed.
- Symlinks need Developer Mode; otherwise files are copied.

## Next
1. Test in a Windows VM / machine.
2. Write bilingual README (same format as the Linux repo, with credits).
3. Decide visibility and create the GitHub repo (not created yet, not pushed).
