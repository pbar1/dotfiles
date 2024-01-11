{ pkgs, ... }:

{
  # environment.systemPackages = with pkgs; [ ];

  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";

    taps = [
      "d12frosted/emacs-plus"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-fonts"
      "homebrew/cask-versions"
      "homebrew/core"
    ];

    brews = [
      "openssl"
      { name = "d12frosted/emacs-plus/emacs-plus"; args = [ "with-native-comp" ]; }
    ];

    casks = [
      # core
      "1password"
      "alfred"
      "amethyst"
      "bartender"
      "font-iosevka-nerd-font"
      "keepingyouawake"
      "logi-options-plus"
      "maccy"
      "wezterm"

      # personal
      "android-file-transfer"
      "brave-browser"
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
      "vagrant"
      "visual-studio-code"
      "vlc"
      "wireshark"
    ];
  };
}
