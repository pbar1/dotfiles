{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Version control & project tools
    gh # FIXME: use hm
    gnupg
    go-task
    tokei
    sapling # TODO: Use module

    # Command line utils
    _1password
    coreutils
    eza
    fd
    file
    gnused
    hyperfine
    jq
    dyff
    less
    openssl
    procs
    pstree
    ripgrep
    sd
    unixtools.watch
    xz

    # Networking
    dig
    hey
    netcat
    nmap
    socat
    chromedriver

    # Database
    duckdb
    sqlite

    # Cloud
    terraform
    google-cloud-sdk

    # Containers & Kubernetes
    fluxcd
    krew
    kubectl
    kubectx
    kubernetes-helm
    stern
    dive
    trivy
    devbox

    # Nix
    cachix
    nixd
    nixpkgs-fmt

    # Bash
    nodePackages.bash-language-server
    shellcheck
    shfmt

    # Rust
    rustup

    # Go
    go
    gopls
    # gotools # TODO: Conflicts with `ruby`

    # Python
    (python3.withPackages (ps: with ps; [
      beautifulsoup4
      httpx
      pandas
      python-dateutil
      pyyaml
      selenium
    ]))
    black
    isort
    nodePackages.pyright
    # poetry

    # Ruby
    ruby
    rufo

    # Lua
    stylua
    sumneko-lua-language-server

    # JavaScript
    nodejs
    yarn-berry
    bun

    # Dotnet and C#
    dotnet-sdk
    omnisharp-roslyn
  ];
}
