local cmd = { "cmd" }
local shift_cmd = { "shift", "cmd" }
local ctrl_alt = { "ctrl", "alt" }

---@param folder string
local function open_in_vscode(folder)
   os.execute("/usr/local/bin/code '" .. folder .. "'")
end

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
-- TODO: Mutate rather than override
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
spoon.Seal.plugins.useractions.actions = {
   ["Open folder in VS Code"] = {
      keyword = "code",
      fn = function()
         local chooser = hs.chooser.new(function(choice)
            if choice then
               open_in_vscode(choice.text)
            end
         end)
         -- TODO: Populate by listing ~/code
         chooser:choices({
            { ["text"] = "/Users/pierce/code/dotfiles" },
            { ["text"] = "/Users/pierce/code/pbcloud" },
         })
         chooser:show()
      end,
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
