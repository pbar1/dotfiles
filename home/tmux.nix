{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    disableConfirmationPrompt = true;
    shortcut = "a";
    terminal = "tmux-256color";

    extraConfig = ''
      set-option -ga terminal-overrides ',xterm-256color:Tc'
      set -g mouse on
      set -g renumber-windows on

      # https://github.com/neovim/neovim/wiki/FAQ#esc-in-tmux-or-gnu-screen-is-delayed
      set -gs escape-time 10
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
