{ ... }:

{
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
    ];

    brews = [
      "openssl"
    ];

    casks = [
      # core
      "1password"
      "amethyst"
      "font-iosevka-nerd-font"
      "hammerspoon"
      "jordanbaird-ice"
      "logi-options-plus"
      "maccy"
      "wezterm"

      # personal
      "anki"
      "brave-browser"
      "calibre"
      "cyberduck"
      "docker"
      "google-earth-pro"
      "keka"
      "kekaexternalhelper"
      "little-snitch"
      "minecraft"
      "spotify"
      "syntax-highlight"
      "tailscale"
      "visual-studio-code"
      "vlc"
      "wireshark"
    ];
  };
}
