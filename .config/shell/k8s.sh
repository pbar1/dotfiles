#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Dependencies: kubectl, kubectx, kubens, fzf, tr, base64, curl, jq, rg, velero, aws, paste, grep
#------------------------------------------------------------------------------

export KUBE_HOME="${HOME}/.kube"

# programs in short form
alias k='kubectl'
alias kx='kubectx'
alias kns='kubens'
alias krew='kubectl krew'

# mnemonics for kubectl get
alias kapi='kubectl api-resources'
alias kga='kubectl get all'
alias kge='kubectl get events --watch'
alias kgn='kubectl get node --label-columns=beta.kubernetes.io/instance-type,failure-domain.beta.kubernetes.io/zone'
alias kgns='kubectl get namespace --show-labels'
alias kgp='kubectl get pod'
alias kgd='kubectl get deployment'
alias kgrs='kubectl get replicaset'
alias kgds='kubectl get daemonset'
alias kgss='kubectl get statefulset'
alias kgj='kubectl get job'
alias kgg='kubectl get pod,replicaset,deployment,statefulset,daemonset,job,cronjob'
alias kgv='kubectl get persistentvolumes,persistentvolumeclaims,volumeattachments,storageclass'
alias kgi='kubectl get ingress,service,endpoints,certificates,certificaterequests,certificatesigningrequests,challenges,orders'
alias kgr='kubectl get role,rolebinding,serviceaccount'
alias kgx='kubectl config get-contexts'

# mnemonics for kubectl describe
alias kdp='kubectl describe pod'
alias kdn='kubectl describe node'

# mnemonics for velero create
alias vcb='velero create backup'
alias vcr='velero create restore'

# prints current context kubeconfig to stdout
alias kubeconfig='kubectl config view --minify --flatten'

# launches and attaches to a busybox shell in the current namespace
alias kbusy='kubectl run --rm --stdin --tty --restart=Never --image=busybox busybox'

# kgp() {
#   local tmpfile
#   tmpfile="$(mktemp)"
#   cat <<'EOF' > "${tmpfile}"
# NAME           QOS-CLASS        POD-IP        HOST-IP
# .metadata.name .status.qosClass .status.podIP .status.hostIP
# EOF
#   kubectl get pod --output="custom-columns-file=${tmpfile}" "${@}"
#   rm "${tmpfile}"
# }

# open kubeconfig directory in a finder window
kopen() { open "${KUBE_HOME}"; }

# gets container and init container image names for pods
kimg() {
  kubectl get pod "${@}" \
    --output=jsonpath="{range .items[*]}{range ['spec.containers', 'spec.initContainers'][*]}{.image}{'\n'}{end}{end}" \
  | sort --unique
}

# gets resource labels
# usage: klabel [resource_type]
klabel() {
  kubectl get "${@}" \
    --output=go-template \
    --template='{{range .items}}{{println .metadata.name}}{{range $k, $v := .metadata.labels}}  {{$k}}: {{$v}}{{println}}{{end}}{{println}}{{end}}'
}

# gets resource annotations
# usage: kanno [resource_type]
kanno() {
  kubectl get "${@}" \
    --output=go-template \
    --template='{{range .items}}{{println .metadata.name}}{{range $k, $v := .metadata.annotations}}  {{$k}}: {{$v}}{{println}}{{end}}{{println}}{{end}}'
}

#------------------------------------------------------------------------------
# Utility functions (meant for internal use in this script)
#------------------------------------------------------------------------------

# usage: _randhash
_randhash() {
  LC_ALL=C tr -dc 'a-z0-9' < /dev/urandom | fold -w 5 | head -n 1
}

# usage: _kfilter_resource_type
_kfilter_resource_type() {
  kubectl api-resources --output=name | cut -d. -f1 | sort -u | fzf --exact --preview 'kubectl explain {} && kubectl get {}'
}

# usage: _kfilter_resource_name [resource_type]
_kfilter_resource_name() {
  resource_type="${1}"
  kubectl get "${resource_type}" --output=go-template --template='{{range .items}}{{.metadata.name}}{{printf "\n"}}{{end}}' \
  | fzf --exact --preview "kubectl describe ${resource_type} {}"
}

# usage: _kfilter_container_name [pod_name]
_kfilter_container_name() {
  pod_name="${1}"
  kubectl get pod "${pod_name}" --output=go-template --template='{{range .spec.containers}}{{.name}}{{printf "\n"}}{{end}}' | fzf
}

# usage: _kfilter_container_shells [pod_name] [container_name]
_kfilter_container_shells() {
  pod_name="${1}"
  container_name="${2}"
  kubectl exec "${pod_name}" --container="${container_name}" -- cat /etc/shells | fzf
}

