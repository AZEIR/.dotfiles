local wezterm = require("wezterm")
local action = wezterm.action
local config = wezterm.config_builder()

-- Native Wayland with a broadly compatible renderer.
config.front_end = "OpenGL"
config.enable_wayland = true

-- Appearance
config.color_scheme = "Vacuous 2 (terminal.sexy)"
config.window_decorations = "RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.window_background_opacity = 0.96
config.inactive_pane_hsb = { saturation = 0.9, brightness = 0.75 }

-- Fonts
config.font = wezterm.font_with_fallback({
	"FiraCode Nerd Font",
	"Noto Color Emoji",
})
config.font_size = 12.0
config.adjust_window_size_when_changing_font_size = false

-- Terminal behaviour
config.default_prog = { "/bin/zsh" }
config.scrollback_lines = 10000
config.default_cursor_style = "SteadyBar"
config.audible_bell = "Disabled"

-- Run local sessions in a background mux server so the GUI can detach and
-- reattach without terminating shells. Reopening WezTerm reconnects to it.
config.unix_domains = {
	{ name = "unix" },
}
config.default_gui_startup_args = { "connect", "unix" }
-- Fedora's desktop entry explicitly runs `wezterm start`, so also make the
-- persistent domain the default for that launch path.
config.default_domain = "unix"

-- Keep familiar tmux chords while using WezTerm's native panes.
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- Clipboard
	{ key = "C", mods = "CTRL|SHIFT", action = action.CopyTo("Clipboard") },
	{ key = "V", mods = "CTRL|SHIFT", action = action.PasteFrom("Clipboard") },

	-- Panes: split, focus, resize, close, and zoom
	{ key = '"', mods = "LEADER", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "%", mods = "LEADER", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "LeftArrow", mods = "LEADER", action = action.ActivatePaneDirection("Left") },
	{ key = "DownArrow", mods = "LEADER", action = action.ActivatePaneDirection("Down") },
	{ key = "UpArrow", mods = "LEADER", action = action.ActivatePaneDirection("Up") },
	{ key = "RightArrow", mods = "LEADER", action = action.ActivatePaneDirection("Right") },
	{ key = "LeftArrow", mods = "LEADER|SHIFT", action = action.AdjustPaneSize({ "Left", 3 }) },
	{ key = "DownArrow", mods = "LEADER|SHIFT", action = action.AdjustPaneSize({ "Down", 3 }) },
	{ key = "UpArrow", mods = "LEADER|SHIFT", action = action.AdjustPaneSize({ "Up", 3 }) },
	{ key = "RightArrow", mods = "LEADER|SHIFT", action = action.AdjustPaneSize({ "Right", 3 }) },
	{ key = "x", mods = "LEADER", action = action.CloseCurrentPane({ confirm = true }) },
	{ key = "z", mods = "LEADER", action = action.TogglePaneZoomState },
	{ key = "d", mods = "LEADER", action = action.DetachDomain("CurrentPaneDomain") },

	-- Tabs
	{ key = "t", mods = "CTRL|SHIFT", action = action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CTRL|SHIFT", action = action.CloseCurrentTab({ confirm = true }) },
	{ key = "c", mods = "LEADER", action = action.SpawnTab("CurrentPaneDomain") },
	{ key = "[", mods = "LEADER", action = action.ActivateTabRelative(-1) },
	{ key = "]", mods = "LEADER", action = action.ActivateTabRelative(1) },
}

-- Compact tab bar with explicit indices and application-provided titles.
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

local function tab_title(tab)
	if tab.tab_title and #tab.tab_title > 0 then
		return tab.tab_title
	end
	return tab.active_pane.title
end

wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
	local index = tostring(tab.tab_index + 1)
	local title = index .. ": " .. tab_title(tab)
	return " " .. wezterm.truncate_right(title, max_width - 2) .. " "
end)

return config
