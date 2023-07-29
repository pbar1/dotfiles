{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = false;
    withRuby = false;
    withPython3 = false;

    # Use Neovim nightly build from overlay
    # package = pkgs.neovim-nightly;

    # Simulate using an init.lua
    extraConfig = "lua << EOF\n${builtins.readFile ./init.lua}\nEOF\n";

    # All plugins will be `start` and thus not need `packadd`
    plugins = with pkgs.vimPlugins; [
      # (nvim-treesitter.withPlugins (_: pkgs.tree-sitter.allGrammars))
      nvim-treesitter.withAllGrammars
    ] ++ pkgs.lib.attrsets.mapAttrsToList (_: value: value) pkgs.myNeovimPlugins;

    extraPackages = with pkgs; [ gcc ];
  };

  xdg.configFile."nvim/lua/config".source = ./lua/config;
}
