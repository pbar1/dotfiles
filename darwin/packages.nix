{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wireshark
  ];

  homebrew.enable = true;
  homebrew.onActivation.cleanup = "zap";

  homebrew.taps = [
    "homebrew/services"
  ];

  homebrew.brews = [
    "openssl"
    "pkg-config"
  ];

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
      "google-earth-pro"
      "keka"
      "kekaexternalhelper"
      "lulu"
      "netspot"
      "obsidian"
      "secretive"
      "slack"
      "spotify"
      "syntax-highlight"
      "tailscale"
      "visual-studio-code"
      "vlc"
      "zoom"
    ];
}
