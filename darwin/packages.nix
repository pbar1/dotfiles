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

      # personal
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
      "visual-studio-code"
    ];
  };
}
