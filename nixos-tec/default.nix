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
    8080 # Unifi Controller - device command/control
    10250 # Kubernetes - Metrics Server
    32400 # Plex
  ];
  networking.firewall.allowedUDPPorts = [
    3478 # Unifi Controller - STUN
    10001 # Unifi Controller - device discovery
  ];

  time.timeZone = "America/Los_Angeles";

  users.users.nixos.isNormalUser = true;
  users.users.nixos.extraGroups = [ "wheel" ];
  users.users.nixos.hashedPassword = "$6$ouPdfmFbwMP/0uf7$qHv26BknhOYNzoZPMJZ6Ic5uR6Rw3K/CLSYEDWr5djV9UJKkzcGB4b3ZRqHawJ5pt.dKr3ySK7JDUyTnXEl2k1";
  users.users.nixos.openssh.authorizedKeys.keys = [
    # GPG key
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCvbmBlZPDelP2v07GqSpS252dK9RBAOPwHKf2smvyXS8maopo70WvD1VfWMOdUrATec7qaMqdRfILkrWWo6WbhMFigii59BMmrHmybnrGx0P3Oh+xDwz0NkVqct3eRu/kzRpJc0PvtAWoHNW51xiLThvnzfhZoJy7UfZPKFkZj07Q4Cw1e/DuO5UOGzqovOY9XIwF2ieX7cl4/7fgNmzshKatBvqEZbAB0QowC1GeKGXlXEQJQiKtZPkdkJM54rcjzEZfqzQhGs4bE4phWVMjY5I+nU2pX5J7LVIlkLxItF/1iIaZ63b68EL0VgeHjy2S+7LzorNJsXxCDZ9TU2nAp4dpu8omI4WP0HpdOC46cFsR6Wh68xNtzvDB3KMyse1glYD4mxmEGFMiFvPIDnOvS5eobuI1i0TGbNNRyaIF+s6YlFA+lXyvRC1u6USv/dFPEL4qq9TTr/2rYNlSqLFtnSqUBoxRh9Kv4IfOYAH3TFsa+wuTwcVp4U+uvI347rEH7lAYqTFofYZi827QndC3BhwFdYRAwsZwL/3mHIluuAIN9hKgboZtAAfoEStTzIurG4YkbER0clkgLex00PETQ3T4jYomGG4f50LxJeo2Pa10uLUu/0Wlnq83qLXWmQsy3hqotLQyZMOIzY7sj8s27laJ3TSSk0welGSJxnBKbuQ== piercebartine@gmail.com"
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
    jq
    ripgrep
    vim
    wget
  ];

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";

  services.eternal-terminal.enable = true;

  programs.tmux.enable = true;
  programs.tmux.shortcut = "a";

  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    # Enable dual stack networking by passing both IPv4 and IPv6 ranges
    # https://docs.k3s.io/installation/network-options#dual-stack-ipv4--ipv6-networking
    "--cluster-cidr=10.42.0.0/16,2001:cafe:42:0::/56"
    "--service-cidr=10.43.0.0/16,2001:cafe:42:1::/112"
    "--default-local-storage-path=/zssd/general/local-path-provisioner"
    "--secrets-encryption"
    "--disable=traefik"
  ];

  programs.criu.enable = true;

  system.stateVersion = "22.05";
}
