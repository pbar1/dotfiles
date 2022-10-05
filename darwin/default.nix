{ pkgs, ... }:

{
  imports = [
    ./packages.nix
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  nix.binaryCaches = [
    "https://nix-community.cachix.org"
    "https://pbar1.cachix.org"
  ];
  nix.binaryCachePublicKeys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "pbar1.cachix.org-1:DsBqAi4CnR7TaABRn59sUBBK+lofYhQaV8lK8nl2gow="
  ];

  # Handy list of macOS `defaults` options
  # https://github.com/LnL7/nix-darwin/blob/master/tests/system-defaults-write.nix

  # Dock
  system.defaults.dock.autohide-time-modifier = "0.0";
  system.defaults.dock.autohide-delay = "0.0";
  system.defaults.dock.orientation = "left";

  # Falls back to default if directory doesn't exist
  system.defaults.screencapture.location = "~/Pictures/Screenshots";

  # Keyboard settings
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3; # Enable full keyboard in modal dialogs
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10; # 150 ms
  system.defaults.NSGlobalDomain.KeyRepeat = 1; # 15 ms
  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Disable nix-darwin shell integrations
  programs.bash.enable = false;
  programs.fish.enable = false;
  programs.zsh.enable = false;

  # Enable GPG agent and have it emulate SSH agent
  programs.gnupg.agent.enable = true;
  programs.gnupg.enableSSHSupport = true;
}
