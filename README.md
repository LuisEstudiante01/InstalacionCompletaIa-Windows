# Instalacion-Completa-ia-Windows

**[English](#english) | [Español](#español)**

---

## Español

Instalación de un solo comando de un entorno completo de terminal y agentes de IA para programar en **Windows (PowerShell 7)**:
PowerShell + Starship, Neovim (LazyVim), herdr, WezTerm, instalación y configuración de Claude Code y OpenCode, y memoria
persistente para agentes con [Engram](https://github.com/Gentleman-Programming/engram) y las skills oficiales de
[gentle-ai](https://github.com/Gentleman-Programming/gentle-ai). Es la versión para Windows nativo de
[InstalacionCompletaIa](https://github.com/LuisEstudiante01/InstalacionCompletaIa) (Ubuntu/Debian).

> Este repositorio **no contiene datos personales**. Solo su dueño puede modificarlo:
> clónalo para usarlo o haz un fork para personalizarlo.

### Instalar

Abre PowerShell 7 (`pwsh`). Si no lo tienes: `winget install Microsoft.PowerShell`. Activa el *Modo desarrollador* de Windows
para que los enlaces simbólicos funcionen (si no, los archivos se copian).

```powershell
winget install Git.Git
git clone https://github.com/LuisEstudiante01/InstalacionCompletaIa-Windows.git
cd InstalacionCompletaIa-Windows
.\install.ps1            # o: packages | tools | link
```

Si Windows bloquea los scripts, ejecuta una vez `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force`. Algunos paquetes
(p. ej. GitHub CLI) piden permiso de administrador: acepta el aviso de UAC o ejecuta el instalador desde una terminal de administrador.

Elegir agentes: `$env:IA_AGENTS="claude-code,opencode"; .\install.ps1 tools`. Los archivos que ya existan se mueven a
`~\.ia-install-backup\<fecha>`.

### Actualizar todo

```powershell
.\update.ps1
.\schedule-update.ps1   # opcional: actualización semanal con el Programador de tareas (recupera la ejecución si la PC estaba apagada)
```

### Qué cambia respecto a la versión de Linux

| Linux | Windows |
|---|---|
| zsh + Powerlevel10k + plugins | PowerShell + Starship + PSReadLine |
| Homebrew / apt | winget / npm |
| timers de systemd | Programador de tareas |
| atuin, carapace, agy | no incluidos (soporte en Windows sin verificar) |
| configuración de Claude (hooks `bash`, `python3`) | no incluida; gentle-ai genera la suya |

### Estructura

| Ruta | Contenido |
|---|---|
| `install.ps1`, `update.ps1`, `schedule-update.ps1` | instalar, actualizar y programar la actualización semanal |
| `powershell/`, `wezterm/`, `nvim/`, `herdr/` | configuración base que se entrega como punto de partida |
| `PROGRESS.md` | estado del proyecto y cosas por verificar |

### Créditos

Este proyecto es solo un instalador y un conjunto de configuraciones iniciales. El trabajo real lo hace el ecosistema de
[Gentleman Programming](https://github.com/Gentleman-Programming). Muchas gracias a su autor y a sus colaboradores por crear
estas herramientas y mantenerlas de código abierto.

| Proyecto | Qué hace |
|---|---|
| [gentle-ai](https://github.com/Gentleman-Programming/gentle-ai) | Configura los agentes de IA que ya usas (Claude Code, OpenCode, Codex, Pi y más): memoria persistente, Organic Driven Development, skills seleccionadas, servidores MCP, personas y revisión acotada opcional. |
| [gentle-shell](https://github.com/Gentleman-Programming/gentle-shell) (antes `gentle-pi`) | Un espacio de trabajo de terminal nativo de Pi para desarrollar con IA: agentes de código en paralelo, tareas en vivo, diffs de Git, memoria persistente y control de permisos en una sola interfaz. |
| [engram](https://github.com/Gentleman-Programming/engram) | Memoria persistente para agentes de IA: un único binario en Go con SQLite + FTS5, servidor MCP, API HTTP, CLI y TUI. |
| [gentleman-guardian-angel](https://github.com/Gentleman-Programming/gentleman-guardian-angel) (`gga`) | Revisión de código con IA, independiente del proveedor, que hace cumplir tus estándares (Claude, Gemini, Codex, Ollama). |
| [homebrew-tap](https://github.com/Gentleman-Programming/homebrew-tap) | El tap de Homebrew que distribuye gentle-ai, engram y gga en Linux/macOS (en Windows se usan sus releases o `go install`). |
| [gentle-wiki](https://github.com/Gentleman-Programming/gentle-wiki) | Guías y referencias mantenidas por la comunidad sobre desarrollo de software asistido por IA y el ecosistema Gentleman Programming. |
| [gentle-ai-community-docs](https://github.com/Gentleman-Programming/gentle-ai-community-docs) | La documentación comunitaria bilingüe (inglés/español) de Gentle AI, en [docs-gentle-ai.netlify.app](https://docs-gentle-ai.netlify.app); también se ofrece a los agentes de código mediante un servidor MCP de solo lectura. |
| [Gentleman.Dots](https://github.com/Gentleman-Programming/Gentleman.Dots) | La configuración personal de LazyVim del autor. |

También se usan: [herdr](https://herdr.dev), [WezTerm](https://wezterm.org), [OpenCode](https://opencode.ai),
[Claude Code](https://claude.ai) [Homebrew](https://brew.sh) (solo en la versión de Linux), [Starship](https://starship.rs) y [winget](https://learn.microsoft.com/windows/package-manager/).
Este repositorio es un proyecto comunitario independiente y no está afiliado ni respaldado por ninguno de ellos.

### Notas

Revisa `install.ps1` antes de ejecutarlo: instala software. Se probaron en una VM con Windows 11 (Hyper-V):
`install.ps1 packages`, `tools` y `link`, y `update.ps1` (todos los programas quedaron instalados y detectados; los enlaces de WezTerm,
Neovim y el perfil de PowerShell se crearon). Sin probar: `schedule-update.ps1`, la ruta de configuración de
herdr, el aspecto del prompt y la fuente en WezTerm. Tras instalar, abre una terminal nueva para que se actualice el PATH. Licencia MIT.

[↑ Volver arriba / Back to top](#Instalacion-Completa-ia-Windows)

---

## English

One-command setup of a complete terminal and AI-agent environment for coding on **Windows (PowerShell 7)**:
PowerShell + Starship, Neovim (LazyVim), herdr, WezTerm, installation and setup of Claude Code and OpenCode, and persistent
agent memory with [Engram](https://github.com/Gentleman-Programming/engram) and the official
[gentle-ai](https://github.com/Gentleman-Programming/gentle-ai) skills. This is the native Windows version of
[InstalacionCompletaIa](https://github.com/LuisEstudiante01/InstalacionCompletaIa) (Ubuntu/Debian).

> This repository contains **no personal data**. Only its owner can modify it:
> clone it to use it, or fork it to customize it.

### Install

Open PowerShell 7 (`pwsh`). If you don't have it: `winget install Microsoft.PowerShell`. Turn on Windows *Developer Mode*
so symlinks work (otherwise files are copied).

```powershell
winget install Git.Git
git clone https://github.com/LuisEstudiante01/InstalacionCompletaIa-Windows.git
cd InstalacionCompletaIa-Windows
.\install.ps1            # or: packages | tools | link
```

If Windows blocks scripts, run once `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force`. Some packages
(e.g. GitHub CLI) ask for administrator rights: accept the UAC prompt or run the installer from an elevated terminal.

Pick agents: `$env:IA_AGENTS="claude-code,opencode"; .\install.ps1 tools`. Existing files are moved to
`~\.ia-install-backup\<timestamp>`.

### Update everything

```powershell
.\update.ps1
.\schedule-update.ps1   # optional: weekly update via Task Scheduler (catches up if the PC was off)
```

### What differs from the Linux version

| Linux | Windows |
|---|---|
| zsh + Powerlevel10k + plugins | PowerShell + Starship + PSReadLine |
| Homebrew / apt | winget / npm |
| systemd timers | Task Scheduler |
| atuin, carapace, agy | not included (Windows support unverified) |
| Claude config (`bash`, `python3` hooks) | not included; gentle-ai generates its own |

### Layout

| Path | What it holds |
|---|---|
| `install.ps1`, `update.ps1`, `schedule-update.ps1` | install, update, and schedule the weekly update |
| `powershell/`, `wezterm/`, `nvim/`, `herdr/` | base configuration shipped as a starting point |
| `PROGRESS.md` | project status and items to verify |

### Credits

This project is only an installer and a set of starting configs. The real work is done by the
[Gentleman Programming](https://github.com/Gentleman-Programming) ecosystem. Huge thanks to its author and
contributors for building these tools and keeping them open source.

| Project | What it does |
|---|---|
| [gentle-ai](https://github.com/Gentleman-Programming/gentle-ai) | Configures the AI coding agents you already use (Claude Code, OpenCode, Codex, Pi and more): persistent memory, Organic Driven Development, curated skills, MCP servers, personas and optional bounded review. |
| [gentle-shell](https://github.com/Gentleman-Programming/gentle-shell) (formerly `gentle-pi`) | A Pi-native terminal workspace for AI-assisted development: parallel coding agents, live tasks, Git diffs, persistent memory and permission controls in one interface. |
| [engram](https://github.com/Gentleman-Programming/engram) | Persistent memory for AI coding agents: a single Go binary with SQLite + FTS5, an MCP server, HTTP API, CLI and TUI. |
| [gentleman-guardian-angel](https://github.com/Gentleman-Programming/gentleman-guardian-angel) (`gga`) | Provider-agnostic AI code review that enforces your coding standards (Claude, Gemini, Codex, Ollama). |
| [homebrew-tap](https://github.com/Gentleman-Programming/homebrew-tap) | The Homebrew tap that distributes gentle-ai, engram and gga on Linux/macOS (on Windows, use their releases or `go install`). |
| [gentle-wiki](https://github.com/Gentleman-Programming/gentle-wiki) | Community-maintained guides and references on AI-assisted software development and the Gentleman Programming ecosystem. |
| [gentle-ai-community-docs](https://github.com/Gentleman-Programming/gentle-ai-community-docs) | The bilingual (English/Spanish) community documentation for Gentle AI, at [docs-gentle-ai.netlify.app](https://docs-gentle-ai.netlify.app), also served to coding agents through a read-only MCP server. |
| [Gentleman.Dots](https://github.com/Gentleman-Programming/Gentleman.Dots) | The author's personal LazyVim configuration. |

Also used: [herdr](https://herdr.dev), [WezTerm](https://wezterm.org), [OpenCode](https://opencode.ai),
[Claude Code](https://claude.ai) [Homebrew](https://brew.sh) (Linux version only), [Starship](https://starship.rs) and [winget](https://learn.microsoft.com/windows/package-manager/).
This repository is an independent community project and is not affiliated with or endorsed by any of them.

### Notes

Review `install.ps1` before running it: it installs software. Tested on a Windows 11 VM (Hyper-V):
`install.ps1 packages`, `tools` and `link`, and `update.ps1` (every program was installed and detected; the WezTerm, Neovim and PowerShell
profile links were created). Untested: `schedule-update.ps1`, herdr's config path, the prompt look and the
WezTerm font. After installing, open a new terminal so PATH refreshes. Licensed under MIT.

[↑ Back to top / Volver arriba](#Instalacion-Completa-ia-Windows)
