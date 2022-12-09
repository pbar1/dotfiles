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
      "1password"
      "amethyst"
      "bartender"
      "brave-browser"
      "clipy"
      "discord"
      "font-iosevka-nerd-font"
      "iterm2"
      "keepingyouawake"
      "qlmarkdown"
      "syntax-highlight"
      "unnaturalscrollwheels"
    ];
  };
}
