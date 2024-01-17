{ lib, pkgs, ... }:

let
  shellAliases = import ./shell/aliases.nix { inherit pkgs; };
  shellAbbrs = import ./shell/abbrs.nix;
  shellAbbrsInit = lib.concatStringsSep "\n"
    (lib.attrsets.mapAttrsToList (k: v: "abbr --quiet --session ${k}='${v}'") shellAbbrs);
in
{
  programs.zsh = {
    enable = true;

    inherit shellAliases;

    dotDir = ".config/zsh";
    enableVteIntegration = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    # Flake inputs with prefix "zsh:" automatically end up here via overlay
    plugins = pkgs.lib.attrsets.mapAttrsToList
      (name: value: {
        inherit name;
        inherit (value) src;
      })
      pkgs.myZshPlugins;

    loginExtra = lib.mkIf pkgs.stdenv.isDarwin ''
      # macOS updates clear /etc/zshrc back to Apple defaults; this segment was
      # taken from that file.
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # End Nix

      # Non-POSIX-compliant shells (for example, fish) should not be set as user
      # login shell. Exec said shell here as a workaround if desired.
      if [[ $(ps -p $PPID -o comm=) != "fish" && -z $ZSH_EXECUTION_STRING ]]; then
          (( $+commands[fish] )) && exec fish
      fi
    '';

    initExtra = ''
      ${shellAbbrsInit}
    '';
  };
}
