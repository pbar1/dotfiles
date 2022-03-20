{
  description = "Configuration for NixOS, macOS, and Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";

    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }:
    let
      system = "x86_64-darwin";
      username = "pbartine";
    in
    {
      # nix-darwin (macOS)
      darwinConfigurations."pbartine-ltm.internal.salesforce.com" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [ ./darwin ];
      };

      # Home Manager
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        configuration = import ./home;

        inherit system username;
        homeDirectory = "/Users/${username}"; # TODO: Support Linux

        # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
        stateVersion = "22.05";
      };
    };
}
