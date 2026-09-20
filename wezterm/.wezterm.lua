local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- Appearance

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 13.0

-- Behaviour

config.hide_tab_bar_if_only_one_tab = false
config.window_close_confirmation = 'NeverPrompt'

config.keys = {
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
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SpawnTab 'CurrentPaneDomain',
    },
    {
        key = 'w',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.CloseCurrentTab { confirm = false },
    },
    {
        key = 'r',
        mods = 'CTRL',
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
        key = 'w',
        mods = 'CTRL',
        action = wezterm.action.CloseCurrentPane { confirm = false },
    },
    {
        key = 'd',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.SplitPane { direction = 'Down' },
    },
    {
        key = 'l',
        mods = 'CTRL',
        action = wezterm.action.SplitPane { direction = 'Left' },
    },
    {
        key = 'h',
        mods = 'ALT',
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
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Left', 5 },
    },
    {
        key = 'RightArrow',
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },
    {
        key = 'UpArrow',
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Up', 5 },
    },
    {
        key = 'DownArrow',
        mods = 'CTRL|ALT',
        action = wezterm.action.AdjustPaneSize { 'Down', 5 },
    },
}

return config