#------------------------------------------------------------------------------
# Kubernetes convenience functions
#------------------------------------------------------------------------------

# usage: kush [image]
# launches and attaches to a new container from image in the current namespace
kush() {
  image_name="${1}"
  pod_base_name="$(basename "${image_name}" | cut -d: -f1)"
  pod_name="kush-${pod_base_name}-$(_randhash)"
  shell=$(kubectl run "${pod_name}-temp" --image="${image_name}" --rm --restart=Never --stdin --tty --command -- cat /etc/shells | tr -d '\r' | fzf)
  kubectl run "${pod_name}" --image="${image_name}" --rm --restart=Never --stdin --tty --command -- "${shell}"
}

# usage: kxx
# list/select pod, then containers in that pod, then shells in that container, then attach to the selected shell in that container
kxx() {
  pod_name=$(_kfilter_resource_name pod)
  container_name="$(_kfilter_container_name "${pod_name}")"
  shell="$(_kfilter_container_shells "${pod_name}" "${container_name}")"
  kubectl exec "${pod_name}" --container="${container_name}" --stdin --tty -- "${shell}"
}

# usage: kd
# list/select api resource types, then objects of that type in current namespace, then kubectl describe the selected object
kd() {
  resource_type="$(_kfilter_resource_type)"
  resource_name="$(_kfilter_resource_name "${resource_type}")"
  kubectl describe "${resource_type}" "${resource_name}"
}

# usage: kyam
# list/select api resource types, then objects of that type in current namespace, then print raw yaml of the selected object to stdout
kyam() {
  resource_type="$(_kfilter_resource_type)"
  resource_name="$(_kfilter_resource_name "${resource_type}")"
  kubectl get "${resource_type}" "${resource_name}" --output=yaml
}

# usage: ksec
# list/select secrets in the current namespace, then fields within that secret, then print the decoded field to stdout
ksec() {
  secret_name="$(kubectl get secret --output=go-template --template='{{range .items}}{{println .metadata.name}}{{end}}' | fzf --exact --preview "kubectl describe ${resource_type} {}")"
  secret_field="$(kubectl get secret "${secret_name}" --output=go-template --template='{{range $k, $v := .data}}{{println $k}}{{end}}' | fzf)"
  kubectl get secret "${secret_name}" --output=go-template --template="{{index .data \"${secret_field}\" | base64decode}}"
}

# usage: sc
# list/select containers in the current namespace, then containers in that pod, then stern the logs for that container
sc() {
  pod_name="$(_kfilter_resource_name pod)"
  container_name="$(_kfilter_container_name "${pod_name}")"
  stern "${pod_name}" --container="${container_name}"
}

# usage: kkillns [NAMESPACE]
# force kill the specified namespace, only use as a last resort
# TODO: close the backgrounded kubectl proxy
kkillns() {
  namespace="${1}"
  tempfile="/tmp/kkillns-${namespace}.json"
  kubectl proxy &
  kubectl get namespace "${namespace}" -o json | jq '.spec = {"finalizers":[]}' > "${tempfile}"
  curl \
    --insecure \
    --request PUT \
    --header "Content-Type: application/json" \
    --data-binary @"temp-kkillns-${namespace}.json" \
    "127.0.0.1:8001/api/v1/namespaces/${namespace}/finalize"
  rm "${tempfile}"
}

# show kubernetes audit logs in an fzf preview pane
kaudit() {
  kubectl logs --namespace=kube-system --selector=k8s-app=kube-apiserver --container=kube-apiserver --tail=-1 --since=1h \
  | grep --fixed-strings 'apiVersion":"audit.k8s.io' \
  | fzf --exact --multi --preview 'yq read --prettyPrint --colors - '"$@"' <<< {}'
}

# list/select api resource types, then objects of that type, then describe the selected object
vd() {
  velero_resources=(
    "backups"
    "restores"
  )
  resource_type=$(printf '%s\n' "${velero_resources[@]}" | fzf)
  resource_name=$(velero get "${resource_type}" --output=json | jq -r '.items[].metadata.name' | fzf)
  velero describe "${resource_type}" "${resource_name}" --details
}

# list/select api resource types, then list objects of that type
vg() {
  velero_resources=(
    "backup-locations"
    "backups"
    "plugins"
    "restores"
    "schedule"
    "snapshot-locations"
  )
  resource_type=$(printf '%s\n' "${velero_resources[@]}" | fzf)
  velero get "${resource_type}"
}

