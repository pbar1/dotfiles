{ ... }:

{
  programs.bash.enable = true;

  programs.atuin.enable = true;
  programs.atuin.flags = [ "--disable-up-arrow" ];
  programs.atuin.settings = {
    auto_sync = true;
    sync_address = "https://atuin.xnauts.net";
    network_timeout = "600";
  };

  programs.zoxide.enable = true;
}
