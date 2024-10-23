{ pkgs, ... }:

let
  shellAliases = import ./shell/aliases.nix { inherit pkgs; };
  shellAbbrs = import ./shell/abbrs.nix;
in
{
  programs.fish = {
    enable = true;

    inherit shellAbbrs;
    inherit shellAliases;

    # Flake inputs with the prefix `fish:` automatially end up here via overlay
    plugins = with pkgs.fishPlugins; [
      { inherit (fzf-fish) name src; }
      { inherit (autopair) name src; }
    ] ++ pkgs.lib.attrsets.mapAttrsToList
      (name: value: {
        inherit name;
        inherit (value) src;
      })
      pkgs.myFishPlugins;

    interactiveShellInit = ''
      set fish_greeting
    '';
  };
}
