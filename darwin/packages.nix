{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pinentry_mac
    alacritty
  ];

  homebrew = {
    enable = true;
    autoUpdate = false;
    cleanup = "none"; # FIXME: When all packages are tracked here, set to "zap"
    global.brewfile = true;
    global.noLock = true;

    # taps = [];

    # brews = [];

    casks = [
      "1password"
      "aerial"
      "amethyst"
      "clipy"
      "wezterm"
      "wireshark"
      "karabiner-elements"
    ];

    # masApps = [];
  };
}
