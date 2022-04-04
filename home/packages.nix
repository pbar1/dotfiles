{ pkgs, ... }:

# https://nixos.org/guides/nix-pills/override-design-pattern.html
# Used `nix repl '<nixpkgs>'` to play around with this
let
  # Disable fzf builtin Fish shell integration
  fzf = pkgs.fzf.overrideAttrs (oldAttrs: { preInstall = null; });
in
{
  home.packages = with pkgs; [
    # Editor
    neovim
    tree-sitter
    (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
    chafa

    # Version control & project tools
    gnupg
    gh # FIXME use hm
    tokei
    go-task
    direnv
    mdbook
    hugo
    ninja

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

    # Containers & Kubernetes
    dive
    kubectl
    krew
    kubernetes-helm
    stern
    kind
    fluxcd

    # Nix
    nixpkgs-fmt
    rnix-lsp
    cachix

    # Bash
    shellcheck
    shfmt
    nodePackages.bash-language-server

    # C/C++
    gcc
    cmake

    # Rust
    rustup
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

    # WebAssembly
    wasmtime
  ];
}
