{ pkgs, ... }:

let
  # Disable fzf builtin Fish shell integration; we use a plugin instead
  fzf = pkgs.fzf.overrideAttrs (oldAttrs: { preInstall = null; });
in
{
  home.packages = with pkgs; [
    # Version control & project tools
    gh # FIXME use hm
    gnupg
    go-task
    tokei
    sapling

    # Command line utils
    _1password
    coreutils
    exa
    fd
    file
    fzf
    gnused
    hyperfine
    jq
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

    # Cloud
    terraform
    google-cloud-sdk
    fluxcd
    sops
    go-jsonnet
    jsonnet-bundler

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
      httpx
      python-dateutil
      pyyaml
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
  ];
}
