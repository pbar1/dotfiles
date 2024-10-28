{ config, pkgs, ... }:

let
  home = config.home.homeDirectory;
  configHome = config.xdg.configHome;
  dataHome = config.xdg.dataHome;
  cacheHome = config.xdg.cacheHome;
in
{
  xdg.enable = true;

  home.sessionPath = [
    "${home}/.local/bin"
  ];
}
