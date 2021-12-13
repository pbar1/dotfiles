{ config, pkgs, ... }:

let
  fzf = pkgs.fzf.overrideAttrs (oldAttrs: { preInstall = null;  });
in {
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
    kubie
    k9s
    kind
    fluxcd

    # Nix
    nixpkgs-fmt
    manix

    # Go
    go

    # Python
    black
    (python39.withPackages (ps: with ps; [
      pyyaml
    ]))

    # NodeJS
    nodejs
    nodePackages.prettier

    # .NET and C#
    dotnet-sdk

    # AWS
    awscli2
    aws-iam-authenticator

    # FIXME: Things that might be in `programs` instead. Staging area to get rid of Homebrew.
    fzf
    gnupg
    neovim
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
    vault
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
      {
        name = "bang-bang";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-bang-bang";
          rev = "f969c618301163273d0a03d002614d9a81952c1e";
          sha256 = "sha256-A8ydBX4LORk+nutjHurqNNWFmW6LIiBPQcxS3x4nbeQ=";
        };
      }
      {
        name = "fish-kubectl-completions";
        src = pkgs.fetchFromGitHub {
          owner = "evanlucas";
          repo = "fish-kubectl-completions";
          rev = "ced676392575d618d8b80b3895cdc3159be3f628";
          sha256 = "sha256-OYiYTW+g71vD9NWOcX1i2/TaQfAg+c2dJZ5ohwWSDCc=";
        };
      }
      {
        name = "fish-async-prompt";
        src = pkgs.fetchFromGitHub {
          owner = "acomagu";
          repo = "fish-async-prompt";
          rev = "40f30a4048b81f03fa871942dcb1671ea0fe7a53";
          sha256 = "sha256-sSM8jB81TO+n0JVl8ekfVbw99K5NzEdxi1VqWkhIJaY=";
        };
      }
      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "2fd3d2157d5271ca3575b13daec975ca4c10577a";
          sha256 = "sha256-fl4/Pgtkojk5AE52wpGDnuLajQxHoVqyphE90IIPYFU=";
        };
      }
    ];

    shellAbbrs = {
      kgp = "kubectl get pod -o wide";
    };
  };

  programs.starship = {
    enable = true;

    settings = {
      format = "$username$hostname$directory$shell$shlvl$git_branch$git_commit$git_state$git_status$nix_shell$golang$rust$java$python$nodejs$terraform$kubernetes$helm$aws$cmd_duration$custom$status$jobs$battery$time$line_break$character";

      username = {
        disabled = true;
        format = "[$user]($style)@";
        show_always = false;
      };

      hostname = {
        disabled = true;
        format = "[$hostname]($style):";
        ssh_only = false;
      };

      directory = {
        disabled = false;
        format = "[$path]($style)[$read_only]($read_only_style)";
      };

      shell = {
        disabled = false;
        format = "[$indicator]($style)";
        zsh_indicator = "";
        bash_indicator = " bash:";
        fish_indicator = " fish:";
        powershell_indicator = " posh:";
        ion_indicator = " ion:";
        elvish_indicator = " elvish:";
        tcsh_indicator = " tcsh:";
        xonsh_indicator = " xonsh:";
        unknown_indicator = " unknown:";
      };

      shlvl = {
        disabled = false;
        format = "[$shlvl]($style)";
      };

      git_branch = {
        disabled = false;
        format = " [$symbol $branch]($style)";
        symbol = "";
        truncation_length = 10;
        truncation_symbol = "…";
        only_attached = false;
      };

      git_commit = {
        disabled = false;
        format = " [$hash $tag]($style)";
      };

      git_status.disabled = true;

      nix_shell = {
        disabled = false;
        format = " [$symbol $name$state]($style)";
        symbol = "❄️";
        style = "bold white";
        pure_msg = "(pure)";
        impure_msg = "";
      };

      rust = {
        disabled = false;
        format = " [$symbol $version]($style)";
        symbol = "🦀";
      };

      golang = {
        disabled = false;
        format = " [$symbol $version]($style)";
        symbol = "";
      };

      python = {
        disabled = false;
        format = " [$symbol $version]($style)";
        symbol = "🐍";
      };

      terraform = {
        disabled = false;
        format = " [$symbol $workspace]($style)";
        symbol = "▰";
      };

      kubernetes = {
        disabled = false;
        format = " [$symbol $context:$namespace]($style)";
        symbol = "☸";
        style = "bold blue";
      };

      helm.disabled = true;
      aws.disabled = true;
      gcloud.disabled = true;

      status = {
        disabled = false;
        symbol = "⚠️";
        format = " [$symbol $common_meaning$signal_name$maybe_int]($style)";
      };

      cmd_duration = {
        disabled = false;
        format = " [$duration]($style)";
      };

      character = {
        success_symbol = "[♪]()";
        error_symbol = "[ø](red)";
        vicmd_symbol = "[V](blue)";
      };
    };
  };

  programs.bat.enable = true;
  programs.exa.enable = true;
  programs.jq.enable = true;
  programs.bottom.enable = true;
  programs.zoxide.enable = true;
  #programs.gh.enable = true;
}
