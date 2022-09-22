{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
  ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings.substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://pbar1.cachix.org"
    ];
    settings.trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "pbar1.cachix.org-1:DsBqAi4CnR7TaABRn59sUBBK+lofYhQaV8lK8nl2gow="
    ];
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  # Create Btrfs-compatible swapfile
  # https://github.com/NixOS/nixpkgs/issues/91986#issuecomment-787143060
  systemd.services.create-swapfile = {
    serviceConfig.Type = "oneshot";
    wantedBy = [ "swap-swapfile.swap" ];
    script = ''
      ${pkgs.e2fsprogs}/bin/chattr +C /swap
      ${pkgs.coreutils}/bin/truncate -s 0 /swap/swapfile
      ${pkgs.btrfs-progs}/bin/btrfs property set /swap/swapfile compression none
      ${pkgs.btrfs-progs}/bin/btrfs property set /swap/swapfile noautodefrag
      ${pkgs.btrfs-progs}/bin/btrfs property set /swap/swapfile nodiscard
    '';
  };

  i18n.defaultLocale = "en_US.UTF-8";

  fonts = {
    fonts = with pkgs; [
      noto-fonts-cjk
      twitter-color-emoji
    ];
    fontconfig.defaultFonts.emoji = [ "Twitter Color Emoji" ];
  };

  services.xserver = {
    enable = true;
    xkbOptions = "caps:escape";
    autoRepeatDelay = 150;
    autoRepeatInterval = 15;
    libinput.enable = true;

    displayManager = {
      gdm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "pierce";
    };

    desktopManager.gnome.enable = true;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Disable sound module as it conflicts with PipeWire
  sound.enable = false;
  hardware.pulseaudio.enable = false;

  # Enable PipeWire for sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Uncomment this line to allow AirPods to connect. After initial connection,
  # it can be commented back out (ie, ControllerMode = "dual").
  # See: https://github.com/tim-hilt/nixos/blob/main/config/desktop.nix
  # hardware.bluetooth.settings = { General = { ControllerMode = "bredr"; }; };
  hardware.bluetooth.enable = true;

  networking.networkmanager.enable = true;

  users.users.pierce = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "libvirtd" ];
  };
  users.users.root.hashedPassword = "!"; # Disable root user

  security.pam.services.gdm.enableGnomeKeyring = true;
  security.sudo.wheelNeedsPassword = false;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.tailscale.enable = true;

  services.openssh = {
    enable = true;
    permitRootLogin = "no";
  };

  services.eternal-terminal = {
    enable = true;
    port = 2022;
  };

  networking.firewall.allowedTCPPorts = [ 2022 ];
  networking.firewall.checkReversePath = "loose";

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    qemu.swtpm.enable = true;
    qemu.ovmf.packages = [
      (pkgs.OVMFFull.override {
        secureBoot = true;
        tpmSupport = true;
      }).fd
    ];
  };

  programs.dconf.enable = true;

  programs.gpaste.enable = true;

  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?
}
