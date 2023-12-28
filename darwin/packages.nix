{ pkgs, ... }:

{
  # environment.systemPackages = with pkgs; [ ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/core"
    ];

    brews = [
      "openssl"
    ];

    casks = [
      # core
      "1password"
      "alfred"
      "amethyst"
      "bartender"
      "font-iosevka-nerd-font"
      "iterm2-beta"
      "keepingyouawake"
      "logi-options-plus"
      "maccy"
      "wezterm"

      # personal
      "android-file-transfer"
      "brave-browser"
      "discord"
      "docker"
      "google-earth-pro"
      "keka"
      "kekaexternalhelper"
      "little-snitch"
      "minecraft"
      "obsidian"
      "qlmarkdown"
      "slack"
      "spotify"
      "syntax-highlight"
      "tailscale"
      "transmission"
      "vagrant"
      "visual-studio-code"
      "vlc"
      "wireshark"
    ];
  };
}
