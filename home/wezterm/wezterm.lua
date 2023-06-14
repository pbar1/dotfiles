local wezterm = require("wezterm")

local split_horizontal = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } })
local split_vertical = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } })

return {
   automatically_reload_config = true,
   check_for_updates = false,

   set_environment_variables = {
      TERMINFO_DIRS = "/run/current-system/sw/share/terminfo",
   },
   term = "wezterm",

   font = wezterm.font("Iosevka Nerd Font Mono"),
   font_size = 16,
   warn_about_missing_glyphs = false,
   default_cursor_style = "BlinkingBlock",

   enable_wayland = true,
   window_background_opacity = 1.0,
   adjust_window_size_when_changing_font_size = false,
   window_decorations = "INTEGRATED_BUTTONS|RESIZE",
   use_fancy_tab_bar = false,
   hide_tab_bar_if_only_one_tab = true,

   -- Shift mod is needed due to: https://github.com/wez/wezterm/issues/394
   leader = { key = "a", mods = "CTRL" },
   keys = {
      -- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
      { key = "a", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },

      -- Emulate Tmux
      { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
      { key = "|", mods = "LEADER|SHIFT", action = split_horizontal },
      { key = '"', mods = "LEADER|SHIFT", action = split_vertical },
      { key = "LeftArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
      { key = "DownArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
      { key = "UpArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
      { key = "RightArrow", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },

      -- Emulate iTerm2
      { key = "Enter", mods = "SHIFT|SUPER", action = "TogglePaneZoomState" },
      { key = "d", mods = "SHIFT|SUPER", action = split_vertical },
      { key = "d", mods = "SUPER", action = split_horizontal },
   },

   hyperlink_rules = {
      {
         -- Linkify things that look like URLs
         -- This is actually the default if you don't specify any hyperlink_rules
         regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
         format = "$0",
      },
      {
         -- Make task, diff and paste numbers clickable
         regex = "\\b([tTdDpP]\\d+)\\b",
         format = "https://fburl.com/b/$1",
      },
   },

   quick_select_patterns = {
      -- Make task, diff and paste numbers quick-selectable
      "\\b([tTdDpP]\\d+)\\b",
   },
}
