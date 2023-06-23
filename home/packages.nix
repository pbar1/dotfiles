{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Version control & project tools
    gh # FIXME use hm
    gnupg
    go-task
    tokei

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
    fluxcd
    sops
    pulumi-bin
    crd2pulumi

    # Jsonnet
    go-jsonnet
    jsonnet-bundler
    jsonnet-language-server

    # Containers & Kubernetes
    krew
    kubectl
    kubectx
    kubernetes-helm
    stern

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
    rust-analyzer
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
