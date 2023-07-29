# WARNING: Abbreviations with single quotes will break zsh-abbr!
{
  "," = "nix-shell --packages";
  c = "clear";
  cb = "cargo build";
  cr = "cargo run";
  ct = "cargo test";
  dyf = "dyff between -b";
  e = "$EDITOR";
  fdh = "fd --no-hidden --no-ignore";
  g = "git";
  # gd = "git diff -- ':!*.lock'";
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
}
