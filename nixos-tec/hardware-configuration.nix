{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.kernel.sysctl = {
    # For Transmission performance
    # https://web.archive.org/web/20171019185200/https://falkhusemann.de/blog/2012/07/transmission-utp-and-udp-buffer-optimizations/
    "net.core.rmem_max" = 4194304;
    "net.core.wmem_max" = 1048576;
  };
  boot.extraModprobeConfig = ''
    options zfs zfs_txg_timeout=30
  '';
  boot.extraModulePackages = [ ];
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "data" "zssd" ];

  fileSystems."/" = {
    device = "/dev/disk/by-id/nvme-CT500P2SSD8_2118E59D6609-part1";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-id/nvme-CT500P2SSD8_2118E59D6609-part2";
    fsType = "vfat";
  };

  fileSystems."/keys" = {
    device = "/dev/disk/by-id/usb-Lexar_USB_Flash_Drive_04DDARFLD3OSXBA7-0:0-part1";
    options = [ "defaults" "nofail" ];
  };

  # Swap is disabled for Kubernetes
  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
