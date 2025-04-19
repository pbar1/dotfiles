{ config, ... }:
let
  inherit (config.lib.nixvim) listToUnkeyedAttrs;
in
{
  # Previous Neovim config: https://github.com/pbar1/dotfiles/tree/c2ca9ff3138ad68f010ff81581a5d2f88f43cc7f/home/nvim
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
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>qq";
        action = "<cmd>q!<cr>";
        options.desc = "Force quit without save";
      }
      {
        mode = "n";
        key = "<leader>qx";
        action = "<cmd>x<cr>";
        options.desc = "Save and quit";
      }
      {
        mode = "i";
        key = "<M-BS>";
        action = "<C-w>";
        options.desc = "Delete word backwards";
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
    plugins.lualine.settings.options.component_separators = "|";
    plugins.lualine.settings.options.section_separators = "";
    plugins.lualine.settings.options.globalstatus = true;

    plugins.telescope.enable = true;

    plugins.which-key.enable = true;

    plugins.blink-cmp.enable = true;
    plugins.blink-cmp.settings.signature.enabled = true;
    plugins.blink-cmp.settings.completion.list.selection.preselect = false; # TODO: Enable for VSCode behavior
    plugins.blink-cmp.settings.completion.menu.draw.__raw = ''
      {
      columns = { { "kind_icon" }, { "label", gap = 1 } },
      components = {
        label = {
          text = function(ctx)
            return require("colorful-menu").blink_components_text(ctx)
          end,
          highlight = function(ctx)
            return require("colorful-menu").blink_components_highlight(ctx)
          end,
        },
      },
      }
    '';
    plugins.blink-cmp.settings.keymap.preset = "enter";
    plugins.colorful-menu.enable = true;

    # LSP servers
    plugins.lsp.enable = true;
    plugins.lsp.servers.nixd.enable = true;
    plugins.rustaceanvim.enable = true;
  };
}
