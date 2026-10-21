# defaults

Personal configuration for Neovim and WezTerm.

## Layout

- `nvim/` mirrors `%LOCALAPPDATA%\nvim`
- `wezterm/.wezterm.lua` mirrors `%USERPROFILE%\.wezterm.lua`

## Sync changes

Run from PowerShell:

```powershell
& C:\repos\defaults\sync.ps1
```

The script copies the live configuration into this repository. Review the diff, then commit and push it. Codex is globally instructed to do all three whenever it changes either live configuration.

## Restore on Windows

```powershell
Copy-Item -Recurse -Force C:\repos\defaults\nvim\* "$env:LOCALAPPDATA\nvim\"
Copy-Item -Force C:\repos\defaults\wezterm\.wezterm.lua "$env:USERPROFILE\.wezterm.lua"
```

## Codex status line

`codex/status-line.toml` contains the status-line settings to merge into
`%USERPROFILE%\.codex\config.toml` under `[tui]`. It shows context used, the
five-hour and weekly allowance remaining, the model, and session tokens.

Start or resume Codex after changing the file. In an already running session,
use `/statusline` to select the same fields and apply them immediately.
The full Codex config and credentials are not backed up here.
