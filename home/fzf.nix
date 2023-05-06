{ config, pkgs, ... }:

{
  programs.fzf = {
    enable = true;

    enableFishIntegration = false;

    defaultCommand = "fd --type=file --exclude=.git --hidden --follow";
  };
}
