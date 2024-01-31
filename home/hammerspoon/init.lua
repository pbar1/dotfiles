local cmd = { "cmd" }
local shift_cmd = { "shift", "cmd" }
local ctrl_alt = { "ctrl", "alt" }

-- Hammerspoon config options
hs.autoLaunch(true)
hs.automaticallyCheckForUpdates(false)

-- Reload configuration on save
hs.loadSpoon("ReloadConfiguration")
spoon.ReloadConfiguration:start()

-- Launch bar
hs.loadSpoon("Seal")
spoon.Seal:loadPlugins({ "apps", "calc", "useractions", "screencapture" })
spoon.Seal:bindHotkeys({
   toggle = { cmd, "Space" },
})
spoon.Seal.plugins.apps.appSearchPaths = {
   "/System/Applications",
   "/Applications",
   "~/Applications",
   "/System/Library/PreferencePanes",
   "/Library/PreferencePanes",
   "~/Library/PreferencePanes",
   "/System/Library/CoreServices/Applications",
   "/System/Library/CoreServices/",
   -- "/Library/Scripts",
   "~/Library/Scripts",
   "~/code/dotfiles/scripts",
}
spoon.Seal.plugins.apps:restart()
-- TODO: use `vscode://file/<path>` to make a launcher, or just `code` cli which opens in new window
spoon.Seal.plugins.useractions.actions = {
   ["Sonarr"] = {
      url = "https://sonarr.xnauts.net",
      icon = "favicon",
      keyword = "sonarr",
   },
}
spoon.Seal:start()

-- Menu bar applet to keep display awake
hs.loadSpoon("Caffeine")
spoon.Caffeine:bindHotkeys({
   toggle = { ctrl_alt, "c" },
})
spoon.Caffeine:start()

-- Keybindings cheatsheet for current app
hs.loadSpoon("KSheet")
spoon.KSheet:bindHotkeys({
   toggle = { ctrl_alt, "/" },
})
spoon.KSheet:init()

-- TODO: Toggle terminal

-- Display a notification when this config has been loaded
hs.alert.show("Hammerspoon config loaded")
