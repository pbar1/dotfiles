{ pkgs, ... }: {
  xdg.configFile."nvim/init.lua".source = ./init.lua;
  xdg.configFile."nvim/lua".source = ./lua;

  # programs.neovim = { };
}
