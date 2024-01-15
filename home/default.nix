{ lib, ... }:

{
  imports = [
    ./env.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./hammerspoon
    ./packages.nix
    ./starship.nix
    ./tmux.nix
    ./wezterm
    ./zsh.nix
  ];

  # https://github.com/nix-community/home-manager/issues/2942#issuecomment-1119760100
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

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

  # Fish shell enables this for `man` completion to work, but it is very slow
  # https://github.com/NixOS/nixpkgs/issues/100288
  programs.man.generateCaches = lib.mkForce false;

  programs.zoxide.enable = true;

  # Theme set with environment variable BAT_THEME since Delta also uses it
  programs.bat.enable = true;
  programs.bat.config.style = "plain";
}
