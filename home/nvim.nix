{ config, ... }:
let
  helpers = config.lib.nixvim;
in
{
  # Previous Neovim config
  # https://github.com/pbar1/dotfiles/tree/c2ca9ff3138ad68f010ff81581a5d2f88f43cc7f/home/nvim
  programs.nixvim = {
    enable = true;

    # Yank to system clipboard
    clipboard.register = "unnamedplus";

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

    # Required for plugins like Telescope and Which-Key
    plugins.web-devicons.enable = true;

    plugins.mini.enable = true;
    plugins.mini.modules = {
      starter = { };
      sessions = { };
    };

    plugins.lualine.enable = true;
    plugins.lualine.settings.options.component_separators = "|";
    plugins.lualine.settings.options.section_separators = "";
    plugins.lualine.settings.options.globalstatus = true;
    plugins.lualine.settings.sections.lualine_b = [
      {
        __unkeyed = "branch";
        icon = "";
      }
      "diff"
      "diagnostics"
    ];
    plugins.lualine.settings.sections.lualine_c = [
      "filename"
      {
        __unkeyed = "lsp_status";
        icon = "";
        symbols.spinner = [
          "⠋"
          "⠙"
          "⠹"
          "⠸"
          "⠼"
          "⠴"
          "⠦"
          "⠧"
          "⠇"
          "⠏"
        ];
        symbols.done = "✓";
        symbols.separator = " ";
        ignore_lsp = [ ];
      }
    ];

    plugins.telescope.enable = true;

    plugins.which-key.enable = true;

    plugins.blink-cmp.enable = true;
    plugins.blink-cmp.settings.signature.enabled = true;
    plugins.blink-cmp.settings.keymap.preset = "enter";
    plugins.blink-cmp.settings.completion.list.selection.preselect = false;
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
    plugins.colorful-menu.enable = true;

    plugins.lsp.enable = true;
    plugins.lsp.servers.nixd.enable = true;
    plugins.rustaceanvim.enable = true;

    plugins.conform-nvim.enable = true;
    plugins.conform-nvim.settings.format_on_save = {
      timeout_ms = 500;
      lsp_format = "fallback";
    };
    plugins.conform-nvim.settings.formatters_by_ft = {
      "*" = [ "injected" ]; # Formats code blocks
      nix = [ "nixfmt" ];
      rust = [ "rustfmt" ];
    };
  };
}
