{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://pbar1.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "pbar1.cachix.org-1:DsBqAi4CnR7TaABRn59sUBBK+lofYhQaV8lK8nl2gow="
  ];
  nix.settings.trusted-users = [ "root" "nixos" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tec";
  networking.hostId = "e7e35d28"; # via `head -c 8 /etc/machine-id`
  networking.firewall.allowedTCPPorts = [
    6443 # Kubernetes - API
    10250 # Kubernetes - Metrics Server
    32400 # Plex
  ];

  time.timeZone = "America/Los_Angeles";

  users.users.nixos.isNormalUser = true;
  users.users.nixos.extraGroups = [ "wheel" ];
  users.users.nixos.hashedPassword = "$6$ouPdfmFbwMP/0uf7$qHv26BknhOYNzoZPMJZ6Ic5uR6Rw3K/CLSYEDWr5djV9UJKkzcGB4b3ZRqHawJ5pt.dKr3ySK7JDUyTnXEl2k1";
  users.users.nixos.openssh.authorizedKeys.keys = [
    # SSH Personal
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGvmdvrrgYY3Q+Wp/SyQm2a2OWL82S2Z+e+FoJ/vmS/D"
    # nix-build
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHU/j3uw6wGWO3+2aRO7We1oQXtcExTyl8uGM4zhq8Zq nix-build"
  ];

  users.users.root.hashedPassword = "!"; # Disable root user

  security.sudo.wheelNeedsPassword = false;
  security.apparmor.enable = true;

  environment.systemPackages = with pkgs; [
    bpftrace
    btop
    fd
    ffmpeg
    fselect
    jq
    pv
    ripgrep
    ruby
    smartmontools
    vim
    wget
    yt-dlp
  ];

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";

  services.eternal-terminal.enable = true;

  programs.tmux.enable = true;
  programs.tmux.shortcut = "a";

  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    # IPv4-only beacuse ISP has trouble keeping an IPv6 address, which crashes
    # the cluster when lost
    "--cluster-cidr=10.42.0.0/16"
    "--service-cidr=10.43.0.0/16"
    "--default-local-storage-path=/zssd/general/local-path-provisioner"
    "--secrets-encryption"
    "--disable=traefik"
  ];

  programs.criu.enable = true;

  system.stateVersion = "22.05";
}
