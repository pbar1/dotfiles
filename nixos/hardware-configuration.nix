# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Required for lid closing on Razer Blade Stealth 13
  # https://help.ubuntu.com/community/RazerBlade#Suspend
  boot.kernelParams = [ "button.lid_init_state=open" "intel_iommu=on" "iommu=pt" ];

  boot.plymouth.enable = true;

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };

  boot.initrd.luks.devices."crypt".device = "/dev/disk/by-uuid/a2edcd36-b477-4779-9b3f-6963aa9c0786";

  # Recommended Btrfs options for an SSD
  # https://www.reddit.com/r/btrfs/comments/r04i0l/comment/hlrfjzz/?utm_source=share&utm_medium=web2x&context=3
  fileSystems."/" =
    {
      device = "/dev/disk/by-label/root";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" "ssd" "discard=async" "space_cache=v2" "commit=120" "autodefrag" ];
    };

  #fileSystems."/swap" =
  #  { device = "/dev/disk/by-label/root";
  #    fsType = "btrfs";
  #    options = [ "subvol=swap" "compress=zstd" "noatime" ];
  #  };

  #swapDevices = [{
  #  device = "/swap/swapfile";
  #  size = (1024 * 16) + (1024 * 2); # RAM size + 2 GB
  #}];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
