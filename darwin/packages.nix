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

  homebrew.brews = [
    "ollama"
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
      "google-earth-pro"
      "keepassxc"
      "keka"
      "kekaexternalhelper"
      "lulu"
      "qmk-toolbox"
      "spotify"
      "syntax-highlight"
      "tailscale"
      "thunderbird"
      "visual-studio-code"
      "vlc"
      "wireshark"
      "zoom"
    ];
}
