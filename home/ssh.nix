{ ... }:

let
  # FIXME: No hardcode
  IdentityAgent = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
in

{
  programs.ssh.enable = true;
  programs.ssh.matchBlocks."tec".extraOptions = {
    User = "nixos";
    Hostname = "tec.lan";
  };
  programs.ssh.matchBlocks."frankly".extraOptions = {
    User = "root";
    Hostname = "frankly.lan";
  };
  programs.ssh.matchBlocks."*".extraOptions = {
    inherit IdentityAgent;
  };
}
