#!/usr/bin/env zsh

#--------------------------------------------------------------
# Environment Variables
#--------------------------------------------------------------

source "${HOME}/.zshenv"
source "${HOME}/.secrets.sh"
source "${XDG_CONFIG_HOME}/fzf/fzf.sh"

if [ "$(uname)" = 'Darwin' ]; then
  if [ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" = 'Dark' ]; then
    _fzf_opts_dark
  else
    _fzf_opts_light
  fi
else
  _fzf_opts_dark
fi

export KOPS_STATE_STORE="s3://kops-state-3huq8vsi"
export EDITOR=nvim
export VISUAL=nvim
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

export CODEPATH="${HOME}/code"
export GOPATH="${CODEPATH}/go"
path=(
  "${HOME}/.krew/bin"
  "${GOPATH}/bin"
  "${HOME}/.cargo/bin"
  "${XDG_DATA_HOME}/npm/bin"
  "${HOME}/Library/Python/3.8/bin"
  "${HOME}/.emacs.d/bin"
  "${HOME}/.local/bin"
  "/usr/local/sbin"
  ${path}
)
typeset -U path
export PATH

export GEOMETRY_PROMPT_PLUGINS=(exec_time jobs node git kube)
export GEOMETRY_SYMBOL_PROMPT="♪"
export GEOMETRY_SYMBOL_EXIT_VALUE="ø"
export GEOMETRY_SYMBOL_RPROMPT="♮"

BASE16_SHELL="${HOME}/.config/base16-shell/"
[ -n "${PS1}" ] && [ -s "${BASE16_SHELL}/profile_helper.sh" ] && \
  eval "$("${BASE16_SHELL}/profile_helper.sh")"

eval "$(zoxide init zsh)"

#--------------------------------------------------------------
# zgen
#--------------------------------------------------------------

source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
  echo "Creating a zgen save"
  zgen loadall <<EOPLUGINS
    yous/vanilli.sh
    geometry-zsh/geometry
    pbar1/zsh-terraform
    zdharma/fast-syntax-highlighting
    zsh-users/zsh-autosuggestions
    einsteinplatform/devenv lib/k8s.sh
EOPLUGINS
  zgen save
fi

#--------------------------------------------------------------
# Completions
#--------------------------------------------------------------

export GEOMETRY_GIT_SEPARATOR=""
source "${XDG_CONFIG_HOME}/zsh/aliases.sh"
source "${XDG_CONFIG_HOME}/zsh/siq.sh"
source /usr/local/share/zsh/site-functions/aws_zsh_completer.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
(( $+commands[kubectl] ))   && source <(kubectl completion zsh)
(( $+commands[helm] ))      && source <(helm completion zsh)
(( $+commands[kops] ))      && source <(kops completion zsh)
(( $+commands[k3d] ))       && source <(k3d completion zsh)
(( $+commands[stern] ))     && source <(stern --completion=zsh)
(( $+commands[velero] ))    && source <(velero completion zsh)
(( $+commands[kubecfg] ))   && source <(kubecfg completion --shell=zsh)
(( $+commands[yq] ))        && source <(yq shell-completion --variation=zsh)
(( $+commands[terraform] )) && complete -C "$(which terraform)" terraform
(( $+commands[vault] ))     && complete -C "$(which vault)"     vault
