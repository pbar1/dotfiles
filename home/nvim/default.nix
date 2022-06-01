{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = false;
    withRuby = false;
    withPython3 = true;

    # Simulate using an init.lua
    extraConfig = "lua << EOF\n${builtins.readFile ./init.lua}\nEOF\n";

    # All plugins will be `start` and thus not need `packadd`
    plugins = with pkgs.vimPlugins; [
      (nvim-treesitter.withPlugins (plugins: with pkgs.tree-sitter-grammars; [
        tree-sitter-c
        tree-sitter-cpp
        tree-sitter-rust
        tree-sitter-go
        tree-sitter-python
        tree-sitter-lua
        # tree-sitter-nix # TODO: broken
      ]))
    ] ++ pkgs.lib.attrsets.mapAttrsToList (_: value: value) pkgs.neovimPlugins;

    extraPackages = with pkgs; [ gcc ];
  };

  xdg.configFile."nvim/lua/config".source = ./lua/config;
}
