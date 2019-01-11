#!/usr/bin/env zsh

#--------------------------------------------------------------
# Environment Variables
#--------------------------------------------------------------
export NVM_LAZY_LOAD=true
export EDITOR=nvim
export VISUAL=nvim

export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

if grep -qE "(Microsoft|WSL)" /proc/version &> /dev/null; then
  export CODEPATH="/c/code"
  export DOCKER_HOST=tcp://0.0.0.0:2375
  export BROWSER="explorer.exe"
  unsetopt BG_NICE
else
  export CODEPATH="$HOME/code"
fi

export GOPATH="$CODEPATH/go"
export PATH="$GOPATH/bin:$HOME/.local/bin:$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export AUTOENV_FILE_ENTER=".env"
export AUTOENV_FILE_LEAVE=".out"
export GEOMETRY_PROMPT_PLUGINS=(exec_time jobs node kube git terraform dcos)
export GEOMETRY_SYMBOL_PROMPT="♪"
export GEOMETRY_SYMBOL_EXIT_VALUE="ø"
export GEOMETRY_SYMBOL_RPROMPT="♮"

#--------------------------------------------------------------
# zplugin
#--------------------------------------------------------------

# Added by Zplugin's installer
source "$ZDOTDIR/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

zplugin light "yous/vanilli.sh"
zplugin light "Tarrasch/zsh-autoenv"
zplugin light "geometry-zsh/geometry"
zplugin light "pbar1/geometry-terraform"
zplugin light "pbar1/geometry-dcos"
zplugin light "supercrabtree/k"
zplugin light "eendroroy/zed-zsh"
zplugin light "Dbz/zsh-kubernetes"
zplugin light "pbar1/zsh-terraform"
zplugin light "lukechilds/zsh-nvm"
zplugin light "zsh-users/zsh-autosuggestions"
zplugin light "zdharma/fast-syntax-highlighting"

zplugin ice as"program" cp"emojify.sh -> emojify" pick"emojify"
zplugin light "BozarthPrime/slack-emojify"

autoload -Uz compinit && compinit
zplugin cdreplay -q

#--------------------------------------------------------------
# Completions, etc
#--------------------------------------------------------------
export GEOMETRY_GIT_SEPARATOR=""
source "$XDG_CONFIG_HOME/zsh/aliases.sh"
source <(kubectl completion zsh)
source <(minikube completion zsh)
source <(helm completion zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

