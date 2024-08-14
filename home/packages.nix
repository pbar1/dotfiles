{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Version control & project tools
    gh # FIXME: use hm
    gnupg
    go-task
    tokei
    # sapling # TODO: Use module
    bazelisk
    (writeShellScriptBin "bazel" ''exec "${bazelisk}/bin/bazelisk" "$@"'')
    bazel-buildtools
    buckle
    (writeShellScriptBin "buck" ''exec "${buckle}/bin/buckle" "$@"'')
    (writeShellScriptBin "buck2" ''exec "${buckle}/bin/buckle" "$@"'')

    # Other
    fh
    typst

    # Command line utils
    _1password
    coreutils
    eza
    fd
    fselect
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
    ffmpeg

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
    k3d
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
      pandas
      python-dateutil
      pyyaml
      requests
      selenium
    ]))
    black
    isort
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
    deno
    bun

    # Dotnet and C#
    dotnet-sdk
    omnisharp-roslyn
  ];
}
