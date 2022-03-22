{ ... }:

{
  homebrew = {
    enable = true;
    autoUpdate = false;
    cleanup = "none"; # FIXME: When all packages are tracked here, set to "zap"
    global.brewfile = true;
    global.noLock = true;

    taps = [];

    brews = [];

    casks = [
      "wireshark"
    ];

    masApps = [];
  };
}
