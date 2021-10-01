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

# Syntax highlighting, command autosuggestions, and command completions
# https://zdharma.github.io/zinit/wiki/Example-Minimal-Setup/
zinit wait lucid for                                                      \
                                       fnune/base16-shell                 \
                                       yous/vanilli.sh                    \
                                       olets/zsh-abbr                     \
                                       ellie/atuin                        \
                                       ajeetdsouza/zoxide                 \
  atinit'zicompinit; zicdreplay'       zdharma/fast-syntax-highlighting   \
  atload'_zsh_autosuggest_start'       zsh-users/zsh-autosuggestions      \
  blockf atpull'zinit creinstall -q .' zsh-users/zsh-completions

# Load Starship prompt
# NOTE: Awaiting bug fix by https://github.com/starship/starship/pull/3088
# zinit wait'!0' lucid as'command' from'gh-r' for                                   \
#   atclone'./starship init zsh > init.zsh; ./starship completions zsh > _starship' \
#   atpull'%atclone' src'init.zsh'                                                  \
#     starship/starship
eval "$(starship init zsh)"

# Source shell aliases
source "${XDG_CONFIG_HOME}/sh/aliases.sh"
