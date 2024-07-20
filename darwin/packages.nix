{ pkgs, ... }:

{
  # environment.systemPackages = with pkgs; [ ];

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
      "sapling" # FIXME: temporary
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
      "font-fontawesome"
      "font-roboto"
      "font-source-sans-3"
      "google-earth-pro"
      "keka"
      "kekaexternalhelper"
      "little-snitch"
      "minecraft"
      "spotify"
      "syntax-highlight"
      "visual-studio-code"
      "vlc"
      "wireshark"
    ];
  };
}
