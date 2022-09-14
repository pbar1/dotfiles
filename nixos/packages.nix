{ pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';

  retroarch = pkgs.retroarch.override {
    cores = with pkgs.libretro; [ sameboy ];
  };
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "googleearth-pro-7.3.4.8248"
  ];

  environment.systemPackages = with pkgs; [
    _1password-gui
    arc-icon-theme
    arc-theme
    caffeine-ng
    chromium
    copyq
    discord
    firefox-wayland
    gnome.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.night-theme-switcher
    gnomeExtensions.pop-shell
    googleearth-pro
    nvidia-offload
    obs-studio
    phinger-cursors
    powertop
    retroarch
    spotify
    sqlitebrowser
    swtpm
    tor
    unzip
    virt-manager
    vlc
    wezterm
    wl-clipboard
    zoom-us
  ];
}
