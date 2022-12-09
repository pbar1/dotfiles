{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Pierce Bartine";
    userEmail = "piercebartine@gmail.com";
    signing.key = null; # GPG picks key based on email if not set
    signing.signByDefault = true;

    extraConfig = {
      branch.autoSetupMerge = "always";
      credential.helper = if pkgs.stdenv.isDarwin then "osxkeychain" else "libsecret";
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
    };

    ignores = [
      "**/.idea/*"
      "**/.DS_Store"
    ];
  };
}
