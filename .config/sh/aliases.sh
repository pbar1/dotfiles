#!/usr/bin/env sh

alias vi="nvim"
alias vim="nvim"
alias cat="bat"
alias ls="exa"
alias l="exa --all --long --git --header"
alias lst="exa --tree"
alias aliasrc='$EDITOR ${XDG_CONFIG_HOME}/sh/aliases.sh'
alias zshrc='${EDITOR} ${ZDOTDIR}/.zshrc'
alias copy="pbcopy"
alias .ft='task --taskfile=${HOME}/.github/Taskfile.yml'

vsel() {
  VAULT_ADDR=$(cat "${XDG_CONFIG_HOME}/vault/addrs" | fzf)
  export VAULT_ADDR

  unset VAULT_TOKEN
  if ! vault token lookup > /dev/null 2>&1; then
    vault login -no-print -method="oidc" role="ep-sre"
  fi
  VAULT_TOKEN=$(vault print token)
  export VAULT_TOKEN

  echo "Switched to Vault cluster '${VAULT_ADDR}'"
}
