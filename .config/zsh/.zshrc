#!/usr/bin/env zsh

#------------------------------------------------------------------------------
# ZSH configuration
#------------------------------------------------------------------------------

# Usage: source_zc example.zsh
# Compiles a ZSH file into bytecode and sources it
function source_zc() {
  # If there is no *.zsh.zwc or it's older than *.zsh, compile *.zsh into *.zsh.zwc.
  if [[ ! "${1}.zwc" -nt "${1}" ]]; then
    zcompile "${1}"
  fi
  source "${1}"
}

# Loads the ZSH compinit function into scope
autoload -Uz compinit

# Initializes the ZSH completion system while ignoring insecure directories
compinit -i

# Source plugins, which should exist as submodules of this repo
export ZSH_PLUGDIR="${ZDOTDIR:-"${HOME}/.config/zsh"}/plugins"
source_zc "${ZSH_PLUGDIR}/zsh-defer/zsh-defer.plugin.zsh"
source_zc "${ZSH_PLUGDIR}/vanilli.sh/vanilli.zsh"
zsh-defer source_zc "${ZSH_PLUGDIR}/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh"
zsh-defer source_zc "${ZSH_PLUGDIR}/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# If a command begins with a space, it won't be saved to ZSH history
setopt HIST_IGNORE_SPACE

# Colon-separated list of patterns to ignore when saving ZSH history
export HISTORY_IGNORE="*AWS_ACCESS_KEY_ID=*:*AWS_SECRET_ACCESS_KEY=*:*AWS_SESSION_TOKEN=*:*VAULT_TOKEN=s.*"

#------------------------------------------------------------------------------
# Environment variables
#------------------------------------------------------------------------------

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
  "${HOME}/.local/share/cargo/bin"
  "${XDG_DATA_HOME}/npm/bin"
  "${HOME}/Library/Python/3.8/bin"
  "${HOME}/.emacs.d/bin"
  "${HOME}/.local/bin"
  "/usr/local/sbin"
  ${path}
)
typeset -U path
export PATH

BASE16_SHELL="${HOME}/.config/base16-shell/"
[ -n "${PS1}" ] && [ -s "${BASE16_SHELL}/profile_helper.sh" ] && \
  eval "$("${BASE16_SHELL}/profile_helper.sh")"

#------------------------------------------------------------------------------
# Completions, aliases, and functions
#------------------------------------------------------------------------------

if [ $(uname) = 'Linux' ]; then
  zsh-defer source_zc "/usr/share/fzf/key-bindings.zsh"
  zsh-defer source_zc "/usr/share/fzf/completion.zsh"
elif [ $(uname) = 'Darwin' ]; then
  zsh-defer source_zc "${HOME}/.fzf.zsh"
fi

zsh-defer source_zc "${HOME}/.nix-profile/etc/profile.d/nix.sh"
zsh-defer source_zc "${XDG_CONFIG_HOME}/shell/aliases.sh"
zsh-defer source_zc "${XDG_CONFIG_HOME}/shell/k8s.sh"
zsh-defer source_zc "${XDG_CONFIG_HOME}/shell/sfdc.sh"
zsh-defer source_zc "/usr/local/share/zsh/site-functions/aws_zsh_completer.sh"
zsh-defer source_zc "${ZDOTDIR}/completions/zoxide.zsh"
zsh-defer source_zc "${ZDOTDIR}/completions/kubectl.zsh"
zsh-defer source_zc "${ZDOTDIR}/completions/helm.zsh"
zsh-defer source_zc "${ZDOTDIR}/completions/stern.zsh"
source_zc "${ZDOTDIR}/completions/starship.zsh"
