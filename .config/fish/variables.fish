# Set XDG directories explicitly to their defaults, so they can be used on all
# systems, including macOS
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_DATA_HOME "$HOME/.local/share"

# Path variables
set -gx CODEPATH "$HOME/code"
set -gx GOPATH "$XDG_DATA_HOME/go"
fish_add_path \
  "$HOME/.local/bin" \
  "$HOME/.krew/bin" \
  "$GOPATH/bin" \
  "$XDG_DATA_HOME/cargo/bin" \
  "$XDG_DATA_HOME/npm/bin"

# (XDG support) Unix
set -gx ZDOTDIR "$XDG_CONFIG_HOME/zsh"
set -gx HISTFILE "$XDG_DATA_HOME/zsh/history"
set -gx SCREENRC "$XDG_CONFIG_HOME/screen/screenrc"
set -gx TMUX_PLUGIN_MANAGER_PATH "$XDG_CONFIG_HOME/tmux/plugins"
set -gx TMUXP_CONFIGDIR "$XDG_CONFIG_HOME/tmuxp"
set -gx LESSKEY "$XDG_CONFIG_HOME/less/lesskey"
set -gx LESSHISTFILE "$XDG_CACHE_HOME/less/history"
set -gx BAT_CONFIG_PATH "$XDG_CONFIG_HOME/bat/bat.conf"
set -gx WGETRC "$XDG_CONFIG_HOME/wgetrc"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
set -gx GNUPGHOME "$XDG_CONFIG_HOME/gnupg"
set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME/pass"
set -gx XZ_DEFAULTS "--verbose --keep --threads=0"

# (XDG support) DevOps
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -gx MACHINE_STORAGE_PATH "$XDG_DATA_HOME/docker-machine"
set -gx DCOS_DIR "$XDG_CONFIG_HOME/dcos"
set -gx TF_CLI_CONFIG_FILE "$XDG_CONFIG_HOME/terraform/terraformrc"
set -gx VAULT_CONFIG_PATH "$XDG_CONFIG_HOME/vault/config"
set -gx VAGRANT_HOME "$XDG_DATA_HOME/vagrant"
set -gx VAGRANT_ALIAS_FILE "$XDG_DATA_HOME/vagrant/aliases"
set -gx AWS_SHARED_CREDENTIALS_FILE "$XDG_CONFIG_HOME/aws/credentials"
set -gx AWS_CONFIG_FILE "$XDG_CONFIG_HOME/aws/config"
set -gx GOOGLE_APPLICATION_CREDENTIALS "$XDG_CONFIG_HOME/gcp/credentials.json"

# (XDG support) Programming toolchains
set -gx JAVA_HOME "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home"
set -gx PYLINTHOME "$XDG_CACHE_HOME/pylint"
set -gx GEM_HOME "$XDG_DATA_HOME/gem"
set -gx GEM_SPEC_CACHE "$XDG_CACHE_HOME/gem"
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
set -gx NVM_DIR "$XDG_DATA_HOME/nvm"
set -gx RUSTUP_HOME "$XDG_DATA_HOME/rustup"
set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"

# (XDG support) Other
set -gx PSQLRC "$XDG_CONFIG_HOME/pg/psqlrc"
set -gx PSQL_HISTORY "$XDG_CACHE_HOME/pg/psql_history"
set -gx PGPASSFILE "$XDG_CONFIG_HOME/pg/pgpass"
set -gx PGSERVICEFILE "$XDG_CONFIG_HOME/pg/pg_service.conf"
#set -gx VSCODE_APPDATA "$XDG_CONFIG_HOME"

# Misc variables
set -gx AWS_VAULT_KEYCHAIN_NAME "login"
set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
