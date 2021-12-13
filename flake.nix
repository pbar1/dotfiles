{
  description = "Pierce's Nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable-darwin";
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, darwin, nixpkgs }: {
    darwinConfigurations."pbartine-ltm" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [ ./macos ];
    };
  };
}

