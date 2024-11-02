{ ... }:

{
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    plugins.lualine.enable = true;
  };
}
