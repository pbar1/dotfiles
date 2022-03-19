{ config, pkgs, ... }:

{
  imports = [
    ./env.nix
    ./packages.nix
    ./tmux.nix
    ./fish.nix
    ./starship.nix
  ];

  nixpkgs.config.allowUnfree = true;

  home.file.".gnupg/gpg-agent.conf".text = ''
    enable-ssh-support
    pinentry-program /usr/local/bin/pinentry-mac
  '';
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
