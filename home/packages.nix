{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Version control & project tools
    go-task
    tokei
    pre-commit

    # Other
    fh
    typst

    # Command line utils
    _1password-cli
    coreutils
    eza
    fd
    fselect
    file
    gnused
    hyperfine
    jq
    xsv
    dyff
    less
    openssl
    procs
    pstree
    ripgrep
    sd
    unixtools.watch
    xz
    ffmpeg

    # Networking
    dig
    hey
    nmap
    socat
    eternal-terminal

    # Database
    duckdb
    sqlite

    # Cloud
    terraform

    # Containers & Kubernetes
    krew
    kubectl
    kubectx
    kubernetes-helm
    stern
    k3d
    dive

    # Nix
    cachix
    nix-tree
    nixd
    nixfmt-rfc-style
    nixdoc

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
    (python3.withPackages (
      p: with p; [
        python-dateutil
        pyyaml
        requests
      ]
    ))
    black
    isort
    poetry

    # Ruby
    (ruby.withPackages (
      p: with p; [
        rails
      ]
    ))

    # Lua
    stylua
    sumneko-lua-language-server

    # JavaScript
    nodejs
    yarn-berry
    deno

    # Dotnet and C#
    dotnet-sdk_8
    omnisharp-roslyn
  ];
}
