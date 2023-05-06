{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    history.size = 10000000;
  };
}

# vim: set syntax=nix:
