{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  networking.hostName = "bobbery";
  time.timeZone = "America/Los_Angeles";
  networking.interfaces.wlo1.useDHCP = true; # TODO: Remove if default

  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  # Required for lid closing on Razer Blade Stealth 13
  # https://help.ubuntu.com/community/RazerBlade#Suspend
  boot.kernelParams = [ "button.lid_init_state=open" "intel_iommu=on" "iommu=pt" ];

  # TODO put the following command into a bootstrap script
  # `sudo cryptsetup config /dev/nvme0n1p2 --label crypt`
  boot.initrd.luks.devices."crypt".device = "/dev/disk/by-label/crypt";

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
  };

  # Recommended Btrfs options for an SSD
  # https://www.reddit.com/r/btrfs/comments/r04i0l/comment/hlrfjzz/?utm_source=share&utm_medium=web2x&context=3
  fileSystems."/" = {
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

  # Create Btrfs-compatible swapfile
  # https://github.com/NixOS/nixpkgs/issues/91986#issuecomment-787143060
  # systemd.services = {
  #   create-swapfile = {
  #     serviceConfig.Type = "oneshot";
  #     wantedBy = [ "swap-swapfile.swap" ];
  #     script = ''
  #       ${pkgs.coreutils}/bin/truncate -s 0 /swap/swapfile
  #       ${pkgs.e2fsprogs}/bin/chattr +C /swap/swapfile
  #       ${pkgs.btrfs-progs}/bin/btrfs property set /swap/swapfile compression none
  #     '';
  #   };
  # };

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.video.hidpi.enable = lib.mkDefault true;

  # Nvidia GPU support
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true; # Needed for Wayland
    prime.offload.enable = true;
    prime.intelBusId = "PCI:0:2:0";
    prime.nvidiaBusId = "PCI:57:0:0";
  };
}
