#!/usr/bin/env zsh

# set XDG directories explicitly to their defaults, so they can be used on all
# systems, including macOS
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_RUNTIME_DIR="/tmp"

# unix
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export HISTFILE="${XDG_DATA_HOME}/zsh/history"
export SCREENRC="${XDG_CONFIG_HOME}/screen/screenrc"
export TMUX_PLUGIN_MANAGER_PATH="${XDG_CONFIG_HOME}/tmux/plugins"
export TMUXP_CONFIGDIR="${XDG_CONFIG_HOME}/tmuxp"
export LESSKEY="${XDG_CONFIG_HOME}/less/lesskey"
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"
export BAT_CONFIG_PATH="${XDG_CONFIG_HOME}/bat/bat.conf"
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
alias wget="wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts"
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"

# devops
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export MACHINE_STORAGE_PATH="${XDG_DATA_HOME}/docker-machine"
export DCOS_DIR="${XDG_CONFIG_HOME}/dcos"
export TF_CLI_CONFIG_FILE="${XDG_CONFIG_HOME}/terraform/terraformrc"
export VAULT_CONFIG_PATH="${XDG_CONFIG_HOME}/vault/config"
export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
export VAGRANT_ALIAS_FILE="${XDG_DATA_HOME}/vagrant/aliases"
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export GOOGLE_APPLICATION_CREDENTIALS="${XDG_CONFIG_HOME}/gcp/credentials.json"

# programming language support
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"
export GEM_HOME="${XDG_DATA_HOME}/gem"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem"
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NVM_DIR="${XDG_DATA_HOME}/nvm"
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

# other
export PSQLRC="${XDG_CONFIG_HOME}/pg/psqlrc"
export PSQL_HISTORY="${XDG_CACHE_HOME}/pg/psql_history"
export PGPASSFILE="${XDG_CONFIG_HOME}/pg/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME}/pg/pg_service.conf"
#export VSCODE_APPDATA="${XDG_CONFIG_HOME}"
