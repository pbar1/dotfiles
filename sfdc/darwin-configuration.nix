{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  users.users.pbartine = {
    name = "pbartine";
    home = "/Users/pbartine";
  };

  # Home Manager
  home-manager.users.pbartine = { pkgs, ... }: {
    home.packages = with pkgs; [
      dive
    ];
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages = with pkgs; [ ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Create /etc/bashrc that loads the nix-darwin environment.
  # programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
