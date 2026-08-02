local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- 1. GPU & Wayland Fixes (Optimized for RTX 3060 on Fedora 44)
config.front_end = "OpenGL"
config.enable_wayland = true

-- 2. Appearance & Window Styling
config.color_scheme = "Vacuous 2 (terminal.sexy)"

-- Strips native borders for a seamless look inside modern compositors like Hyprland/KDE
config.window_decorations = "RESIZE"
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 } -- Small padding prevents text clinging to screen edges

-- 3. Fonts (JetBrains Mono + Nerd Font Symbols fallback)
config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 12.0

-- 4. Keybindings (Colemak Friendly Configuration)
-- Keeps standard muscle-memory combos completely separated from standard navigation layout.
config.keys = {
	-- Copy/Paste mappings
	{ key = "C", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
	{ key = "V", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

	-- Pane Split hotkeys (Leader sequence)
	{ key = '"', mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "%", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

	-- Minimalist Tab Controls
	{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
	{ key = "w", mods = "CTRL|SHIFT", action = wezterm.action.CloseCurrentTab({ confirm = true }) },
}

-- 5. Tab Bar Layout
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true

-- 6. Fedora Shell Integration
config.default_prog = { "/bin/zsh" }

return config
