{ ... }:

let
  # FIXME: No hardcode
  IdentityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
in

{
  programs.ssh.enable = true;

  programs.ssh.matchBlocks."*".extraOptions = {
    inherit IdentityAgent;
  };

  programs.ssh.matchBlocks."tec" = {
    user = "nixos";
    hostname = "tec.lan";
  };

  programs.ssh.matchBlocks."frankly" = {
    user = "root";
    hostname = "frankly.lan";
  };

  programs.ssh.matchBlocks."github.com" = {
    user = "git";
    hostname = "github.com";
    identityFile = "~/.ssh/github.pub";
    identitiesOnly = true;
  };
}
