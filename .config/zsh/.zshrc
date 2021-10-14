#!/usr/bin/env zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.config/zsh/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.config/zsh/.zinit" && command chmod g-rwX "$HOME/.config/zsh/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.config/zsh/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.config/zsh/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# Load ZSH plugins
# https://zdharma.github.io/zinit/wiki/Example-Minimal-Setup/
zinit wait lucid for                                                             \
                                                fnune/base16-shell               \
                                                yous/vanilli.sh                  \
                                                olets/zsh-abbr                   \
                                                ajeetdsouza/zoxide               \
                                                Aloxaf/fzf-tab                   \
  multisrc'shell/{completion,key-bindings}.zsh' junegunn/fzf                     \
  as'completion'                                sawadashota/go-task-completions  \
  atinit'zicompinit; zicdreplay'                zdharma/fast-syntax-highlighting \
  atload'_zsh_autosuggest_start'                zsh-users/zsh-autosuggestions    \
  blockf atpull'zinit creinstall -q .'          zsh-users/zsh-completions

# Load Starship prompt
# NOTE: Load with Zinit after https://github.com/starship/starship/pull/3088
eval "$(starship init zsh)"

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
