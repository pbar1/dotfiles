#==============================================================================
# ~/.config/sh/env.sh
#
# This file contains customized environment variables. It is sourced elsewhere.
#==============================================================================

# XDG
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

#------------------------------------------------------------------------------
# Shell tools
#------------------------------------------------------------------------------

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# man
export MANPAGER="sh -c 'col -bx | bat --plain --language=man'"

# ncurses
export TERMINFO="${XDG_DATA_HOME}/terminfo"
export TERMINFO_DIRS="${TERMINFO}:/usr/share/terminfo"

# SSH
export SSH_AGENT_PID=""

# screen
export SCREENRC="${XDG_CONFIG_HOME}/screen/screenrc"

# tmux
export TMUX_PLUGIN_MANAGER_PATH="${XDG_CONFIG_HOME}/tmux/plugins"

# Shell history
export HISTFILE="${XDG_DATA_HOME}/zsh/history"

# Zsh
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# less
export LESS="--mouse --use-color --RAW-CONTROL-CHARS --quit-if-one-screen"
export LESSKEY="${XDG_CONFIG_HOME}/less/lesskey"
export LESSHISTFILE="${XDG_CACHE_HOME}/less/history"

# bat
export BAT_CONFIG_PATH="${XDG_CONFIG_HOME}/bat/bat.conf"

# ripgrep
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}/ripgrep/config"

# parallel
export PARALLEL_HOME="${XDG_CONFIG_HOME}/parallel"

# xz
export XZ_DEFAULTS="--verbose --keep --threads=0"

# Zstandard
export ZSTD_NBTHREADS="0"

# FZF
export FZF_DEFAULT_COMMAND="fd --type=file --exclude=.git --hidden --follow"
export FZF_DEFAULT_OPTS='--cycle --layout=reverse --border --height=90% --preview-window=wrap --marker="*"'

#------------------------------------------------------------------------------
# Graphical
#------------------------------------------------------------------------------

# KDE
export KDEHOME="${XDG_CONFIG_HOME}/kde"

# GTK
export GTK_RC_FILES="${XDG_CONFIG_HOME}/gtk-1.0/gtkrc"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"

#------------------------------------------------------------------------------
# Programming
#------------------------------------------------------------------------------

# Go
export GOPATH="${XDG_DATA_HOME}/go"

# Rust
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

# .NET
export NUGET_PACKAGES="${XDG_CACHE_HOME}/NuGetPackages"

# Python
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"

# Ruby
export GEM_HOME="${XDG_DATA_HOME}/gem"
export GEM_SPEC_CACHE="${XDG_CACHE_HOME}/gem"

# Node.js
export NODE_REPL_HISTORY="${XDG_DATA_HOME}/node_repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export NVM_DIR="${XDG_DATA_HOME}/nvm"

# Deno
export DENO_INSTALL_ROOT="${XDG_DATA_HOME}/deno"

# PostgreSQL
export PSQLRC="${XDG_CONFIG_HOME}/pg/psqlrc"
export PSQL_HISTORY="${XDG_CACHE_HOME}/pg/psql_history"
export PGPASSFILE="${XDG_CONFIG_HOME}/pg/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME}/pg/pg_service.conf"

#------------------------------------------------------------------------------
# DevOps
#------------------------------------------------------------------------------

# Docker
export DOCKER_CONFIG="${XDG_CONFIG_HOME}/docker"
export MACHINE_STORAGE_PATH="${XDG_DATA_HOME}/docker-machine"

# Kubernetes
export K9SCONFIG="${XDG_CONFIG_HOME}/k9s"

# DC/OS
export DCOS_DIR="$XDG_CONFIG_HOME/dcos"

# Terraform
export TF_CLI_CONFIG_FILE="${XDG_CONFIG_HOME}/terraform/terraformrc"

# Vault
export VAULT_CONFIG_PATH="${XDG_CONFIG_HOME}/vault/config"

# Vagrant
export VAGRANT_HOME="${XDG_DATA_HOME}/vagrant"
export VAGRANT_ALIAS_FILE="${XDG_DATA_HOME}/vagrant/aliases"

# AWS
export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}/aws/credentials"
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}/aws/config"
export AWS_VAULT_KEYCHAIN_NAME="login"

# GCP
export GOOGLE_APPLICATION_CREDENTIALS="${XDG_CONFIG_HOME}/gcp/credentials.json"

#------------------------------------------------------------------------------
# Paths
#
# NOTE: The actual `PATH` environment variable is not defined here, but rather
# in `~/.config/sh/path.sh`.
#------------------------------------------------------------------------------

export CODEPATH="${HOME}/code"
