{ pkgs, ... }:

# https://nixos.org/guides/nix-pills/override-design-pattern.html
# Used `nix repl '<nixpkgs>'` to play around with this
let
  # Disable fzf builtin Fish shell integration; we use a plugin instead
  fzf = pkgs.fzf.overrideAttrs (oldAttrs: { preInstall = null; });
in
{
  home.packages = with pkgs; [
    # Editor
    (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
    chafa

    # Version control & project tools
    gnupg
    gh # FIXME use hm
    tokei
    go-task
    direnv
    mdbook
    ninja
    lazygit

    # Command line utils
    coreutils
    fzf
    ripgrep
    fd
    sd
    exa
    hyperfine
    unixtools.watch
    less
    gnused
    jq
    _1password
    xz
    procs
    openssl
    yubikey-manager
    pstree
    pfetch

    # Networking
    netcat
    socat
    eternal-terminal
    hey
    jwt-cli
    dogdns
    nmap
    tor

    # Containers & Kubernetes
    dive
    kubectl
    krew
    kubernetes-helm
    stern
    kind
    fluxcd
    kubectx
    tanka
    jsonnet-bundler
    vagrant

    # Nix
    rnix-lsp
    nixpkgs-fmt
    statix
    cachix

    # Bash
    shellcheck
    shfmt
    nodePackages.bash-language-server

    # C/C++
    gcc
    binutils
    cmake
    cmake-language-server
    # vscode-extensions.vadimcn.vscode-lldb

    # Rust
    rustup
    rust-analyzer
    rust-bindgen

    # Go
    go
    gopls
    gotools

    # Python
    (python3.withPackages (ps: with ps; [
      pyyaml
    ]))
    poetry
    nodePackages.pyright

    # Lua
    stylua
    sumneko-lua-language-server

    # WebAssembly
    wasmer
  ];
}
