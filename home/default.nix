{ lib, pkgs, ... }:

{
  imports = [
    # ./vscode.nix
    # ./zsh.nix
    ./env.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./nvim
    ./packages.nix
    ./starship.nix
    ./tmux.nix
    ./wezterm
  ];

  nixpkgs = {
    config.allowUnfree = true;

    # TODO: https://github.com/nix-community/home-manager/issues/2942
    config.allowUnfreePredicate = (pkg: true);
  };

  # TODO: Include Nix sourcing here if needed in the future (ie, macOS upgrade)
  # Zsh is disabled, but on macOS it is the default shell. Instead of changing
  # shells, we move into Fish.
  home.file.".zshrc".text = lib.mkIf pkgs.stdenv.isDarwin ''
    if [[ $(ps -p $PPID -o comm=) != "fish" && -z $ZSH_EXECUTION_STRING ]]
    then
        exec fish
    fi
  '';

  home.file.".gnupg/sshcontrol".text = ''
    # personal
    CDCD1DF93F65BF132EB1F33327E34108F53BD47A
  '';

  home.file.".editorconfig".text = ''
    root = true

    [*]
    charset = utf-8
    end_of_line = lf
    indent_size = 2
    indent_style = space
    insert_final_newline = true
    trim_trailing_whitespace = true

    [*{M,m}akefile]
    indent_style = tab

    [*.{py,rs}]
    indent_size = 4

    [*.go]
    indent_size = 4
    indent_style = tab

    [*.lua]
    indent_size = 3

    [*.md]
    max_line_length = 80
  '';

  programs.home-manager.enable = true;

  programs.zoxide.enable = true;

  programs.bat.enable = true;
  programs.bat.config.style = "plain";

  programs.sapling.enable = true;
  programs.sapling.userName = "Pierce Bartine";
  programs.sapling.userEmail = "piercebartine@gmail.com";
  programs.sapling.aliases = {
    cm = "commit";
    d = "diff --exclude=*.lock";
    s = "status";
    view = "!$HG config paths.default | xargs open";
  };
  programs.sapling.extraConfig = {
    pager.pager = "delta";
    # piercebartine@gmail.com
    gpg.key = "9C50D0763BD88153A18C7273067A906C7C92A80F";
  };
}
