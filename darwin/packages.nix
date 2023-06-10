{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pinentry_mac
    wezterm
  ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/core"
    ];

    casks = [
      # core
      "1password"
      "amethyst"
      "bartender"
      "clipy"
      "font-iosevka-nerd-font"
      "iterm2"
      "keepingyouawake"
      "logi-options-plus"
      "quicksilver"

      # personal
      "android-file-transfer"
      "brave-browser"
      "discord"
      "docker"
      "google-earth-pro"
      "keka"
      "kekaexternalhelper"
      "qlmarkdown"
      "spotify"
      "syntax-highlight"
      "tailscale"
      "transmission"
      "visual-studio-code"
      "vlc"
    ];
  };
}
