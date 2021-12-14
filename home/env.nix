{ config, ... }:

{
  xdg.enable = true;

  home.sessionVariables = {
    GOPATH = "${config.xdg.dataHome}/go";
  };
}
