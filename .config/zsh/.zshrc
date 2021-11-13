#==============================================================================
# ~/.config/zsh/.zshrc
#
# This file contains Zsh
#==============================================================================

# Things that should only happen once, and not in children shells
if [ "${SHLVL}" = 1 ]; then
  # Customize PATH
  source "${XDG_CONFIG_HOME}/sh/path.sh"

  # Load GPG agent and emulated SSH agent
  # TODO: Possibly don't do this on machines with GPG agent already loaded
  export GPG_TTY="${TTY}"
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
  gpgconf --launch gpg-agent
fi

# Load ZSH plugins
eval "$(sheldon source)"

# Load Starship prompt
eval "$(starship init zsh)"

# Load Zoxide (ie, `z`)
eval "$(zoxide init zsh)"

# Source shell aliases
source "${XDG_CONFIG_HOME}/sh/aliases.sh"
source "${XDG_CONFIG_HOME}/sh/sfdc.sh"

# Re-enable '!$' and others. Consider removing vanilli.sh, which disables this
setopt bang_hist

# HACK to get color switching working
function light() {
  base16_solarized-light
  source "${XDG_CONFIG_HOME}/base16-fzf/bash/base16-solarized-light.config"
  if [ $(uname) = "Darwin" ]; then
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
  fi
}

# HACK to get color switching working
function dark() {
  base16_solarized-dark
  source "${XDG_CONFIG_HOME}/base16-fzf/bash/base16-solarized-dark.config"
  if [ $(uname) = "Darwin" ]; then
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
  fi
}
