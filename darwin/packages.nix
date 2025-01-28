{ ... }:

{

  homebrew.enable = true;
  homebrew.onActivation.cleanup = "zap";

  homebrew.taps = [
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
  ];

  homebrew.brews = [
    "openssl" # Makes compiling Rust native-tls deps easier
  ];

  # First set applies to all machines, second is for daily driver only
  homebrew.casks =
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
    ++ [
      "brave-browser"
      "calibre"
      "cyberduck"
      "docker"
      "ghostty"
      "google-earth-pro"
      "keka"
      "kekaexternalhelper"
      "lulu"
      "obsidian"
      "qmk-toolbox"
      "spotify"
      "syntax-highlight"
      "tailscale"
      "visual-studio-code"
      "vlc"
      "wireshark"
      "zoom"
    ];
}
