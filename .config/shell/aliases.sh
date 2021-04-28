#!/usr/bin/env bash

alias zshrc='$EDITOR $ZDOTDIR/.zshrc'
alias aliasrc='$EDITOR $XDG_CONFIG_HOME/shell/aliases.sh'
alias vimrc='$EDITOR $XDG_CONFIG_HOME/nvim/init.vim'
alias tmuxrc='$EDITOR $XDG_CONFIG_HOME/tmux/tmux.conf'
alias notes='$EDITOR $HOME/notes.txt'

alias utime='date +%s'
alias tolower="tr '[:upper:]' '[:lower:]'"
alias toupper="tr '[:lower:]' '[:upper:]'"
alias myip='curl ipinfo.io/ip'
alias ldd='otool -L'
alias cat=bat
alias vi=nvim
alias vim=nvim
alias ij=idea
alias gl=idea
alias code=code
alias dotfiles='git --git-dir=$HOME/.config/dotfiles.git/ --work-tree=$HOME'
alias dot=dotfiles
alias dots='dotfiles status -s -uno'
alias gogitignore='cp $XDG_CONFIG_HOME/etc/gogitignore .gitignore'
alias c=clear
alias wo=where
alias l='lsd --long'
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
alias x509-decode='openssl x509 -text -noout -in /dev/stdin'
alias cr='docker run --rm -it --entrypoint=/cluster-registry harbor.k8s.platform.einstein.com/docker/cluster-registry:latest'
alias xi='xargs -I {}'
alias tm=tmux
alias tml='tmux ls'
alias rgf='rg --fixed-strings'
alias rgi='rg --ignore-case'
alias mesos-mini='docker run --rm --privileged -p 5050:5050 -p 5051:5051 -p 8080:8080 mesos/mesos-mini'
alias condaon='source /opt/anaconda/bin/activate root'
alias condaoff='source /opt/anaconda/bin/deactivate root'
alias tf=terraform

# can also set dark mode to 'not dark mode' to toggle
alias dark="base16_solarized-dark && osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to true' && _fzf_opts_dark"
alias light="base16_solarized-light && osascript -e 'tell app \"System Events\" to tell appearance preferences to set dark mode to false' && _fzf_opts_light"

# Syncs a local git repo with remote. Discovers if using a fork and keeps it updated.
# NOTE: if upstream symbolic ref fails, run: git remote set-head upstream --auto
gg() {
  local main_origin=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's|^refs/remotes/origin/||')
  if git remote | grep --quiet upstream; then
    local main_upstream=$(git symbolic-ref refs/remotes/upstream/HEAD | sed 's|^refs/remotes/upstream/||')
    git fetch upstream && git checkout ${main_origin} && git merge upstream/${main_upstream} && git push origin ${main_origin}
  else
    git checkout ${main_origin} && git pull
  fi
}

jqflat() {
  jq '[leaf_paths as $path | {"key": $path | join("."), "value": getpath($path)}] | from_entries' $@
}

vaultaudlog() {
  kubectl logs --selector=vault-active=true --follow \
  | jqflat -c \
  | fblog --level-key=type -a request.id -a request.operation -a request.path -a auth.token_policies.0
}

secsu() {
  op get item secrets.env > /dev/null 2>&1 || eval $(op signin)
  eval "$(op get item secrets.env | jq '.details.sections[0].fields' | gq "export{{range .}} {{.t }}='{{.v}}'{{end}}")"
}

numeronym() {
  str="${1}"
  echo "${str:0:1}$(echo ${str:1:-1} | wc -c | tr -d '[:space:]')${str: -1}"
}

ddd() {
  local file disk bs filesize
  file="${1}"
  disk="${2}"
  bs="${3:-4m}"
  filesize="$(du -sh "${file}" | cut -f1)"
  diskutil unmountDisk "${disk}"
  dd if="${file}" | pv -s "${filesize}" | sudo dd of="${disk}" bs="${bs}"
}

