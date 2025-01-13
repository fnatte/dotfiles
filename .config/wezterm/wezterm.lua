local wezterm = require 'wezterm'

local config = wezterm.config_builder()

local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil

-- Fix for Hyprland issue
if os.getenv("XDG_CURRENT_DESKTOP") == "Hyprland" then
	config.enable_wayland = false
else
	config.enable_wayland = true
end


-- MacOS specifics
if is_darwin then
	config.default_prog = { '/opt/homebrew/bin/fish' }
end

-- Appearance
config.color_scheme = 'rose-pine-moon'

if is_darwin then
	config.font = wezterm.font('FantasqueSansM Nerd Font Mono')
	config.font_size = 19.0
	config.window_background_opacity = 0.975
	config.window_frame = {
		font = wezterm.font { family = 'FantasqueSansM Nerd Font Mono', weight = 'Bold' },
		font_size = 17.0,
	}
else
	config.font = wezterm.font("Fantasque Sans M Nerd Font Mono")
	config.font_size = 13.0
	config.window_background_opacity = 0.9
end

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
