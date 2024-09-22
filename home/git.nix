{ pkgs, ... }:

let
  userName = "Pierce Bartine";
  userEmail = "piercebartine@gmail.com";

  credentialHelper = if pkgs.stdenv.isDarwin then "osxkeychain" else "libsecret";
  sshSignProgram = if pkgs.stdenv.isDarwin then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" else "";
in
{
  programs.git = {
    enable = true;
    inherit userName;
    inherit userEmail;
    signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDim41ofReCgbmijkayBsFg5TlO9qqV8b6Y8Xcwnr49m";
    signing.signByDefault = true;

    extraConfig = {
      branch.autoSetupMerge = "always";
      credential.helper = credentialHelper;
      gpg.format = "ssh";
      gpg.ssh.program = sshSignProgram;
      init.defaultBranch = "main";
      pull.rebase = false;
      push.default = "current";
      push.followTags = true;
    };

    delta.enable = true;
    delta.options.side-by-side = true;

    aliases = {
      root = "rev-parse --show-toplevel";
      co = "checkout";
      unstage = "reset HEAD --";
      br = "branch";
      cm = "commit";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      zap = "remote prune origin";
      remotes = "remote --verbose";
      upstream-name = "!git remote | egrep -o '(upstream|origin)' | tail -1";
      head-branch = "!git remote show $(git upstream-name) | awk '/HEAD branch/ {print $NF}'";
      upstream-auto = "!git remote set-head origin --auto";
      whoami = "config --get-regexp '^user\.'";

      # Mercurial/Sapling emulation
      ci = "commit";
      d = "diff";
      shelve = "stash";
      st = "status --short";
    };

    ignores = [
      "**/.idea/*"
      "**/.DS_Store"
    ];
  };

  programs.sapling = {
    enable = true;
    inherit userName;
    inherit userEmail;

    extraConfig = {
      pager.pager = "delta";
    };

    aliases = {
      cm = "commit";
      d = "diff --exclude=*.lock";
      s = "status";
      update = "goto";
      view = "!$HG config paths.default | xargs open";
      whoami = "config ui.username";
    };
  };
}
