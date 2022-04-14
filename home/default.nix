{ config, lib, packages, overlays }:

{
  imports = [
    ../modules/languages/go.nix

    ./env.nix
    ./packages.nix
    ./tmux.nix
    ./fish.nix
    ./starship.nix
    ./git.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
    inherit overlays;
  };

  home.file.".gnupg/sshcontrol".text = ''
    # personal
    CDCD1DF93F65BF132EB1F33327E34108F53BD47A
    # work
    34DC36A515AA457BF44D8DE158FE03774C6554A0
  '';

  # https://github.com/nix-community/home-manager/tree/master/modules/programs
  programs.home-manager.enable = true;
  programs.zoxide.enable = true;

  programs.bat = {
    enable = true;
    config = {
      style = "plain";
      theme = "base16-256";
    };
  };
}
