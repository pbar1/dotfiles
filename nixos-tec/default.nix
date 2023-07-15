{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://pbar1.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "pbar1.cachix.org-1:DsBqAi4CnR7TaABRn59sUBBK+lofYhQaV8lK8nl2gow="
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "tec";
  networking.hostId = "e7e35d28"; # via `head -c 8 /etc/machine-id`
  networking.firewall.allowedTCPPorts = [
    6443 # Kubernetes API
    8080 # Unifi Controller - device command/control
    10250 # Kubernetes Metrics Server
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
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCvbmBlZPDelP2v07GqSpS252dK9RBAOPwHKf2smvyXS8maopo70WvD1VfWMOdUrATec7qaMqdRfILkrWWo6WbhMFigii59BMmrHmybnrGx0P3Oh+xDwz0NkVqct3eRu/kzRpJc0PvtAWoHNW51xiLThvnzfhZoJy7UfZPKFkZj07Q4Cw1e/DuO5UOGzqovOY9XIwF2ieX7cl4/7fgNmzshKatBvqEZbAB0QowC1GeKGXlXEQJQiKtZPkdkJM54rcjzEZfqzQhGs4bE4phWVMjY5I+nU2pX5J7LVIlkLxItF/1iIaZ63b68EL0VgeHjy2S+7LzorNJsXxCDZ9TU2nAp4dpu8omI4WP0HpdOC46cFsR6Wh68xNtzvDB3KMyse1glYD4mxmEGFMiFvPIDnOvS5eobuI1i0TGbNNRyaIF+s6YlFA+lXyvRC1u6USv/dFPEL4qq9TTr/2rYNlSqLFtnSqUBoxRh9Kv4IfOYAH3TFsa+wuTwcVp4U+uvI347rEH7lAYqTFofYZi827QndC3BhwFdYRAwsZwL/3mHIluuAIN9hKgboZtAAfoEStTzIurG4YkbER0clkgLex00PETQ3T4jYomGG4f50LxJeo2Pa10uLUu/0Wlnq83qLXWmQsy3hqotLQyZMOIzY7sj8s27laJ3TSSk0welGSJxnBKbuQ== piercebartine@gmail.com"
  ];

  users.users.root.hashedPassword = "!"; # Disable root user

  security.sudo.wheelNeedsPassword = false;
  security.apparmor.enable = true;

  environment.systemPackages = with pkgs; [
    fd
    htop
    ripgrep
    vim
    wget
  ];

  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";

  services.k3s.enable = true;
  services.k3s.role = "server";
  services.k3s.extraFlags = toString [
    "--secrets-encryption"
    "--default-local-storage-path=/zssd/general/local-path-provisioner"
    "--container-runtime-endpoint=unix:///var/run/crio/crio.sock"
    "--kubelet-arg cgroup-driver=systemd" # for CRI-O
  ];

  # TODO: Verify if not setting CNI config works for now
  # TODO: Ran `sudo mkdir /var/lib/crio` to allow for clean shutdown
  # https://devopstales.github.io/kubernetes/k3s-crio/
  virtualisation.cri-o.enable = true;
  virtualisation.cri-o.extraPackages = with pkgs; [
    criu
    gvisor
  ];
  virtualisation.cri-o.settings = {
    crio.log_level = "debug";
    crio.runtime.enable_criu_support = true;
    crio.runtime.runtimes.runsc = {
      runtime_path = "${pkgs.gvisor}/bin/runsc";
      runtime_root = "/run/runsc";
    };
  };

  programs.criu.enable = true;

  system.stateVersion = "22.05";
}
