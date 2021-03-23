# usage: hvault [predicate] [target?]
# examples:
# - hvault 'policy list'                      <-- needs quoting since predicte is multi-word
# - hvault read auth/maddog/certs/vault-test  <-- target is optional, here is is used
hvault() {
  predicate="${1}"
  subject="${2}"
  vault_token="$(kubectl get secret vault-init --namespace=hawking-vault --output=go-template --template='{{.data.root_token | base64decode}}')"
  active_pod="$(kubectl get pod --namespace=hawking-vault --selector='vault-active=true' --output=name | sed 's|pod/||g')"
  kubectl exec "${active_pod}" --namespace=hawking-vault --container=vault -- sh -c "
    VAULT_TOKEN=${vault_token} vault ${predicate} \
      -tls-server-name=hawking-vault.hawking-vault.einstein.dev1-uswest2.aws.sfdc.is \
      -ca-cert=/etc/pki_service/ca/cacerts.pem \
      -client-cert=/etc/identity/client/certificates/client.pem \
      -client-key=/etc/identity/client/keys/client-key.pem \
      ${subject}
  "
}

# usage: hvaultfwd
# forwards the Vault endpoint to http://localhost:9200, complete with mTLS wrapping
hvaultfwd() {
  local cert_path="${HOME}/.tmp/hawking-vault"

  if ! openssl x509 -checkend 86400 -noout -in ~/.tmp/hawking-vault/client.pem; then
    local active_pod=vault-0
    #local active_pod="$(kubectl get pod --namespace=hawking-vault --selector='vault-active=true' --output=name | sed 's|pod/||g')"
    mkdir -p "${cert_path}"
    kubectl cp "hawking-vault/${active_pod}:/etc/pki_service/ca/cacerts.pem" "${cert_path}/ca.pem"
    kubectl cp "hawking-vault/${active_pod}:/etc/identity/client/certificates/client.pem" "${cert_path}/client.pem"
    kubectl cp "hawking-vault/${active_pod}:/etc/identity/client/keys/client-key.pem" "${cert_path}/client-key.pem"
  fi

  kubectl port-forward pod/vault-0 8200 --namespace=hawking-vault &
  local kubectl_pid=$!
  socat \
    TCP-LISTEN:9200,fork,reuseaddr \
    OPENSSL-CONNECT:127.0.0.1:8200,cafile="${cert_path}/ca.pem",certificate="${cert_path}/client.pem",key="${cert_path}/client-key.pem",commonname=vault.hawking-vault.einstein.dev1-uswest2.aws.sfdc.is \
    &
  local socat_pid=$!

  cleanup() {
    kill ${kubectl_pid}
    kill ${socat_pid}
  }

  trap cleanup INT
  wait ${kubectl_pid} ${socat_pid}
  trap - INT
}

# Usage: pcsk 'export AWS_ACCESS_KEY_ID=... AWS_SECRET_ACCESS_KEY=... AWS_SESSION_TOKEN=...' [profile]
# Transforms the export command copied from PCSK and writes it to the AWS shared credentials file.
# Writes to the default profile unless another profile name is specified.
pcsk() {
  local export_cmd="${1}"
  local profile="${2:-"default"}"
  echo "${export_cmd}" \
  | tr ' ' '\n' \
  | sed "s|export|[${profile}]|" \
  | sed 's|AWS_ACCESS_KEY_ID|aws_access_key_id|' \
  | sed 's|AWS_SECRET_ACCESS_KEY|aws_secret_access_key|' \
  | sed 's|AWS_SESSION_TOKEN|aws_session_token|' \
  > "${AWS_SHARED_CREDENTIALS_FILE:-"${HOME}/.aws/credentials"}"
}
