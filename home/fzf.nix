{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;

    enableFishIntegration = false;
    enableZshIntegration = false;

    defaultCommand = "fd --type=file --exclude=.git --hidden --follow";
  };

  programs.atuin = {
    enable = true;
  };
}
