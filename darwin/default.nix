{ pkgs, ... }:

let
  user = "pierce";
in
{
  imports = [
    ./packages.nix
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Auto upgrade nix package and the daemon service.
  nix.enable = true;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    extra-nix-path = nixpkgs=flake:nixpkgs
    bash-prompt-prefix = (nix:$name)\040
  '';
  nix.settings.substituters = [
    "https://nix-community.cachix.org"
    "https://devenv.cachix.org"
    "https://pbar1.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    "pbar1.cachix.org-1:DsBqAi4CnR7TaABRn59sUBBK+lofYhQaV8lK8nl2gow="
  ];
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];
  nix.distributedBuilds = true;
  nix.buildMachines = [
    {
      hostName = "tec";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      sshUser = "nixos";
      sshKey = "/Users/${user}/.ssh/nix_build";
      supportedFeatures = [
        "nixos-test"
        "benchmark"
        "big-parallel"
        "kvm"
      ];
      maxJobs = 16;
    }
  ];

  # Must be set for `homebrew` and `system` attributes. Previously the user
  # running the switch command would be chosen implictly.
  system.primaryUser = user;

  # Handy list of macOS `defaults` options
  # https://github.com/LnL7/nix-darwin/blob/master/tests/system-defaults-write.nix

  # Dock
  system.defaults.dock.autohide = true;
  system.defaults.dock.autohide-time-modifier = 0.0;
  system.defaults.dock.autohide-delay = 0.0;
  system.defaults.dock.orientation = "bottom";

  # Falls back to default if directory doesn't exist
  system.defaults.screencapture.location = "~/Pictures/Screenshots";

  # Keyboard settings
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3; # Enable full keyboard in modal dialogs
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10; # 150 ms
  system.defaults.NSGlobalDomain.KeyRepeat = 1; # 15 ms
  system.defaults.NSGlobalDomain.NSWindowShouldDragOnGesture = true; # ctrl+cmd+drag any part of window

  # Disable nix-darwin shell integrations
  programs.bash.enable = false;
  programs.fish.enable = false;
  programs.zsh.enable = false;

  # TouchID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # SSH server
  users.users."${user}".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGvmdvrrgYY3Q+Wp/SyQm2a2OWL82S2Z+e+FoJ/vmS/D"
  ];

  # FIXME: Touch ~/.hushlogin to disable last login time
  # TODO: Linux builder: https://daiderd.com/nix-darwin/manual/index.html#opt-nix.linux-builder.enable
}
