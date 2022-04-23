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
  environment.systemPackages = with pkgs; [
    wget
    firefox
    alacritty
    powertop
    gnomeExtensions.blur-my-shell
    gnomeExtensions.night-theme-switcher
    gnome.gnome-tweaks
    qogir-theme
    qogir-icon-theme
    virt-manager
    win-virtio
    nvidia-offload
    swtpm-tpm2
    pinentry-gnome
    jetbrains.goland
    jetbrains.clion
    googleearth-pro
    discord
    vlc
    wezterm
    copyq
    wl-clipboard
  ];
}
