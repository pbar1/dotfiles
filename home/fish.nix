{ pkgs, ... }:

let
  shellAliases = import ./shell/aliases.nix { inherit pkgs; };
  shellAbbrs = import ./shell/abbrs.nix;
in
{
  programs.fish = {
    enable = true;

    inherit shellAbbrs;
    inherit shellAliases;

    # Flake inputs with the prefix `fish:` automatially end up here via overlay
    plugins = pkgs.lib.attrsets.mapAttrsToList
      (name: value: {
        inherit name;
        inherit (value) src;
      })
      pkgs.myFishPlugins;

    interactiveShellInit = ''
      set fish_greeting
      fish_vi_key_bindings

      set -gx GPG_TTY (tty)
      set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
    '';

    functions = {
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
