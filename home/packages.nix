{ pkgs, ... }:

let
  # Disable fzf builtin Fish shell integration; we use a plugin instead
  fzf = pkgs.fzf.overrideAttrs (oldAttrs: { preInstall = null; });
in
{
  home.packages = with pkgs; [
    # Editor
    (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })

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
    yubikey-manager

    # Networking
    dig
    eternal-terminal
    hey
    jwt-cli
    netcat
    nmap
    socat
    tor

    # Containers & Kubernetes
    jsonnet-bundler
    krew
    kubectl
    kubectx
    kubernetes-helm
    stern
    tanka
    vagrant

    # Nix
    cachix
    nixpkgs-fmt
    rnix-lsp
    statix

    # Bash
    nodePackages.bash-language-server
    shellcheck
    shfmt

    # C/C++
    binutils
    cmake
    cmake-language-server
    gcc

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
  ];
}
