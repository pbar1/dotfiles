{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings

      set -gx GPG_TTY (tty)
      set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    '';

    # Flake inputs with the prefix `fish:` automatially end up here via overlay
    plugins = pkgs.lib.attrsets.mapAttrsToList
      (name: value: {
        inherit name;
        inherit (value) src;
      })
      pkgs.myFishPlugins;

    shellAbbrs = {
      "," = "nix-shell --packages";
      c = "clear";
      cb = "cargo build";
      cr = "cargo run";
      ct = "cargo test";
      e = "$EDITOR";
      fdh = "fd --no-hidden --no-ignore";
      g = "git";
      gd = "git diff -- ':!*.lock'";
      gs = "git status --short";
      hg = "sl"; # FIXME: Not if work machine
      ij = "idea";
      jf = "sl pr"; # FIXME: Not if work machine
      k = "kubectl";
      kapi = "kubectl api-resources";
      kge = "kubectl get events --watch";
      kgg = "kubectl get pods,replicasets,deployments,statefulsets,daemonsets,jobs,cronjobs";
      kgi = "kubectl get ingresses,services,endpoints,certificates,certificaterequests,certificatesigningrequests,challenges,orders";
      kgn = "kubectl get namespaces --show-labels";
      kgno = "kubectl get nodes --label-columns=beta.kubernetes.io/instance-type,failure-domain.beta.kubernetes.io/zone";
      kgp = "kubectl get pods";
      kn = "kubens";
      kubeconfig = "kubectl config view --minify --flatten";
      kx = "kubectx";
      lt = "exa --tree";
      nv = "nvim";
      rgf = "rg --fixed-strings";
      rgi = "rg --ignore-case";
      star = "starship";
      tf = "terraform";
      wkgp = "watch kubectl get pods";
      wo = "type --all --short --path";
      xi = "xargs -I {}";
    };

    shellAliases = {
      cat = "bat";
      copy = if pkgs.stdenv.isDarwin then "pbcopy" else "wl-copy --trim-newline";
      l = "exa --header --all --long --git";
      tree = "exa --tree";
      yktog = "ykman config usb --list | grep --quiet OTP && ykman config usb --force --disable=otp || ykman config usb --force --enable=otp";
    };

    functions = {
      light = ''
        base16-gruvbox-light-soft
        base16-fzf-gruvbox-light-soft
        set -Ux BAT_THEME gruvbox-light
      '';

      dark = ''
        base16-gruvbox-dark-soft
        base16-fzf-gruvbox-dark-soft
        set -Ux BAT_THEME gruvbox-dark
      '';

      # https://github.com/base16-project/base16-fzf/blob/main/fish/base16-gruvbox-dark-soft.fish
      base16-fzf-gruvbox-light-soft = ''
        set -l color00 '#f2e5bc'
        set -l color01 '#ebdbb2'
        set -l color02 '#d5c4a1'
        set -l color03 '#bdae93'
        set -l color04 '#665c54'
        set -l color05 '#504945'
        set -l color06 '#3c3836'
        set -l color07 '#282828'
        set -l color08 '#9d0006'
        set -l color09 '#af3a03'
        set -l color0A '#b57614'
        set -l color0B '#79740e'
        set -l color0C '#427b58'
        set -l color0D '#076678'
        set -l color0E '#8f3f71'
        set -l color0F '#d65d0e'

        set -l FZF_NON_COLOR_OPTS

        for arg in (echo $FZF_DEFAULT_OPTS | tr " " "\n")
            if not string match -q -- "--color*" $arg
                set -a FZF_NON_COLOR_OPTS $arg
            end
        end

        set -Ux FZF_DEFAULT_OPTS "$FZF_NON_COLOR_OPTS"\
        " --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
        " --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
        " --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
      '';

      # https://github.com/base16-project/base16-fzf/blob/main/fish/base16-gruvbox-dark-soft.fish
      base16-fzf-gruvbox-dark-soft = ''
        set -l color00 '#32302f'
        set -l color01 '#3c3836'
        set -l color02 '#504945'
        set -l color03 '#665c54'
        set -l color04 '#bdae93'
        set -l color05 '#d5c4a1'
        set -l color06 '#ebdbb2'
        set -l color07 '#fbf1c7'
        set -l color08 '#fb4934'
        set -l color09 '#fe8019'
        set -l color0A '#fabd2f'
        set -l color0B '#b8bb26'
        set -l color0C '#8ec07c'
        set -l color0D '#83a598'
        set -l color0E '#d3869b'
        set -l color0F '#d65d0e'

        set -l FZF_NON_COLOR_OPTS

        for arg in (echo $FZF_DEFAULT_OPTS | tr " " "\n")
            if not string match -q -- "--color*" $arg
                set -a FZF_NON_COLOR_OPTS $arg
            end
        end

        set -Ux FZF_DEFAULT_OPTS "$FZF_NON_COLOR_OPTS"\
        " --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D"\
        " --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C"\
        " --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
      '';

      vault-login = ''
        set sel (cat "$XDG_CONFIG_HOME/vault/addrs" | grep -v '#' | fzf)
        set --global --export VAULT_ADDR (string split ';' -f 1 $sel)
        set --erase VAULT_TOKEN
        if not vault token lookup > /dev/null 2>&1
          set method (string split ';' -f 2 $sel)
          set params (string split ';' -f 3 $sel)
          vault login -no-print -method=$method $params
        end
        set --global --export VAULT_TOKEN (vault print token)
        echo "Switched to Vault: $VAULT_ADDR"
      '';

      vault-aws = ''
        set aws_role (vault list -format=json aws/roles | jq -r .[] | fzf)
        vault read -format=json aws/creds/$aws_role | jq -c . |  read --local vault_json
        set --erase AWS_VAULT AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SECURITY_TOKEN AWS_SESSION_TOKEN
        set --global --export AWS_ACCESS_KEY_ID (echo $vault_json | jq -r .data.access_key)
        set --global --export AWS_SECRET_ACCESS_KEY (echo $vault_json | jq -r .data.secret_key)
        set --global --export AWS_SESSION_TOKEN (echo $vault_json | jq -r .data.security_token)
        aws sts get-caller-identity
      '';
    };
  };
}