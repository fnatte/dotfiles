local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- Fix for Hyprland issue
if os.getenv("XDG_CURRENT_DESKTOP") == "Hyprland" then
	config.enable_wayland = false
else
	config.enable_wayland = true
end

-- Appearance
config.color_scheme = 'rose-pine-moon'
config.font = wezterm.font("Fantasque Sans M Nerd Font")
config.font_size = 13.0
config.window_background_opacity = 0.9

-- Keybindings
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
	-- Splitting Panes
	{
		key = 'b',
		mods = 'LEADER',
		action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
	},
	{
		key = 'v',
		mods = 'LEADER',
		action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
	},

	-- Pane Navigation
	{
		key = 'h',
		mods = 'LEADER',
		action = wezterm.action.ActivatePaneDirection "Left",
	},
	{
		key = 'j',
		mods = 'LEADER',
		action = wezterm.action.ActivatePaneDirection "Down",
	},
	{
		key = 'k',
		mods = 'LEADER',
		action = wezterm.action.ActivatePaneDirection "Up",
	},
	{
		key = 'l',
		mods = 'LEADER',
		action = wezterm.action.ActivatePaneDirection "Right",
	},

	-- Ctrl + A, Ctrl + A to send Ctrl + A
	{
		key = 'a',
		mods = 'LEADER|CTRL',
		action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
	},
}


return config
