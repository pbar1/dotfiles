{ ... }:

{
  homebrew.enable = true;
  homebrew.onActivation.cleanup = "zap";

  homebrew.taps = [
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/services"
  ];

  homebrew.brews = [ ];

  homebrew.casks =
    # Core
    [
      "1password"
      "amethyst"
      "bettermouse"
      "font-iosevka-nerd-font"
      "hammerspoon"
      "jordanbaird-ice"
      "keepingyouawake"
      "maccy"
      "wezterm"
    ]
    # Personal machine
    ++ [
      "brave-browser"
      "calibre"
      "cyberduck"
      "docker"
      "google-earth-pro"
      "keka"
      "kekaexternalhelper"
      "lulu"
      "netspot"
      "slack"
      "spotify"
      "syntax-highlight"
      "tailscale"
      "visual-studio-code"
      "vlc"
      "wireshark"
      "zoom"
    ];
}
