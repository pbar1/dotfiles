{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    package = pkgs.vscode;

    extensions = with pkgs.vscode-extensions; [
      asvetliakov.vscode-neovim
      christian-kohler.path-intellisense
      editorconfig.editorconfig
      foxundermoon.shell-format
      golang.go
      james-yu.latex-workshop
      jdinhlife.gruvbox
      jnoortheen.nix-ide
      matklad.rust-analyzer
      ms-python.vscode-pylance
      redhat.vscode-yaml
      streetsidesoftware.code-spell-checker
      timonwong.shellcheck
      vadimcn.vscode-lldb
      yzhang.markdown-all-in-one
    ];

    userSettings = {
      "editor.fontFamily" = "Iosevka";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 18;
      "telemetry.telemetryLevel" = "off";
      "terminal.integrated.copyOnSelection" = true;
      "terminal.integrated.fontSize" = 18;
      "terminal.integrated.rightClickBehavior" = "copyPaste";
      "vscode-neovim.neovimExecutablePaths.linux" = "${pkgs.neovim-unwrapped}/bin/nvim";
      "window.autoDetectColorScheme" = true;
      "window.titleBarStyle" = "custom";
      "workbench.colorTheme" = "Gruvbox Dark Medium";
      "workbench.preferredDarkColorTheme" = "Gruvbox Dark Medium";
      "workbench.preferredLightColorTheme" = "Gruvbox Light Medium";
      "workbench.startupEditor" = "none";

      # To respect <CapsLock> remaped to <Esc>
      # https://github.com/Microsoft/vscode/wiki/Keybinding-Issues#troubleshoot-linux-keybindings
      "keyboard.dispatch" = "keyCode";
    };

    # TODO: https://github.com/nix-community/home-manager/issues/2798
    mutableExtensionsDir = false;
  };
}
