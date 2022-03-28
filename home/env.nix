{ config, ... }:

{
  xdg.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    MANPAGER = "sh -c 'col -bx | bat --plain --language=man'";
    TERMINFO = "${config.xdg.dataHome}/terminfo";
    TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo:/usr/share/terminfo";
    SSH_AGENT_PID = "";
    LESS = "--mouse --use-color --RAW-CONTROL-CHARS --quit-if-one-screen";
    LESSKEY = "${config.xdg.configHome}/less/lesskey";
    LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
    XZ_DEFAULTS = "--verbose --keep --threads = 0";
    ZSTD_NBTHREADS = "0";
    FZF_DEFAULT_COMMAND = "fd --type=file --exclude=.git --hidden --follow";
    FZF_DEFAULT_OPTS = "--color=bg+:#302D41,bg:#1E1E2E,spinner:#F8BD96,hl:#F28FAD --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96 --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD";
    KDEHOME = "${config.xdg.configHome}/kde";
    GTK_RC_FILES = "${config.xdg.configHome}/gtk-1.0/gtkrc";
    GTK2_RC_FILES = "${config.xdg.configHome}/gtk-2.0/gtkrc";
    GOPATH = "${config.xdg.dataHome}/go";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    NUGET_PACKAGES = "${config.xdg.cacheHome}/NuGetPackages";
    PYLINTHOME = "${config.xdg.cacheHome}/pylint";
    GEM_HOME = "${config.xdg.dataHome}/gem";
    GEM_SPEC_CACHE = "${config.xdg.cacheHome}/gem";
    NODE_REPL_HISTORY = "${config.xdg.dataHome}/node_repl_history";
    NPM_CONFIG_USERCONFIG = "${config.xdg.configHome}/npm/npmrc";
    NVM_DIR = "${config.xdg.dataHome}/nvm";
    DENO_INSTALL_ROOT = "${config.xdg.dataHome}/deno";
    PSQLRC = "${config.xdg.configHome}/pg/psqlrc";
    PSQL_HISTORY = "${config.xdg.cacheHome}/pg/psql_history";
    PGPASSFILE = "${config.xdg.configHome}/pg/pgpass";
    PGSERVICEFILE = "${config.xdg.configHome}/pg/pg_service.conf";
    DOCKER_CONFIG = "${config.xdg.configHome}/docker";
    MACHINE_STORAGE_PATH = "${config.xdg.dataHome}/docker-machine";
    K9SCONFIG = "${config.xdg.configHome}/k9s";
    DCOS_DIR = "${config.xdg.configHome}/dcos";
    TF_CLI_CONFIG_FILE = "${config.xdg.configHome}/terraform/terraformrc";
    VAULT_CONFIG_PATH = "${config.xdg.configHome}/vault/config";
    VAGRANT_HOME = "${config.xdg.dataHome}/vagrant";
    VAGRANT_ALIAS_FILE = "${config.xdg.dataHome}/vagrant/aliases";
    AWS_SHARED_CREDENTIALS_FILE = "${config.xdg.configHome}/aws/credentials";
    AWS_CONFIG_FILE = "${config.xdg.configHome}/aws/config";
    AWS_VAULT_KEYCHAIN_NAME = "login";
    GOOGLE_APPLICATION_CREDENTIALS = "${config.xdg.configHome}/gcp/credentials.json";
    CODEPATH = "\${HOME}/code";
  };
}
