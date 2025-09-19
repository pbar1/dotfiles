{ pkgs, ... }:

let
  userName = "Pierce Bartine";
  userEmail = "piercebartine@gmail.com";

  credentialHelper = if pkgs.stdenv.isDarwin then "osxkeychain" else "libsecret";
  sshSignProgram =
    if pkgs.stdenv.isDarwin then "/Applications/1Password.app/Contents/MacOS/op-ssh-sign" else null;
in
{
  programs.git = {
    enable = true;
    inherit userName;
    inherit userEmail;
    signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDim41ofReCgbmijkayBsFg5TlO9qqV8b6Y8Xcwnr49m github@1password";
    signing.signByDefault = true;

    extraConfig = {
      branch.autoSetupMerge = "always";
      credential.helper = credentialHelper;
      gpg.format = "ssh";
      gpg.ssh.program = sshSignProgram;
      init.defaultBranch = "main";
      pull.rebase = true;
      push.default = "current";
      push.followTags = true;
    };

    delta.enable = true;
    delta.options.side-by-side = true;

    aliases = {
      ar = "add .";
      br = "branch";
      cm = "commit";
      co = "checkout";
      head-branch = "!git remote show $(git upstream-name) | awk '/HEAD branch/ {print $NF}'";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      remotes = "remote --verbose";
      root = "rev-parse --show-toplevel";
      unstage = "reset HEAD --";
      upstream-auto = "!git remote set-head origin --auto";
      upstream-name = "!git remote | egrep -o '(upstream|origin)' | tail -1";
      view = "!gh repo view --web";
      whoami = "config --get-regexp '^user\.'";
      zap = "remote prune origin";

      # Mercurial/Sapling emulation
      ci = "commit --all";
      d = "diff ':!*.lock'";
      shelve = "stash";
      st = "status --short";
    };

    ignores = [
      "**/.idea/*"
      "**/.DS_Store"
      "**/Session.vim"
    ];
  };

  programs.sapling = {
    enable = true;
    inherit userName;
    inherit userEmail;

    extraConfig = {
      pager.pager = "delta";
      gpg.key = "7C92A80F";
    };

    aliases = {
      ar = "addremove";
      cm = "commit";
      d = "diff --exclude=*.lock";
      last = "status --change tip";
      s = "status";
      update = "goto";
      view = "!$HG config paths.default | xargs open";
      whoami = "config ui.username";
    };
  };

  programs.gh.enable = true;
  programs.gh.settings.aliases = {
    co = "pr checkout";
  };
}
