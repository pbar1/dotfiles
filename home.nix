{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pbartine";
  home.homeDirectory = "/Users/pbartine";

  # Packages that should be installed to the user profile.
  # NOTE: We initially have ~320 Homebrew packages, let's see how many we can Nix ;)
  home.packages = with pkgs; [

    # Version control
    git
    delta
    tokei
    go-task
    direnv

    # Shell
    ripgrep
    fd
    sd
    hyperfine
    pv
    pstree
    unixtools.watch
    shellcheck
    shfmt

    # Networking
    netcat
    socat
    hey
    dogdns

    # Containers
    dive

    # Kubernetes
    kubectl
    krew
    kubernetes-helm
    stern
    kubectx
    k9s
    kind

    # Nix
    manix

    # Go
    go

    # Python
    black

    # NodeJS
    nodejs
    nodePackages.prettier

    # .NET and C#
    dotnet-sdk

    # AWS
    awscli2
    aws-iam-authenticator

    # FIXME: Things that might be in `programs` instead. Staging area to get rid of Homebrew.
    gnupg
    neovim
    fzf
    gh
    tmux
    fish
    less
    gnused
    mas
    _1password
    jwt-cli
    starship
    coreutils
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Programs to enable.
  # https://github.com/nix-community/home-manager/tree/master/modules/programs
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "6b592e4140168820f5df9dd28b0a93e409e0d0c3"; # v7.4
          sha256 = "sha256-dngAKzyD+lmqmxsCSOMViyCgA/+Ve35gLtPS+Lgs8Pc=";
        };
      }
    ];
  };
  programs.bat.enable = true;
  programs.exa.enable = true;
  programs.jq.enable = true;
  programs.bottom.enable = true;
  programs.zoxide.enable = true;
  #programs.gh.enable = true;
}
