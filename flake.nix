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
      # FIXME: Broken due to: /run/current-system/sw/bin/darwin-rebuild: line 188: /nix/store/<long hash>/activate-user: No such file or directory
      # nix-darwin (macOS)
      darwinConfigurations."default" = darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [ ./darwin ];
      };

      # Home Manager
      homeConfigurations."default" = home-manager.lib.homeManagerConfiguration {
        configuration = import ./home;

        inherit system username;
        homeDirectory = "/Users/${username}"; # TODO: Support Linux

        # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
        stateVersion = "22.05";
      };
    };
}
