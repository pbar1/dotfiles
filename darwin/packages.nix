{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pinentry_mac
  ];

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

    casks = [
      # core
      "1password"
      "amethyst"
      "bartender"
      "font-iosevka-nerd-font"
      "iterm2-beta"
      "keepingyouawake"
      "logi-options-plus"
      "maccy"
      "quicksilver"

      # personal
      "android-file-transfer"
      "brave-browser"
      "discord"
      "docker"
      "google-earth-pro"
      "keka"
      "kekaexternalhelper"
      "little-snitch"
      "qlmarkdown"
      "slack"
      "spotify"
      "syntax-highlight"
      "tailscale"
      "transmission"
      "vagrant"
      "visual-studio-code"
      "vlc"
    ];
  };
}
