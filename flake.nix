{
  description = "Configuration for NixOS, macOS, and Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # TODO: Waiting for https://github.com/LnL7/nix-darwin/pull/310
    darwin.url = "github:pbar1/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    nvim-config.url = "github:pbar1/nvim-config";
    nvim-config.inputs.nixpkgs.follows = "nixpkgs";

    emacs-overlay.url = "github:nix-community/emacs-overlay";
    emacs-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      overlays = [
        inputs.fenix.overlay
        inputs.nvim-config.overlay
        inputs.emacs-overlay.overlay
      ];
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        modules = [ ./nixos ];
        system = "x86_64-linux";
      };

      darwinConfigurations.default = darwin.lib.darwinSystem {
        modules = [ ./darwin ];
        system = "x86_64-darwin";
      };

      homeConfigurations.bobbery = home-manager.lib.homeManagerConfiguration {
        configuration = import ./home { inherit overlays; };
        stateVersion = "22.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
        system = "x86_64-linux";
        username = "pierce";
        homeDirectory = "/home/pierce";
      };

      homeConfigurations.pbartine-ltm = home-manager.lib.homeManagerConfiguration {
        configuration = import ./home { inherit overlays; };
        stateVersion = "22.05"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
        system = "x86_64-darwin";
        username = "pbartine";
        homeDirectory = "/Users/pbartine";
      };
    };
}
