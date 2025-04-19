{ ... }:

{
  programs.nixvim = {
    enable = true;

    clipboard.register = "unnamedplus"; # yank to system clipboard
    globals.mapleader = " ";
    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find files";
      }
    ];

    colorschemes.gruvbox.enable = true;

    plugins.web-devicons.enable = true; # required for telescope

    plugins.mini.enable = true;
    plugins.mini.modules = {
      starter = { };
      sessions = { };
    };

    plugins.lualine.enable = true;

    plugins.telescope.enable = true;

    plugins.which-key.enable = true;

    plugins.blink-cmp.enable = true;
  };
}
