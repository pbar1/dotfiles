#!/usr/bin/env bash

alias zshrc='$EDITOR $ZDOTDIR/.zshrc'
alias aliasrc='$EDITOR $ZDOTDIR/aliases.sh'
alias vimrc='$EDITOR $XDG_CONFIG_HOME/nvim/init.vim'
alias tmuxrc='$EDITOR $HOME/.tmux.conf'

eval "$(hub alias -s)"

alias utime='date +%s'
alias tolower="tr '[:upper:]' '[:lower:]'"
alias toupper="tr '[:lower:]' '[:upper:]'"
alias myip='curl ipinfo.io/ip'
#alias copy="xclip -sel clip"
alias copy=pbcopy
alias ldd='otool -L'
alias cat=bat
alias vi=nvim
alias nc=ncat
alias dotfiles='git --git-dir=$HOME/.config/dotfiles.git/ --work-tree=$HOME'
alias dot=dotfiles
alias dots='dotfiles status -s -uno'
alias c=clear
alias wo=where
alias l='ls -GlASh'
alias g=git
alias gs='git status -s'
alias rdp=xfreerdp
alias docker-sweep='docker rm $(docker ps -a -q -f status=exited)'
alias lsnpm='npm ls --local-only --depth=0'
alias urldomain="sed -e 's|^[^/]*//||' -e 's|/.*$||'"
alias dc=docker-compose
alias cobra='cobra -a "Pierce Bartine" -l mit'
alias av='aws-vault --backend=keychain'
alias kge="kubectl get events --sort-by='.metadata.creationTimestamp' | tail -8"
alias 1p='eval $(op signin my)'

secretpull() {
	local note_uuid
	note_uuid=$(op list items | jq -r '.[] | select(.overview.title=="secrets.sh") | .uuid')
	op get item "$note_uuid" | jq -r '.details.notesPlain' > "$HOME/.secrets.sh"
}

path() {
  echo "$PATH" | tr ':' '\n'
}

yubion() {
  osascript -e 'tell application "yubiswitch" to KeyOn'
}

yubioff() {
  osascript -e 'tell application "yubiswitch" to KeyOff'
}

docker_sweepi() {
  docker rmi "$(docker images --quiet --filter dangling=true)"
}

dockersh() {
  docker run --rm -it --entrypoint sh "$@"
}

dockerip() {
  docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$1"
}

dcos_name () {
  dcos cluster list --attached --json | jq -r '.[].name'
}

dcossel() {
  local cluster_sel
  cluster_sel="$(dcos cluster list --json | jq -r '.[].name' | fzf --height 40%)"
  dcos cluster attach "$cluster_sel"
  declare -x DCOS_CLUSTER_URL
  DCOS_CLUSTER_URL="$(dcos cluster list --attached --json | jq -r '.[].url')"
  echo "$cluster_sel"
}

dcos_users() {
 curl -X GET \
   -H "Authorization: token=$(dcos config show core.dcos_acs_token)" \
   -H 'accept: application/json' \
   "$(dcos config show core.dcos_url)/acs/api/v1/users"
}

ggrep() {
  git rev-list --all | xargs git grep "$@"
}

urlgrep() {
  rg -P --no-line-number --color=never \
  '^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$' "$@"
}

tfvargrep() {
  rg \
    --no-line-number \
    --no-filename \
    --only-matching \
    --glob '*.tf' \
    '(var\.).+?(\b)' \
  | sed 's/var.//g' \
  | sort --unique
}
