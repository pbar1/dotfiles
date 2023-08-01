{ pkgs, ... }:

let
  # Wrapper for FZF that detects system theme and displays colors accordingly
  # See https://github.com/dandavison/delta/issues/447 for inspiration
  fzfColor = pkgs.writeShellScriptBin "fzf" ''
    set -euo pipefail

    OS="$(uname)"

    if [[ "$OS" == "Darwin" ]]; then
      MODE="$(defaults read -g AppleInterfaceStyle &>/dev/null && echo dark || echo light)"
    else
      MODE=dark
    fi

    if [[ "$MODE" == "light" ]]; then
      # https://github.com/tinted-theming/base16-fzf/blob/main/bash/base16-gruvbox-light-soft.config
      color00='#f2e5bc'
      color01='#ebdbb2'
      color02='#d5c4a1'
      color03='#bdae93'
      color04='#665c54'
      color05='#504945'
      color06='#3c3836'
      color07='#282828'
      color08='#9d0006'
      color09='#af3a03'
      color0A='#b57614'
      color0B='#79740e'
      color0C='#427b58'
      color0D='#076678'
      color0E='#8f3f71'
      color0F='#d65d0e'
    elif [[ "$MODE" == "dark" ]]; then
      # https://github.com/tinted-theming/base16-fzf/blob/main/bash/base16-gruvbox-dark-soft.config
      color00='#32302f'
      color01='#3c3836'
      color02='#504945'
      color03='#665c54'
      color04='#bdae93'
      color05='#d5c4a1'
      color06='#ebdbb2'
      color07='#fbf1c7'
      color08='#fb4934'
      color09='#fe8019'
      color0A='#fabd2f'
      color0B='#b8bb26'
      color0C='#8ec07c'
      color0D='#83a598'
      color0E='#d3869b'
      color0F='#d65d0e'
    else
      echo "Unknown mode: $MODE" >/dev/stderr
      exit 1
    fi

    set +u
    export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS""\
     --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D""\
     --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C""\
     --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

    exec "${pkgs.fzf}/bin/fzf" "$@"
  '';
in
{
  programs.fzf = {
    enable = true;
    package = fzfColor;
    enableFishIntegration = false;
    enableZshIntegration = false;
    defaultCommand = "fd --type=file --exclude=.git --hidden --follow";
  };

  programs.atuin = {
    enable = true;
  };
}
