#!/usr/bin/env bash

alias zshrc='$EDITOR $ZDOTDIR/.zshrc'
alias aliasrc='$EDITOR $ZDOTDIR/aliases.sh'
alias vimrc='$EDITOR $XDG_CONFIG_HOME/nvim/init.vim'
alias tmuxrc='$EDITOR $HOME/.tmux.conf'
alias notes='$EDITOR $HOME/notes.txt'

eval "$(hub alias -s)"

alias utime='date +%s'
alias tolower="tr '[:upper:]' '[:lower:]'"
alias toupper="tr '[:lower:]' '[:upper:]'"
alias myip='curl ipinfo.io/ip'
alias ldd='otool -L'
alias cat=bat
alias vi=nvim
alias vim=nvim
alias nc=ncat
alias gl=goland
alias code=code-insiders
alias dotfiles='git --git-dir=$HOME/.config/dotfiles.git/ --work-tree=$HOME'
alias dot=dotfiles
alias dots='dotfiles status -s -uno'
alias gogitignore='cp $XDG_CONFIG_HOME/etc/gogitignore .gitignore'
alias c=clear
alias wo=where
alias l='ls -GlASh'
alias g=git
alias gs='git status -s'
alias gpup='git push -u origin $(git rev-parse --abbrev-ref HEAD)'
alias gcm='git commit'
alias gcmp='git stash && git checkout master && git pull'
alias docker-sweep='docker rm $(docker ps --all --quiet --filter status=exited)'
alias lsnpm='npm ls --local-only --depth=0'
alias urldomain="sed -e 's|^[^/]*//||' -e 's|/.*$||'"
alias cobra='cobra -a "Pierce Bartine" -l none'
alias av='aws-vault --backend=keychain'
alias 1p='eval $(op signin my)'
alias usergen='pwgen --secure --no-capitalize --numerals 8 1'
alias dark='dark-mode on && base16_solarized-dark'
alias light='dark-mode off && base16_solarized-light'
alias x509-decode='openssl x509 -text -noout -in /dev/stdin'
alias cr='docker run --rm -it --entrypoint=/cluster-registry harbor.k8s.platform.einstein.com/docker/cluster-registry:latest'

alias tm=tmux
alias tml='tmux ls'

tma() {
  local session_name
  session_name="$(tmux list-sessions | fzf --height 40% | cut -d':' -f1)"
  tmux attach -t "${session_name}"
}

copy() {
  if [ "$(uname)" = "Darwin" ]; then
    pbcopy
  elif [ "$(uname)" = "Linux" ]; then
    xclip -sel clip
  fi
}

wie() {
  cat "$(command -v "${1}")"
}

gtree() {
    git_ignore_files=("$(git config --get core.excludesfile)" .gitignore ~/.gitignore)
    ignore_pattern="$(grep -hvE '^$|^#' "${git_ignore_files[@]}" 2>/dev/null|sed 's:/$::'|tr '\n' '\|')"
    if git status &> /dev/null && [[ -n "${ignore_pattern}" ]]; then
      tree -I "${ignore_pattern}" "${@}"
    else
      tree "${@}"
    fi
}

urlencode() {
  local toencode
  if [ -z "${1}" ]; then
    toencode="$(cat /dev/stdin)"
  fi
  python3 -c "import urllib.parse as ul; print(ul.quote_plus('${toencode}'))"
}

#------------------------------------------------------------------------------
# Other
#------------------------------------------------------------------------------

vsel() {
  local vaults vault_ldap_user
  vault_ldap_user="pierce.bartine"

  vaults=(
    "https://vault-ops.build-usw2.platform.einstein.com"
    "https://vault.sfiqautomation.com"
    "https://vault.dev.platform.einstein.com"
    "https://vault.staging.platform.einstein.com"
    "https://vault.rc.platform.einstein.com"
    "https://vault.prod.platform.einstein.com"
    "https://vault.rc-euc1.platform.einstein.com"
    "https://vault.prod-euc1.platform.einstein.com"
    "https://vault.perf-usw2.platform.einstein.com"
    "https://legacyprod-usw2-vault.sfiqplatform.com"
  )
  VAULT_ADDR=$(printf '%s\n' "${vaults[@]}" | fzf)
  export VAULT_ADDR

  unset VAULT_TOKEN
  if ! vault token lookup > /dev/null 2>&1; then
    vault login -no-print -method="ldap" username="$vault_ldap_user"
  fi
  VAULT_TOKEN=$(vault print token)
  export VAULT_TOKEN

  echo "Switched to Vault cluster \"${VAULT_ADDR}\""
}

dirsed() {
  rg --files-with-matches --fixed-strings "${1}" \
  | xargs -I {} sed -i '' "s%${1}%${2}%g" {}
}

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

webiqdel() {
  local sg_id
  sg_id="$(webiq list | jq -r '.[].service_group_id' | fzf --height 40%)"
  webiq delete --force -g "$sg_id" -s "$sg_id"
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

avsel () {
  unset AWS_VAULT AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SECURITY_TOKEN \
    AWS_SESSION_TOKEN
  local aws_profile_sel
	aws_profile_sel="$(aws-vault list --profiles | fzf --height 40%)"
	local aws_vault_output
  aws_vault_output="$(aws-vault exec "$aws_profile_sel" -- env | grep AWS)"
  source <(echo "$aws_vault_output" | sed -e 's/^/export /g')
}

aws-build() {
  local mfa_token
  mfa_token=$(op get totp 'AWS (build)')
  local aws_vault_output="$(aws-vault exec --mfa-token=$mfa_token build -- env | grep AWS)"
  source <(echo "$aws_vault_output" | sed -e 's/^/export /g')
}

qm-s3() {
  BUCKET_ARN="arn:aws:s3:::euc1-prod-datastore"

for arn in $(aws iam list-users | jq -r '.Users[].Arn'); do
  decision="$(aws iam simulate-principal-policy \
    --policy-source-arn "$arn" \
    --action-names "s3:GetObject" \
    --resource-arns "$BUCKET_ARN/*" \
  | jq -r '.EvaluationResults[0].EvalDecision')"
  echo "$arn --> $decision"
done
}
