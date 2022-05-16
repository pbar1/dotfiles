{ pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "googleearth-pro-7.3.4.8248"
  ];

  environment.systemPackages = with pkgs; [
    arc-icon-theme
    arc-kde-theme
    arc-theme
    caffeine-ng
    copyq
    discord
    firefox
    googleearth-pro
    jetbrains.clion
    jetbrains.rider
    nvidia-offload
    pinentry-qt
    powertop
    unzip
    virt-manager
    vlc
    wezterm
    xclip
    zoom-us
  ];
}
