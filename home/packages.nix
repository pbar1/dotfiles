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

    # Networking
    netcat
    socat
    hey

    # DevOps
    vault
    awscli2
    aws-iam-authenticator

    # Containers & Kubernetes
    dive
    kubectl
    krew
    kubernetes-helm
    stern
    kind

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
    black

    # NodeJS
    nodejs
    nodePackages.prettier

    # .NET and C#
    dotnet-sdk

    # FIXME: macOS items that should be in nix-darwin config
    mas
  ];
}
