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
