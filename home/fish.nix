{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "fzf-fish";
        src = pkgs.fetchFromGitHub {
          owner = "PatrickF1";
          repo = "fzf.fish";
          rev = "6b592e4140168820f5df9dd28b0a93e409e0d0c3";
          sha256 = "sha256-dngAKzyD+lmqmxsCSOMViyCgA/+Ve35gLtPS+Lgs8Pc=";
        };
      }
      {
        name = "bang-bang";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-bang-bang";
          rev = "f969c618301163273d0a03d002614d9a81952c1e";
          sha256 = "sha256-A8ydBX4LORk+nutjHurqNNWFmW6LIiBPQcxS3x4nbeQ=";
        };
      }
      {
        name = "fish-kubectl-completions";
        src = pkgs.fetchFromGitHub {
          owner = "evanlucas";
          repo = "fish-kubectl-completions";
          rev = "ced676392575d618d8b80b3895cdc3159be3f628";
          sha256 = "sha256-OYiYTW+g71vD9NWOcX1i2/TaQfAg+c2dJZ5ohwWSDCc=";
        };
      }
      {
        name = "fish-async-prompt";
        src = pkgs.fetchFromGitHub {
          owner = "acomagu";
          repo = "fish-async-prompt";
          rev = "40f30a4048b81f03fa871942dcb1671ea0fe7a53";
          sha256 = "sha256-sSM8jB81TO+n0JVl8ekfVbw99K5NzEdxi1VqWkhIJaY=";
        };
      }
      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "2fd3d2157d5271ca3575b13daec975ca4c10577a";
          sha256 = "sha256-fl4/Pgtkojk5AE52wpGDnuLajQxHoVqyphE90IIPYFU=";
        };
      }
      {
        name = "base16-fish-shell";
        src = pkgs.fetchFromGitHub {
          owner = "FabioAntunes";
          repo = "base16-fish-shell";
          rev = "d358af9a724715efd0d31b417ba56e622a239612";
          sha256 = "sha256-Bf6V/sF0NqUC2iCNXMZWM3ijpicnJhMpoKZSwOuiS3s=";
        };
      }
    ];
    shellAbbrs = {
      c = "clear";
      g = "git";
      gs = "git status --short";
      ij = "idea";
      k = "kubectl";
      kapi = "kubectl api-resources";
      kge = "kubectl get events --watch";
      kgg = "kubectl get pods,replicasets,deployments,statefulsets,daemonsets,jobs,cronjobs";
      kgi = "kubectl get ingresses,services,endpoints,certificates,certificaterequests,certificatesigningrequests,challenges,orders";
      kgn = "kubectl get namespaces --show-labels";
      kgno = "kubectl get nodes --label-columns = beta.kubernetes.io/instance-type,failure-domain.beta.kubernetes.io/zone";
      kgp = "kubectl get pods -o wide";
      wkgp = "watch kubectl get pods -o wide";
      kn = "kubens";
      kubeconfig = "kubectl config view --minify --flatten";
      kx = "kubectx";
      lt = "exa --tree";
      rgf = "rg --fixed-strings";
      rgi = "rg --ignore-case";
      star = "starship";
      tf = "terraform";
      tfa = "terraform apply";
      tfp = "terraform plan";
      wo = "command --all";
      xi = "xargs -I {}";
    };
    shellAliases = {
      cat = "bat";
      l = "exa --header --all --long --git";
      vi = "nvim";
    };
  };
}
