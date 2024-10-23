{ lib, ... }:

{
  imports = [
    ./env.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./gpg.nix
    ./hammerspoon
    ./packages.nix
    ./starship.nix
    ./tmux.nix
    ./wezterm
    ./zsh.nix
  ];

  # https://github.com/nix-community/home-manager/issues/2942#issuecomment-1119760100
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  programs.home-manager.enable = true;

  # Fish shell enables this for `man` completion to work, but it is very slow
  # https://github.com/NixOS/nixpkgs/issues/100288
  programs.man.generateCaches = lib.mkForce false;

  programs.zoxide.enable = true;

  # Theme set with environment variable BAT_THEME since Delta also uses it
  programs.bat.enable = true;
  programs.bat.config.style = "plain";
}
