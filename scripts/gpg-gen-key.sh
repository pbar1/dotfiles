#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Generates a GPG keypair and saves it in 1Password.
#
# https://www.gnupg.org/documentation/manuals/gnupg/OpenPGP-Key-Management.html
#------------------------------------------------------------------------------

set -o nounset -o errexit -o pipefail -x

function main() {
  # Ensure we're authenticated with 1Password to save the secrets later
  eval $(op signin)

  # Use an ephemeral GPG directory to avoid adding keys to our default keyring
  local tmp="$(mktemp -d)"
  export GNUPGHOME="${tmp}"

  # Key metadata
  local name="John Doe"
  local email="jd@example.com"
  local user_id="${name} <${email}>"
  local secret="GPG: ${email}"

  # Key parameters
  local expire="never"
  local algo_cert="ed25519"
  local algo_sign="${algo_cert}"
  local algo_encr="cv25519"
  local algo_auth="${algo_cert}"

  # Create an entry in 1Password for the key and generate a passphrase
  op item create --title="${secret}" --category=password --generate-password
  local pass="$(op item get "${secret}" --fields=label=password)"
  local pass_flags="--batch --pinentry-mode=loopback --passphrase=${pass}"

  # Generate the root key
  gpg ${pass_flags} --quick-generate-key "${user_id}" "${algo_cert}" cert "${expire}"

  # Find fingerprint of the root key
  local fpr
  fpr="$(gpg --list-keys --with-colons | awk -F: '/fpr/ { print $10 }')"

  # Add subkeys for signing, encryption, and authentication to our new key
  gpg ${pass_flags} --quick-add-key "${fpr}" "${algo_sign}" sign "${expire}"
  gpg ${pass_flags} --quick-add-key "${fpr}" "${algo_encr}" encr "${expire}"
  gpg ${pass_flags} --quick-add-key "${fpr}" "${algo_auth}" auth "${expire}"

  # Exported key filenames
  local public_file="${tmp}/${fpr}_public.asc"
  local secret_file="${tmp}/${fpr}_secret.asc"
  local subkeys_file="${tmp}/${fpr}_secret_subkeys.asc"
  local revoke_file="${tmp}/openpgp-revocs.d/${fpr}.rev"
  local ssh_file="${tmp}/${fpr}_ssh.pub"

  # Export the keys into ASCII armor (aka PEM) format
  gpg --export --armor --output="${public_file}" "${fpr}"
  gpg ${pass_flags} --export-secret-keys --armor --output="${secret_file}" "${fpr}"
  gpg ${pass_flags} --export-secret-subkeys --armor --output="${subkeys_file}" "${fpr}"
  gpg --output="${ssh_file}" --export-ssh-key "${fpr}"

  local notes="To pull the public key:
\`\`\`
op item get '${secret}' --format=json --fields=gpg.public_key | jq -r .value
\`\`\`

To pull the secret key:
\`\`\`
op item get '${secret}' --format=json --fields=gpg.secret_key | jq -r .value
\`\`\`

To pull the secret subkeys:
\`\`\`
op item get '${secret}' --format=json --fields=gpg.secret_subkeys | jq -r .value
\`\`\`

To pull the revocation cert:
\`\`\`
op item get '${secret}' --format=json --fields=gpg.revocation_cert | jq -r .value
\`\`\`

To pull the SSH public key:
\`\`\`
op item get '${secret}' --format=json --fields=gpg.ssh_pubkey | jq -r .value
\`\`\`
"

  # Save the keys to 1Password
  op item edit "${secret}" \
    "name[text]=${name}" \
    "email[email]=${email}" \
    "fingerprint[text]=${fpr}" \
    "gpg.public_key[text]=$(cat "${public_file}")" \
    "gpg.secret_key[text]=$(cat "${secret_file}")" \
    "gpg.secret_subkeys[text]=$(cat "${subkeys_file}")" \
    "gpg.revocation_cert[text]=$(cat "${revoke_file}")" \
    "gpg.ssh_pubkey[text]=$(cat "${ssh_file}")" \
    "notesPlain[text]=${notes}"

  # Delete the ephemeral GPG directory
  rm -rf "${tmp}"
}

main
