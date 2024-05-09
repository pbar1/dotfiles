{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    disableConfirmationPrompt = true;
    shortcut = "a";
    terminal = "tmux-256color";

    # https://github.com/neovim/neovim/wiki/FAQ#esc-in-tmux-or-gnu-screen-is-delayed
    escapeTime = 10;

    extraConfig = ''
      set -ga terminal-features ',xterm-256color:RGB'
      set -g mouse on
      set -g renumber-windows on
      #set -g allow-passthrough on

      # Force `tmux load-buffer` to emit OSC 52 escape codes (for Neovim)
      # https://github.com/tmux/tmux/issues/3088#issuecomment-1054664489
      set -s command-alias[99] 'load-buffer=load-buffer -w'

      bind s set synchronize-panes
    '';

    plugins = with pkgs; [
      { plugin = tmuxPlugins.pain-control; }
      { plugin = tmuxPlugins.prefix-highlight; }
      {
        plugin = tmuxPlugins.better-mouse-mode;
        extraConfig = "set -g @emulate-scroll-for-no-mouse-alternate-buffer on";
      }
    ];
  };
}