helmgrep() {
  for f in $(ls | grep "${1}"); do
    image_tag="$(cat "${f}/values/$(basename "${PWD}").yaml" | yq read - docker.tag)"
    replicas="$(cat "${f}/values/$(basename "${PWD}").yaml" | yq read - appConfigs.replicaCount)"
    printf "%s : %s : replicas=%s\n" $f $image_tag $replicas
  done
}

kgaa() {
  kubectl get-all --namespace="$(kubectl config view --minify --output='jsonpath={..namespace}')"
}

kexp() {
  local expirytime
  expirytime="$(kubectl config view --flatten --minify -ojsonpath='{.users[0].user.auth-provider.config.id-token}' | jwt decode --json - | jq -r '.payload.exp')"
  date -r "${expirytime}"
}

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

# Usage: sshfwd <port> [ssh args]
sshfwd() {
  local port
  port=$1
  shift

  # -o ControlPersist=yes  : Prevents connection from being closed if ControlMaster=auto is set
  # -N                     : Do not execute a remote command
  # -T                     : Disables pseudo-terminal allocation
  # -L PORT:127.0.0.1:PORT : Forwards remote PORT to same port on localhpst
  ssh -o ControlPersist=yes -N -T -L "${port}:127.0.0.1:${port}" "${@}"
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
    "https://vault.perf.platform.einstein.com"
    "https://legacyprod-usw2-vault.sfiqplatform.com"
  )
  VAULT_ADDR=$(printf '%s\n' "${vaults[@]}" | fzf)
  export VAULT_ADDR

  unset VAULT_TOKEN
  if ! vault token lookup > /dev/null 2>&1; then
    vault login -no-print -method="ldap" username="${vault_ldap_user}"
  fi
  VAULT_TOKEN=$(vault print token)
  export VAULT_TOKEN

  echo "Switched to Vault cluster \"${VAULT_ADDR}\""
}

r53dig() {
  local hostname zone_name zone_id
  hostname="${1}"
  zone_name="$(echo "${hostname}" | cut -d '.' -f 2-)"
  zone_id="$(aws route53 list-hosted-zones | jq -r ".HostedZones[] | select(.Name==\"${zone_name}.\") | .Id" | fzf)"
  aws route53 list-resource-record-sets --hosted-zone-id="${zone_id}" | jq -r ".ResourceRecordSets[] | select(.Name==\"${hostname}.\")"
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

ykon() {
  ykman config usb --force --enable=otp
}

ykoff() {
  ykman config usb --force --disable=otp
}

docker_sweepi() {
  docker rmi "$(docker images --quiet --filter dangling=true)"
}

dockersh() {
  docker run \
    --rm \
    --interactive \
    --tty \
    --volume="${PWD}:/workdir" \
    --workdir="/workdir" \
    --entrypoint="sh" \
    "$@"
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

webiqdel-dcosonly() {
  local sg_id
  sg_id="$(webiq list | jq -r '.[].service_group_id' | fzf --height 40%)"
  webiq delete --force --dcos-only -g "$sg_id" -s "$sg_id"
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

# Sources AWS credentials into environmnent variables.
# Uses aws-vault for role assumption, and op (1Password CLI) for MFA token generation.
# USAGE: avsel
avsel () {
  local aws_profile_sel aws_vault_output mfa_token session_arn
  unset AWS_VAULT AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SECURITY_TOKEN AWS_SESSION_TOKEN
	aws_profile_sel="$(aws-vault list --profiles | fzf --height='40%')"
  mfa_token="$(op get totp "AWS (${aws_profile_sel})")"
  aws_vault_output="$(aws-vault exec "${aws_profile_sel}" --mfa-token="${mfa_token}" -- env | grep 'AWS')"
  source <(echo "${aws_vault_output}" | sed -e 's|^|export |g')
  session_arn="$(aws sts get-caller-identity | jq -r '.Arn')"
  echo "Current caller identity: ${session_arn}"
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