# backup current namespace using velero and migrate it to another cluster (select multiple namespaces with TAB)
kmigrate() {
  kubectx
  namespaces=$(kubectl get namespace --output='jsonpath={.items[*].metadata.name}' | tr -s '[[:space:]]' '\n' | fzf --multi | paste -sd ',' -)
  from_cluster=$(kubectl config view --flatten --minify --output='jsonpath={.clusters[0].name}')
  backup_name="${from_cluster}_$(echo "${namespaces}" | tr ',' '_')_$(date +%s)"
  bucket=$(backup-location get default --output=json | jq -r '.spec.objectStorage.bucket')
  velero create backup "${backup_name}" --include-namespaces="${namespaces}" --wait

  kubectx
  if ! velero backup-location get | grep --quiet "${from_cluster}" > /dev/null 2>&1; then
    velero create backup-location "${from_cluster}" --provider=aws --access-mode=ReadOnly --bucket="${bucket}" --prefix="${from_cluster}"
  fi
  echo "Sleeping for 10 seconds to allow the backup to register in target cluster. If not ready, check for pending EBS snapshots"
  sleep 10
  velero create restore "${backup_name}" --from-backup="${backup_name}" --wait

  echo "Restore created in target cluster"
}

# list/select kops clusters, then copy the selected cluster's root CA keypair from kops state bucket to current directory
# note: must have KOPS_STATE_STORE environment variable set
kops-ca-backup() {
  mkdir -p kops-ca-backup
  cluster_name=$(kops get clusters --output=json | jq -r '.[].metadata.name' | fzf)
  crt_remote_filename="$(aws s3 ls "${KOPS_STATE_STORE}/${cluster_name}/pki/issued/ca/"  | rg --fixed-strings '.crt' | cut -d' ' -f10)"
  aws s3 cp "${KOPS_STATE_STORE}/${cluster_name}/pki/issued/ca/${crt_remote_filename}" "kops-ca-backup/${cluster_name}/ca.crt"
  key_remote_filename="$(aws s3 ls "${KOPS_STATE_STORE}/${cluster_name}/pki/private/ca/" | rg --fixed-strings '.key' | cut -d' ' -f10)"
  aws s3 cp "${KOPS_STATE_STORE}/${cluster_name}/pki/private/ca/${key_remote_filename}" "kops-ca-backup/${cluster_name}/ca.key"
}

# divide the main kubeconfig at ~/.kube/config into self-contained kubeconfigs for each context
kubeconfig-unmerge() {
  unset KUBECONFIG
  for context in $(kubectl config get-contexts --kubeconfig="${KUBE_HOME}/config" --output=name); do
    kubectl config view \
      --kubeconfig="${KUBE_HOME}/config" \
      --context="${context}" \
      --flatten \
      --minify \
    > "${KUBE_HOME}/config-${context}"
  done
}

# used in conjunction with self-contained kubeconfigs generated by kubeconfig-unmerge
ksel() {
  kubeconfig=$(ls "${KUBE_HOME}" | grep --fixed-strings 'config-' | fzf)
  export KUBECONFIG="${KUBE_HOME}/${kubeconfig}"
}

krerun() {
  resource_name="$(_kfilter_resource_name job)"
  kubectl get job ${resource_name} -o json | jq 'del(.spec.selector)' | jq 'del(.spec.template.metadata.labels)' | kubectl replace --force -f -
}

# Gets all Pods in the current cluster that are not selected by a PodDisruptionBudget
# Usage: k.pods_no_pdb
k.pods_no_pdb() {
  local getpodtpl getpodcmd
  getpodtpl="$(mktemp)"
  getpodcmd="$(mktemp)"

  # Go template for kubectl command to find all pods NOT selected by a PodDisruptionBudget.
  # With kubectl label selectors, the LAST -l/--selector wins, so only one may be passed.
  # Commas act as a logical AND operator.
  cat <<'EOF' > "${getpodtpl}"
kubectl get pod \
  --all-namespaces \
  --output='jsonpath={range .items[*]}{.metadata.namespace}/{.metadata.name}{"\n"}{end}' \
  --selector='{{ range .items }}{{ range $k, $v := .spec.selector.matchLabels }}{{ $k }}!={{ $v }},{{ end }}{{ end }}'
EOF

  # Get all PodDisruptionBudgets, feed output into the kubectl command template, and remove trailing comma from command.
  kubectl get poddisruptionbudget --all-namespaces --output="go-template-file=${getpodtpl}" \
  | sed "s|,'|'|1" \
  > "${getpodcmd}"

  # Evaluate the kubectl command, which prints all PBD-less pods in namespace/pod form.
  eval "$(cat "${getpodcmd}")"

  rm "${getpodtpl}" "${getpodcmd}"
}
