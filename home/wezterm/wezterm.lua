local wezterm = require("wezterm")
local catppuccin = require("colors.catppuccin")

-- function scheme_for_appearance(appearance)
-- 	if appearance:find("Dark") then
-- 		return "OneHalfDark"
-- 	else
-- 		return "OneHalfDark"
-- 	end
-- end
--
-- wezterm.on("window-config-reloaded", function(window, pane)
-- 	local overrides = window:get_config_overrides() or {}
-- 	local appearance = window:get_appearance()
-- 	local scheme = scheme_for_appearance(appearance)
-- 	if overrides.color_scheme ~= scheme then
-- 		overrides.color_scheme = scheme
-- 		window:set_config_overrides(overrides)
-- 	end
-- end)

return {
	automatically_reload_config = true,

	term = "wezterm",
	default_prog = { "/run/current-system/sw/bin/fish", "--login" },

	font = wezterm.font("Iosevka Nerd Font Mono"),
	font_size = 16,

	window_background_opacity = 1.0,
	adjust_window_size_when_changing_font_size = false,

	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = true,

	leader = { key = "a", mods = "CTRL" },
	keys = {
		{
			key = '"',
			mods = "LEADER",
			action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "|",
			mods = "LEADER",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{
			key = "z",
			mods = "LEADER",
			action = "TogglePaneZoomState",
		},
	},

	colors = catppuccin,
}
