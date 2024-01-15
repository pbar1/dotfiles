{ pkgs, lib, ... }:

{
  home.file.".hammerspoon/init.lua".source = ./init.lua;

  # TODO: Resolve Spoons packages dynamically
  home.file.".hammerspoon/Spoons/Caffeine.spoon".source = pkgs.myHammerspoonPlugins.Caffeine.src;
  home.file.".hammerspoon/Spoons/KSheet.spoon".source = pkgs.myHammerspoonPlugins.KSheet.src;
  home.file.".hammerspoon/Spoons/ReloadConfiguration.spoon".source = pkgs.myHammerspoonPlugins.ReloadConfiguration.src;
  home.file.".hammerspoon/Spoons/Seal.spoon".source = pkgs.myHammerspoonPlugins.Seal.src;
}
