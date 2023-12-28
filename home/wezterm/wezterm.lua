local wezterm = require("wezterm")

-- Helper functions -----------------------------------------------------------

local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  -- Fallback for when `wezterm.gui` is not available (ex, mux server)
  return "Dark"
end

local function get_color_scheme(appearance)
  if appearance:find("Dark") then
    return "Gruvbox dark, soft (base16)"
  else
    return "Gruvbox light, soft (base16)"
  end
end

-- Used for setting tab bar theme, which `color_scheme` doesn't currently do
local function get_colors(appearance)
  local colors = {}
  if appearance:find("Dark") then
    -- Gruvbox dark soft
    -- https://github.com/dawikur/base16-gruvbox-scheme/blob/master/gruvbox-dark-soft.yaml
    colors.bg_4 = "#32302f"   -- ----
    colors.fg_4 = "#fbf1c7"   -- ++++
    colors.bg_3 = "#3c3836"   -- ---
    colors.fg_3 = "#ebdbb2"   -- +++
    colors.bg_2 = "#504945"   -- --
    colors.fg_2 = "#d5c4a1"   -- ++
  else
    -- Gruvbox light soft
    -- https://github.com/dawikur/base16-gruvbox-scheme/blob/master/gruvbox-light-soft.yaml
    colors.bg_4 = "#f2e5bc"   -- ----
    colors.fg_4 = "#282828"   -- ++++
    colors.bg_3 = "#ebdbb2"   -- ---
    colors.fg_3 = "#3c3836"   -- +++
    colors.bg_2 = "#d5c4a1"   -- --
    colors.fg_2 = "#504945"   -- ++
  end
  return {
    tab_bar = {
      background = colors.bg_3,
      active_tab = {
        bg_color = colors.bg_4,
        fg_color = colors.fg_4,
        intensity = "Normal",
      },
      inactive_tab = {
        bg_color = colors.bg_3,
        fg_color = colors.fg_3,
        intensity = "Half",
      },
      inactive_tab_hover = {
        bg_color = colors.bg_2,
        fg_color = colors.fg_2,
      },
      new_tab = {
        bg_color = colors.bg_3,
        fg_color = colors.fg_3,
        intensity = "Half",
      },
      new_tab_hover = {
        bg_color = colors.bg_2,
        fg_color = colors.fg_2,
      },
    },
  }
end

-- Misc -----------------------------------------------------------------------

local hostname = wezterm.hostname()
local appearance = get_appearance()
local config = {}

config.check_for_updates = false

-- Appearance -----------------------------------------------------------------

config.adjust_window_size_when_changing_font_size = false
config.color_scheme = get_color_scheme(appearance)
config.colors = get_colors(appearance)
config.default_cursor_style = "SteadyBlock"
config.font = wezterm.font("Iosevka Nerd Font Mono")
config.font_size = 16
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.warn_about_missing_glyphs = false
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = {
  left = "1cell",
  right = "1cell",
  top = "1cell",
  bottom = "0cell",
}

-- Keybindings ----------------------------------------------------------------

local split_horizontal = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } })
local split_vertical = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } })
config.keys = {
  -- Emulate iTerm2
  { key = "Enter", mods = "SHIFT|SUPER", action = "TogglePaneZoomState" },
  { key = "d",     mods = "SUPER",       action = split_horizontal },
  { key = "d",     mods = "SHIFT|SUPER", action = split_vertical },
}

-- Clicking & selecting -------------------------------------------------------

config.hyperlink_rules = wezterm.default_hyperlink_rules()
table.insert(config.hyperlink_rules, {
  regex = "\\b(E\\d{4})\\b",  -- Rust compiler errors
  format = "https://doc.rust-lang.org/error_codes/$1.html",
})
table.insert(config.hyperlink_rules, {
  regex = "\\b([tTdDpPsS]\\d+)\\b",  -- task, diff, paste, sev
  format = "https://fburl.com/b/$1",
})

-- Domains (ie, connection profiles) ------------------------------------------

config.ssh_domains = wezterm.default_ssh_domains()
for _, domain in ipairs(config.ssh_domains) do
  domain.assume_shell = "Posix"
  domain.multiplexing = "None"
end
if hostname == "pbar-mbp" then
  config.default_domain = "SSHMUX:devvm"
end

-- ∎ --------------------------------------------------------------------------

return config
