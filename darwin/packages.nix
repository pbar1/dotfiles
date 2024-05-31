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
      "bartender"
      "font-iosevka-nerd-font"
      "hammerspoon"
      "logi-options-plus"
      "maccy"
      "wezterm"

      # personal
      "android-file-transfer"
      "anki"
      "brave-browser"
      "cyberduck"
      "docker"
      "google-earth-pro"
      "keka"
      "kekaexternalhelper"
      "little-snitch"
      "minecraft"
      "qlmarkdown"
      "spotify"
      "syntax-highlight"
      "tailscale"
      "visual-studio-code"
      "vlc"
      "wireshark"
    ];
  };
}
