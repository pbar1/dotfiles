{ pkgs, ... }:

# FIXME: Only activate on macOS
{
  home.file.".hammerspoon/init.lua".source = ./init.lua;

  # TODO: Resolve Spoon packages dynamically
  home.file.".hammerspoon/Spoons/ReloadConfiguration.spoon".source = pkgs.myHammerspoonPlugins.ReloadConfiguration.src;
  home.file.".hammerspoon/Spoons/Seal.spoon".source = pkgs.myHammerspoonPlugins.Seal.src;
}
