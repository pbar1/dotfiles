#!/usr/bin/env zsh

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
  _base16 "${ZDOTDIR}/.zinit/plugins/fnune---base16-shell/scripts/base16-solarized-light.sh" solarized-light
  source "${XDG_CONFIG_HOME}/base16-fzf/bash/base16-solarized-light.config"
  if [ $(uname) = "Darwin" ]; then
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
  fi
}

# HACK to get color switching working
function dark() {
  _base16 "${ZDOTDIR}/.zinit/plugins/fnune---base16-shell/scripts/base16-solarized-dark.sh" solarized-dark
  source "${XDG_CONFIG_HOME}/base16-fzf/bash/base16-solarized-dark.config"
  if [ $(uname) = "Darwin" ]; then
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
  fi
}
