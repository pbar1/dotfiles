# Source environment variables
source "$HOME/.config/fish/variables.fish"

# Setup GPG agent, including SSH agent emulation
set -gx GPG_TTY (tty)
set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

# Commands to run in interactive sessions can go here
if status is-interactive
  # Install Fisher plugin manager if needed, and install all plugins
  if ! type --query fisher
    curl -sL https://git.io/fisher | source && fisher update
  end

  # Setup Base16 Shell terminal color schemes
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
end

# Disable fish greeting message
set -g fish_greeting

# Initialize prompt theme
starship init fish | source

# Initialize "z" directory jumper
zoxide init fish | source
