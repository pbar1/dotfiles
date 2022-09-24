{ ... }:

{
  imports = [
    ./env.nix
    ./fish.nix
    ./git.nix
    ./nvim
    ./packages.nix
    ./starship.nix
    ./tmux.nix
    ./wezterm
    ./vscode.nix
  ];

  nixpkgs = {
    config.allowUnfree = true;

    # TODO: https://github.com/nix-community/home-manager/issues/2942
    config.allowUnfreePredicate = (pkg: true);
  };

  home.file.".gnupg/sshcontrol".text = ''
    # personal
    CDCD1DF93F65BF132EB1F33327E34108F53BD47A
    # work
    98A14E84BFC1A99FDE258E54659F86F577798596
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

  programs.bat = {
    enable = true;
    config = {
      style = "plain";
      theme = "base16-256";
    };
  };
}
