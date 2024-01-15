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
  kns = "kubens";
  ksec = "kubectl sec";
  ktp = "kubectl top pod --sort-by=cpu";
  kubeconfig = "kubectl config view --minify --flatten";
  kx = "kubectx";
  kxx = "kubectl xx";
  lt = "eza --tree";
  nv = "nvim";
  rgf = "rg --fixed-strings";
  rgi = "rg --ignore-case";
  star = "starship";
  tf = "terraform";
  tk = "task";
  wkgp = "watch kubectl get pods";
  wo = "type --all --short --path";
  xi = "xargs -I {}";
}
