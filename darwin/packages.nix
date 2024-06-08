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
      "cyberduck"
      "docker"
      "google-earth-pro"
      "keka"
      "kekaexternalhelper"
      "little-snitch"
      "minecraft"
      "spotify"
      "visual-studio-code"
      "vlc"
      "wireshark"
    ];
  };
}
