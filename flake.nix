{
  description = "Configuration for NixOS, macOS, and Home Manager";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    darwin = { url = "github:LnL7/nix-darwin"; inputs.nixpkgs.follows = "nixpkgs"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };

    # Zsh Plugins -------------------------------------------------------------

    "zsh:zsh-abbr" = { url = "github:olets/zsh-abbr"; flake = false; };
    "zsh:zsh-autopair" = { url = "github:hlissner/zsh-autopair"; flake = false; };

    # Fish Plugins ------------------------------------------------------------

    "fish:autopair.fish" = { url = "github:jorgebucaran/autopair.fish"; flake = false; };
    "fish:base16-fish-shell" = { url = "github:FabioAntunes/base16-fish-shell"; flake = false; };
    "fish:bass" = { url = "github:edc/bass"; flake = false; };
    "fish:fzf.fish" = { url = "github:PatrickF1/fzf.fish"; flake = false; };
    "fish:plugin-bang-bang" = { url = "github:oh-my-fish/plugin-bang-bang"; flake = false; };

    # Hammerspoon Plugins -----------------------------------------------------

    "spoon:Caffeine" = { url = "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/Caffeine.spoon.zip"; flake = false; };
    "spoon:ClipboardTool" = { url = "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/ClipboardTool.spoon.zip"; flake = false; };
    "spoon:KSheet" = { url = "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/KSheet.spoon.zip"; flake = false; };
    "spoon:ReloadConfiguration" = { url = "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/ReloadConfiguration.spoon.zip"; flake = false; };
    "spoon:Seal" = { url = "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/Seal.spoon.zip"; flake = false; };
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      overlays = [
        (final: prev: {

          myZshPlugins = with final.lib; with attrsets; with strings; mapAttrs'
            (name: value: nameValuePair (removePrefix "zsh:" name) {
              name = removePrefix "zsh:" name;
              src = value.outPath;
            })
            (filterAttrs (name: _: hasPrefix "zsh:" name) inputs);

          myFishPlugins = with final.lib; with attrsets; with strings; mapAttrs'
            (name: value: nameValuePair (removePrefix "fish:" name) (final.fishPlugins.buildFishPlugin {
              pname = removePrefix "fish:" name;
              src = value.outPath;
              version = value.rev;
            }))
            (filterAttrs (name: _: hasPrefix "fish:" name) inputs);

          myHammerspoonPlugins = with final.lib; with attrsets; with strings; mapAttrs'
            (name: value: nameValuePair (removePrefix "spoon:" name) {
              name = removePrefix "spoon:" name;
              src = value.outPath;
            })
            (filterAttrs (name: _: hasPrefix "spoon:" name) inputs);

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
