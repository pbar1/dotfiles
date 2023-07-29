{ lib, pkgs, ... }:

let
  shellAbbrs = import ./shell/abbrs.nix;
  shellAbbrsInit = lib.concatStringsSep "\n"
    (lib.attrsets.mapAttrsToList (k: v: "abbr --quiet --session ${k}='${v}'") shellAbbrs);
in
{
  # FIXME: GPG
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableVteIntegration = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;

    plugins = pkgs.lib.attrsets.mapAttrsToList
      (name: value: {
        inherit name;
        inherit (value) src;
      })
      pkgs.myZshPlugins;

    # macOS updates clear /etc/zshrc back to Apple defaults; this segment was
    # taken from that file.
    #
    # Non-POSIX-compliant shells (for example, fish) should not be set as user
    # login shell. Exec said shell here as a workaround if desired.
    loginExtra = lib.mkIf pkgs.stdenv.isDarwin ''
      # Nix
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
      # End Nix

      # if [[ $(ps -p $PPID -o comm=) != "fish" && -z $ZSH_EXECUTION_STRING ]]; then
      #     (( $+commands[fish] )) && exec fish
      # fi
    '';

    initExtra = ''
      ${shellAbbrsInit}
    '';
  };
}
