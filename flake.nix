{
  description = "Configuration for NixOS, macOS, and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin.url = "github:LnL7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # home-manager.url = "github:nix-community/home-manager";
    home-manager.url = "github:pbar1/home-manager/c47a931"; # TODO: Await merge
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Overlays ----------------------------------------------------------------

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # Zsh Plugins -------------------------------------------------------------

    "zsh:zsh-abbr" = { url = "github:olets/zsh-abbr"; flake = false; };

    # Fish Plugins ------------------------------------------------------------

    "fish:autopair.fish" = { url = "github:jorgebucaran/autopair.fish"; flake = false; };
    "fish:base16-fish-shell" = { url = "github:FabioAntunes/base16-fish-shell"; flake = false; };
    "fish:bass" = { url = "github:edc/bass"; flake = false; };
    "fish:fzf.fish" = { url = "github:PatrickF1/fzf.fish"; flake = false; };
    "fish:plugin-bang-bang" = { url = "github:oh-my-fish/plugin-bang-bang"; flake = false; };

    # Neovim Plugins ----------------------------------------------------------

    "vim:Comment.nvim" = { url = "github:numToStr/Comment.nvim"; flake = false; };
    "vim:alpha-nvim" = { url = "github:goolord/alpha-nvim"; flake = false; };
    "vim:auto-session" = { url = "github:rmagatti/auto-session"; flake = false; };
    "vim:barbar.nvim" = { url = "github:romgrk/barbar.nvim"; flake = false; };
    "vim:cmp-buffer" = { url = "github:hrsh7th/cmp-buffer"; flake = false; };
    "vim:cmp-cmdline" = { url = "github:hrsh7th/cmp-cmdline"; flake = false; };
    "vim:cmp-emoji" = { url = "github:hrsh7th/cmp-emoji"; flake = false; };
    "vim:cmp-nvim-lsp" = { url = "github:hrsh7th/cmp-nvim-lsp"; flake = false; };
    "vim:cmp-nvim-lsp-signature-help" = { url = "github:hrsh7th/cmp-nvim-lsp-signature-help"; flake = false; };
    "vim:cmp-nvim-lua" = { url = "github:hrsh7th/cmp-nvim-lua"; flake = false; };
    "vim:cmp-path" = { url = "github:hrsh7th/cmp-path"; flake = false; };
    "vim:cmp-treesitter" = { url = "github:ray-x/cmp-treesitter"; flake = false; };
    "vim:cmp-vsnip" = { url = "github:hrsh7th/cmp-vsnip"; flake = false; };
    "vim:editorconfig-vim" = { url = "github:editorconfig/editorconfig-vim"; flake = false; };
    "vim:filetype.nvim" = { url = "github:nathom/filetype.nvim"; flake = false; };
    "vim:gitsigns.nvim" = { url = "github:lewis6991/gitsigns.nvim"; flake = false; };
    "vim:gruvbox-material" = { url = "github:sainnhe/gruvbox-material"; flake = false; };
    "vim:lightspeed.nvim" = { url = "github:ggandor/lightspeed.nvim"; flake = false; };
    "vim:lsp_signature.nvim" = { url = "github:ray-x/lsp_signature.nvim"; flake = false; };
    "vim:lspkind.nvim" = { url = "github:onsails/lspkind.nvim"; flake = false; };
    "vim:lualine.nvim" = { url = "github:nvim-lualine/lualine.nvim"; flake = false; };
    "vim:null-ls.nvim" = { url = "github:jose-elias-alvarez/null-ls.nvim"; flake = false; };
    "vim:nvim-autopairs" = { url = "github:windwp/nvim-autopairs"; flake = false; };
    "vim:nvim-cmp" = { url = "github:hrsh7th/nvim-cmp"; flake = false; };
    "vim:nvim-colorizer.lua" = { url = "github:norcalli/nvim-colorizer.lua"; flake = false; };
    "vim:nvim-gps" = { url = "github:SmiteshP/nvim-gps"; flake = false; };
    "vim:nvim-lspconfig" = { url = "github:neovim/nvim-lspconfig"; flake = false; };
    "vim:nvim-notify" = { url = "github:rcarriga/nvim-notify"; flake = false; };
    "vim:nvim-tree.lua" = { url = "github:kyazdani42/nvim-tree.lua"; flake = false; };
    "vim:nvim-treesitter-textobjects" = { url = "github:nvim-treesitter/nvim-treesitter-textobjects"; flake = false; };
    "vim:nvim-treesitter-textsubjects" = { url = "github:RRethy/nvim-treesitter-textsubjects"; flake = false; };
    "vim:nvim-web-devicons" = { url = "github:kyazdani42/nvim-web-devicons"; flake = false; };
    "vim:plenary.nvim" = { url = "github:nvim-lua/plenary.nvim"; flake = false; };
    "vim:rust-tools.nvim" = { url = "github:simrat39/rust-tools.nvim"; flake = false; };
    "vim:session-lens" = { url = "github:rmagatti/session-lens"; flake = false; };
    "vim:spellsitter.nvim" = { url = "github:lewis6991/spellsitter.nvim"; flake = false; };
    "vim:telescope-fzf-native.nvim" = { url = "github:nvim-telescope/telescope-fzf-native.nvim"; flake = false; };
    "vim:telescope-ui-select.nvim" = { url = "github:nvim-telescope/telescope-ui-select.nvim"; flake = false; };
    "vim:telescope-zoxide" = { url = "github:jvgrootveld/telescope-zoxide"; flake = false; };
    "vim:telescope.nvim" = { url = "github:nvim-telescope/telescope.nvim"; flake = false; };
    "vim:trouble.nvim" = { url = "github:folke/trouble.nvim"; flake = false; };
    "vim:undotree" = { url = "github:mbbill/undotree"; flake = false; };
    "vim:vim-lastplace" = { url = "github:farmergreg/vim-lastplace"; flake = false; };
    "vim:vim-numbertoggle" = { url = "github:jeffkreeftmeijer/vim-numbertoggle"; flake = false; };
    "vim:vim-signify" = { url = "github:mhinz/vim-signify"; flake = false; };
    "vim:vim-startuptime" = { url = "github:dstein64/vim-startuptime"; flake = false; };
    "vim:vim-vsnip" = { url = "github:hrsh7th/vim-vsnip"; flake = false; };
    "vim:which-key.nvim" = { url = "github:folke/which-key.nvim"; flake = false; };
    #"vim:meta.nvim" = { url = "path:/usr/share/fb-editor-support/nvim"; flake = false; };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        (final: prev: {
          myNeovimPlugins = with final.lib; with attrsets; with strings; mapAttrs'
            (name: value: nameValuePair (removePrefix "vim:" name) (final.vimUtils.buildVimPluginFrom2Nix {
              name = removePrefix "vim:" name;
              pname = removePrefix "vim:" name;
              src = value.outPath;
              namePrefix = "";
              buildPhase = if hasInfix "fzf-native" name then "make" else ":";
            }))
            (filterAttrs (name: _: hasPrefix "vim:" name) inputs);

          myFishPlugins = with final.lib; with attrsets; with strings; mapAttrs'
            (name: value: nameValuePair (removePrefix "fish:" name) (final.fishPlugins.buildFishPlugin {
              pname = removePrefix "fish:" name;
              src = value.outPath;
              version = value.rev;
            }))
            (filterAttrs (name: _: hasPrefix "fish:" name) inputs);
        }) # END final: prev:
      ]; # END overlays
    in
    {
      nixosConfigurations."bobbery" = nixpkgs.lib.nixosSystem {
        modules = [ ./nixos ];
        system = "x86_64-linux";
      };

      nixosConfigurations."tec" = nixpkgs.lib.nixosSystem {
        modules = [ ./nixos-tec ];
        system = "x86_64-linux";
      };

      darwinConfigurations."pbar-mbp" = darwin.lib.darwinSystem {
        modules = [ ./darwin ];
        system = "aarch64-darwin";
      };

      darwinConfigurations."bobbery" = darwin.lib.darwinSystem {
        modules = [ ./darwin ];
        system = "aarch64-darwin";
      };

      homeConfigurations."bobbery-wsl" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        modules = [
          ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
          ./home
          {
            home.username = "pierce";
            home.homeDirectory = "/home/pierce";
            home.stateVersion = "22.05";
          }
        ];
      };


      homeConfigurations."bobbery" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        modules = [
          ({ config, pkgs, ... }: { nixpkgs.overlays = overlays; })
          ./home
          {
            home.username = "pierce";
            home.homeDirectory = "/Users/pierce";
            home.stateVersion = "22.05";
          }
        ];
      };

    }; # END outputs
} # END flake
