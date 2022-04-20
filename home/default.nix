{ overlays }:

{
  imports = [
    ./env.nix
    ./packages.nix
    ./tmux.nix
    ./fish.nix
    ./starship.nix
    ./git.nix
    ./alacritty.nix
    ./vscode.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;
    inherit overlays;
  };

  home.file.".gnupg/sshcontrol".text = ''
    # personal
    CDCD1DF93F65BF132EB1F33327E34108F53BD47A
    # work
    34DC36A515AA457BF44D8DE158FE03774C6554A0
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

  # https://github.com/nix-community/home-manager/tree/master/modules/programs
  programs.home-manager.enable = true;
  programs.zoxide.enable = true;

  programs.bat = {
    enable = true;
    config = {
      style = "plain";
      theme = "base16-256";
    };
  };
}
