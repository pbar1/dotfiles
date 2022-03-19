{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, ... }:
    let
      system = "x86_64-darwin";
      username = "pbartine";
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        configuration = import ./home/default.nix;

        inherit system username;
        homeDirectory = "/Users/${username}"; # TODO: Support Linux

        # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
        stateVersion = "22.05";
      };
    };
}
