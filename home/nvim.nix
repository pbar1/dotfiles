{ ... }:

{
  programs.nixvim = {
    enable = true;
    colorschemes.gruvbox.enable = true;
    plugins.lualine.enable = true;
    plugins.telescope.enable = true;
    plugins.which-key.enable = true;
    plugins.web-devicons.enable = true; # required for telescope
  };
}
