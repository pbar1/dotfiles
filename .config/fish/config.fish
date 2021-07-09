# Commands to run in interactive sessions can go here
if status is-interactive
  # Disable fish greeting message
  set -g fish_greeting

  # Source abbreviations
  source "$HOME/.config/fish/abbreviations.fish"
  
  # Install Fisher plugin manager if needed, and install all plugins
  if ! type --query fisher
    curl -sL https://git.io/fisher | source && fisher update
  end

  # Setup Base16 Shell terminal color schemes
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
end

