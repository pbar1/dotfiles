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
    neovim-pbar
    tree-sitter
    (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
    chafa
    emacsNativeComp

    # Version control & project tools
    gnupg
    gh # FIXME use hm
    tokei
    go-task
    direnv
    mdbook
    /* hugo */
    ninja
    lazygit
    pre-commit

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
    neofetch

    # Networking
    netcat
    socat
    hey
    jwt-cli

    # DevOps
    vault
    awscli2
    aws-iam-authenticator
    google-cloud-sdk
    sops
    terraform-docs
    terraform-ls
    wrangler

    # Containers & Kubernetes
    dive
    kubectl
    krew
    kubernetes-helm
    stern
    kind
    fluxcd

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
    gnumake
    binutils
    pkg-config
    zlib
    cmake
    cmake-language-server
    vscode-extensions.vadimcn.vscode-lldb

    # Rust
    rustup
    /* (fenix.stable.withComponents [ */
    /*   "cargo" */
    /*   "clippy" */
    /*   "rust-src" */
    /*   "rustc" */
    /*   "rustfmt" */
    /* ]) */
    rust-analyzer

    # Go
    go

    # Python
    (python39.withPackages (ps: with ps; [
      pyyaml
    ]))
    pipenv
    black
    python3Packages.isort
    nodePackages.pyright
    python3Packages.debugpy

    # JavaScript
    nodejs
    nodePackages.prettier
    yarn

    # Lua
    stylua
    sumneko-lua-language-server

    # Java
    jdk
    maven

    # .NET and C#
    dotnet-sdk
    omnisharp-roslyn

    # Config languages
    nodePackages.vscode-json-languageserver
    nodePackages.yaml-language-server
    nodePackages.dockerfile-language-server-nodejs
    nodePackages.vscode-html-languageserver-bin
  ];
}
