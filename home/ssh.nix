{ pkgs, ... }:
let
  toTOML = (pkgs.formats.toml { }).generate "dummy";

  identityAgent =
    if pkgs.stdenv.isDarwin then
      "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    else
      null;
in
{
  programs.ssh.enable = true;

  programs.ssh.enableDefaultConfig = false;

  programs.ssh.matchBlocks."*" = {
    inherit identityAgent;
  };

  programs.ssh.matchBlocks."github.com" = {
    user = "git";
    hostname = "github.com";
    identityFile = "~/.ssh/github.pub";
    identitiesOnly = true;
  };

  programs.ssh.matchBlocks."tec" = {
    user = "nixos";
    hostname = "tec";
  };

  programs.ssh.matchBlocks."ha" = {
    user = "root";
    hostname = "yellow";
  };

  programs.ssh.matchBlocks."haos" = {
    user = "root";
    hostname = "yellow";
    port = 22222;
  };

  # Select subset of keys from 1Password agent and set their ordering
  xdg.configFile."1Password/ssh/agent.toml".source = toTOML {
    ssh-keys = [
      { item = "SSH Personal"; }
      { item = "SSH GitHub"; }
    ];
  };
}
