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
    neovim # FIXME use hm

    # Version control & project tools
    gnupg
    git # FIXME use hm
    gh # FIXME use hm
    delta
    tokei
    go-task
    direnv

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

    # Networking
    netcat
    socat
    hey

    # DevOps
    vault
    awscli2
    aws-iam-authenticator
    sops
    terraform-docs

    # Containers & Kubernetes
    dive
    trivy
    kubectl
    krew
    kubernetes-helm
    stern
    kind
    fluxcd

    # Nix
    nixpkgs-fmt
    manix

    # Bash
    shellcheck
    shfmt

    # Go
    go

    # Python
    (python39.withPackages (ps: with ps; [
      pyyaml
    ]))
    pipenv
    black

    # JavaScript
    nodejs
    nodePackages.prettier
    yarn

    # .NET and C#
    dotnet-sdk

    # Rust
    rustup

    # FIXME: macOS items that should be in nix-darwin config
    mas
  ];
}
