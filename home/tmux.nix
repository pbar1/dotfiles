{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    disableConfirmationPrompt = true;
    shortcut = "a";
    terminal = "screen-256color";

    extraConfig = ''
      set -ga terminal-overrides ",*256col*:RGB"
      set -g mouse on
      set -g renumber-windows on

      # https://github.com/neovim/neovim/wiki/FAQ#esc-in-tmux-or-gnu-screen-is-delayed
      set -sg escape-time 10

      # Status bar
      set -g status "on"
      set -g status-bg "colour236"
      set -g status-justify "left"
      set -g status-position "top"
      set -g status-left-length "100"
      set -g status-right-length "100"
      set -g status-left "#{prefix_highlight}#[fg=colour22,bg=colour148,bold] #S #[fg=#073642,bg=#073642,nobold,nounderscore,noitalics]"
      set -g status-right "#[fg=#073642,bg=#073642,nobold,nounderscore,noitalics]#[fg=colour250,bg=colour240] %Y-%m-%d %H:%M #[fg=colour252,bg=colour240,nobold,nounderscore,noitalics]#[fg=colour241,bg=colour252] #h "
      setw -g window-status-separator ""
      setw -g window-status-format "#[fg=colour245,bg=colour236] #I #[fg=colour245,bg=colour236]#W "
      setw -g window-status-current-format "#[fg=colour236,bg=colour240,nobold,nounderscore,noitalics]#[fg=colour231,bg=colour240] #I #[fg=colour231,bg=colour240]#{?window_zoomed_flag,#[fg=green][],}#W #[fg=colour240,bg=colour236,nobold,nounderscore,noitalics]"
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
