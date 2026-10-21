local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Appearance

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13.0

-- Behaviour

config.hide_tab_bar_if_only_one_tab = false
config.window_close_confirmation = 'NeverPrompt'
-- Use Alt directly for terminal shortcuts; keep the standard Ctrl-Tab bindings.

config.keys = {
    -- Common terminal actions. Default bindings remain available as aliases.
    { key = 'c', mods = 'ALT', action = wezterm.action.CopyTo 'Clipboard' },
    { key = 'v', mods = 'ALT|SHIFT', action = wezterm.action.PasteFrom 'Clipboard' },
    { key = 'f', mods = 'ALT', action = wezterm.action.Search 'CurrentSelectionOrEmptyString' },
    { key = 'p', mods = 'ALT', action = wezterm.action.ActivateCommandPalette },
    { key = 'z', mods = 'ALT', action = wezterm.action.TogglePaneZoomState },
    { key = 'n', mods = 'ALT', action = wezterm.action.SpawnWindow },
    { key = 'x', mods = 'ALT', action = wezterm.action.ActivateCopyMode },
    { key = 'r', mods = 'ALT|SHIFT', action = wezterm.action.ReloadConfiguration },
    -- Tab management. WezTerm handles these before passing input to Neovim.
    {
        key = 'Tab',
        mods = 'CTRL',
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = 'Tab',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = 't',
        mods = 'ALT',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'w',
        mods = 'ALT|SHIFT',
        action = wezterm.action.CloseCurrentTab { confirm = false },
    },
    {
        key = 'h',
        mods = 'ALT',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'w',
        mods = 'ALT',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
        key = 'v',
        mods = 'ALT',
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'l',
        mods = 'ALT|SHIFT',
        action = wezterm.action.SplitPane { direction = 'Left' },
    },
    {
        key = 'h',
        mods = 'ALT|SHIFT',
        action = wezterm.action.ActivatePaneDirection 'Left',
    },
    {
        key = 'j',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection 'Down',
    },
    {
        key = 'k',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection 'Up',
    },
    {
        key = 'l',
        mods = 'ALT',
        action = wezterm.action.ActivatePaneDirection 'Right',
    },
    {
        key = 'LeftArrow',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'RightArrow',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },
    {
        key = 'UpArrow',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { 'Up', 5 },
    },
    {
        key = 'DownArrow',
        mods = 'ALT',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 },
    },
}

return config
