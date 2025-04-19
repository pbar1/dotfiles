{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Version control & project tools
    go-task
    tokei
    pre-commit

    # Other
    typst

    # Command line utils
    _1password-cli
    coreutils
    eza
    fd
    fselect
    file
    gnused
    gawk
    hyperfine
    jq
    dyff
    less
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

    # Lua
    stylua
    sumneko-lua-language-server

    # JavaScript
    nodejs
    yarn-berry
    deno
    bun

    # Dotnet and C#
    (
      with dotnetCorePackages;
      combinePackages [
        sdk_8_0
        sdk_9_0
      ]
    )
  ];
}
