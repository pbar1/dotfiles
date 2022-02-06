# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

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
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix

      <home-manager/nixos>
    ];

  # User configuration via home-manager
  home-manager.users.pierce = { pkgs, ... }: {
    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
      bat
      fzf
      exa
      fd
      ripgrep
      fishPlugins.fzf-fish
      go-task
    ];

    programs.git = {
      enable = true;
      userName = "Pierce Bartine";
      userEmail = "piercebartine@gmail.com";
    };

    programs.fish.enable = true;
    programs.fish.plugins = [{
      name = "plugin-bang-bang";
      src = pkgs.fetchFromGitHub {
        owner = "oh-my-fish";
        repo = "plugin-bang-bang";
        rev = "f969c618301163273d0a03d002614d9a81952c1e";
        sha256 = "1r3d4wgdylnc857j08lbdscqbm9lxbm1wqzbkqz1jf8bgq2rvk03";
      };
    }];

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        # add_newline = false;

        character = {
          success_symbol = "[♪]()";
          error_symbol = "[ø](red)";
          vicmd_symbol = "[V](blue)";
        };

        # package.disabled = true;
      };
    };

    programs.neovim = {
      enable = true;
    };

    programs.vscode = {
      enable = true;
    };

    programs.gpg = {
      enable = true;
    };

    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      sshKeys = [ "CDCD1DF93F65BF132EB1F33327E34108F53BD47A" ];
    };
  };

  # Allow unfree packages such as the Nvidia proprietary driver
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "bobbery"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlo1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable Nvidia GPU driver
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.prime = {
    offload.enable = true;
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:57:0:0";
  };

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "pierce";
  services.xserver.desktopManager.gnome.enable = true;


  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  # Disable root user
  users.users.root.hashedPassword = "!";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pierce = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "docker" "libvirtd" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    firefox
    alacritty
    tmux
    powertop
    gnomeExtensions.blur-my-shell
    gnomeExtensions.night-theme-switcher
    gnome.gnome-tweaks
    qogir-theme
    qogir-icon-theme
    virt-manager
    win-virtio
    nvidia-offload
    iosevka
    swtpm-tpm2
  ];

  # For virt-manager
  programs.dconf.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Create Btrfs-compatible swapfile
  # https://github.com/NixOS/nixpkgs/issues/91986#issuecomment-787143060
  #systemd.services = {
  #  create-swapfile = {
  #    serviceConfig.Type = "oneshot";
  #    wantedBy = [ "swap-swapfile.swap" ];
  #    script = ''
  #      ${pkgs.coreutils}/bin/truncate -s 0 /swap/swapfile
  #      ${pkgs.e2fsprogs}/bin/chattr +C /swap/swapfile
  #      ${pkgs.btrfs-progs}/bin/btrfs property set /swap/swapfile compression none
  #    '';
  #  };
  #};

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

