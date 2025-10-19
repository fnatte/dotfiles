local wezterm = require 'wezterm'


local config = wezterm.config_builder()

local is_darwin <const> = wezterm.target_triple:find("darwin") ~= nil

-- Fix for Hyprland issue
if os.getenv("XDG_CURRENT_DESKTOP") == "Hyprland" then
	config.enable_wayland = false
else
	config.enable_wayland = true
end

-- Configure PATH on MacOS so that wezterm can find homebrew binaries, etc.
-- This is needed because wezterm is likely not launched from a shell, but
-- rather from the GUI (Spotlight).
if is_darwin then
	config.set_environment_variables = {
		PATH = os.getenv("PATH") .. ":" .. table.concat({
			"/opt/homebrew/bin",
			wezterm.home_dir .. "/.local/bin",
			wezterm.home_dir .. "/bin",
			wezterm.home_dir .. "/go/bin",
		}, ":"),
	}
end

-- Session management
local sessionizer = wezterm.plugin.require "https://github.com/mikkasendke/sessionizer.wezterm"
local session_schema = {
	sessionizer.DefaultWorkspace {},
	sessionizer.AllActiveWorkspaces {},
	sessionizer.FdSearch {
		wezterm.home_dir .. "/Code",
		max_depth = 3,
		fd_path = is_darwin and "/opt/homebrew/bin/fd" or "/usr/bin/fd",
	},
	wezterm.home_dir .. "/.config/wezterm",

	-- Make paths more readable by replacing home directory with ~
	processing = sessionizer.for_each_entry(function(entry)
		entry.label = entry.label:gsub(wezterm.home_dir, "~")
	end)
}


-- MacOS specifics
if is_darwin then
	config.default_prog = { '/opt/homebrew/bin/fish' }
end


-- Appearance
config.color_scheme = 'rose-pine-moon'
config.colors = { -- Bundled rose-pine-moon colors are outdated/wrong
	foreground = "#e0def4",
	background = "#232136",
	cursor_bg = "#e0def4",
	cursor_border = "#e0def4",
	cursor_fg = "#232136",
	selection_fg = "#e0def4",
	selection_bg = "#44415a",
	ansi = {
		"#393552",
		"#eb6f92",
		"#3e8fb0",
		"#f6c177",
		"#9ccfd8",
		"#c4a7e7",
		"#ea9a97",
		"#e0def4",
	},
	brights = {
		"#6e6a86",
		"#eb6f92",
		"#3e8fb0",
		"#f6c177",
		"#9ccfd8",
		"#c4a7e7",
		"#ea9a97",
		"#e0def4",
	},
}

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
	config.window_background_opacity = 0.95
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

	-- Workspaces
	{
		key = "p",
		mods = "LEADER",
		action = sessionizer.show(session_schema),
	},
	{
		key = 'P',
		mods = 'LEADER',
		action = wezterm.action.ShowLauncherArgs {
			flags = 'FUZZY|WORKSPACES',
		},
	},
}


return config
