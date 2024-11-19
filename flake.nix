{
  description = "Configuration for NixOS, macOS, and Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    home-manager.url = "github:nix-community/home-manager";
    nixvim.url = "github:nix-community/nixvim";

    darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    # Zsh Plugins -------------------------------------------------------------

    "zsh:zsh-abbr" = {
      url = "github:olets/zsh-abbr";
      flake = false;
    };
    "zsh:zsh-autopair" = {
      url = "github:hlissner/zsh-autopair";
      flake = false;
    };

    # Fish Plugins ------------------------------------------------------------

    "fish:plugin-bang-bang" = {
      url = "github:oh-my-fish/plugin-bang-bang";
      flake = false;
    };

    # Hammerspoon Plugins -----------------------------------------------------

    "spoon:ReloadConfiguration" = {
      url = "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/ReloadConfiguration.spoon.zip";
      flake = false;
    };
    "spoon:Seal" = {
      url = "https://github.com/Hammerspoon/Spoons/raw/master/Spoons/Seal.spoon.zip";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      darwin,
      home-manager,
      nixos-wsl,
      nixvim,
      ...
    }@inputs:
    let
      overlays = [
        (final: prev: {

          myZshPlugins =
            with final.lib;
            with attrsets;
            with strings;
            mapAttrs' (
              name: value:
              nameValuePair (removePrefix "zsh:" name) {
                name = removePrefix "zsh:" name;
                src = value.outPath;
              }
            ) (filterAttrs (name: _: hasPrefix "zsh:" name) inputs);

          myFishPlugins =
            with final.lib;
            with attrsets;
            with strings;
            mapAttrs' (
              name: value:
              nameValuePair (removePrefix "fish:" name) (
                final.fishPlugins.buildFishPlugin {
                  pname = removePrefix "fish:" name;
                  src = value.outPath;
                  version = value.rev;
                }
              )
            ) (filterAttrs (name: _: hasPrefix "fish:" name) inputs);

          myHammerspoonPlugins =
            with final.lib;
            with attrsets;
            with strings;
            mapAttrs' (
              name: value:
              nameValuePair (removePrefix "spoon:" name) {
                name = removePrefix "spoon:" name;
                src = value.outPath;
              }
            ) (filterAttrs (name: _: hasPrefix "spoon:" name) inputs);

        }) # END final: prev:
      ]; # END overlays
    in
    {

      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        modules = [
          nixos-wsl.nixosModules.default
          {
            system.stateVersion = "24.05";
            wsl.enable = true;
            wsl.defaultUser = "nixos";
          }
        ];
        system = "x86_64-linux";
      };

      nixosConfigurations."tec" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos-tec
          home-manager.nixosModules.home-manager
        ];
      };

      # FIXME: Figure why hostname now must be "Mac"
      darwinConfigurations."Mac" = darwin.lib.darwinSystem {
        modules = [ ./darwin ];
        system = "aarch64-darwin";
      };

      # FIXME: Figure why hostname now must be "Mac"
      homeConfigurations."Mac" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        modules = [
          (
            { config, pkgs, ... }:
            {
              nixpkgs.overlays = overlays;
            }
          )
          nixvim.homeManagerModules.nixvim
          ./home
        ];
      };

    }; # END outputs
} # END flake
