{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Version control & project tools
    gh # FIXME use hm
    gnupg
    go-task
    tokei
    sapling # TODO: Use module

    # Command line utils
    _1password
    coreutils
    exa
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
    tor
    chromedriver

    # Cloud
    terraform
    google-cloud-sdk
    pulumi-bin
    crd2pulumi

    # Jsonnet
    go-jsonnet
    jsonnet-bundler
    jsonnet-language-server

    # Containers & Kubernetes
    fluxcd
    kn
    krew
    kubectl
    kubectx
    kubernetes-helm
    stern
    nodePackages.cdk8s-cli

    # WebAssembly
    wasmer

    # Nix
    cachix
    nil
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
    gotools

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

    # Lua
    stylua
    sumneko-lua-language-server

    # JavaScript
    nodejs
    yarn

    # Dotnet and C#
    dotnet-sdk
    omnisharp-roslyn
  ];
}
