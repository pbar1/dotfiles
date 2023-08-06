#!/usr/bin/env bash

#------------------------------------------------------------------------------
# Generates SSH certificate authorities (CA) for user and host scopes and saves
# them in 1Password.
#
# https://en.wikibooks.org/wiki/OpenSSH/Cookbook/Certificate-based_Authentication
#------------------------------------------------------------------------------

set -x

function main() {
  # Ensure we're authenticated with 1Password to save the secrets later
  # eval $(op signin)

  local tmp="$(mktemp -d)"

  local user_ca_rsa="pbcloud_user_ca_rsa"
  yes "y" |
    ssh-keygen -t rsa -b 4096 -f "$tmp/$user_ca_rsa" -C "$user_ca_rsa" -N ""

  local host_ca_rsa="pbcloud_host_ca_rsa"
  yes "y" |
    ssh-keygen -t rsa -b 4096 -f "$tmp/$host_ca_rsa" -C "$host_ca_rsa" -N ""

  local user_ca_ed25519="pbcloud_user_ca_ed25519"
  yes "y" |
    ssh-keygen -t ed25519 -f "$tmp/$user_ca_ed25519" -C "$user_ca_ed25519" -N ""

  local host_ca_ed25519="pbcloud_host_ca_ed25519"
  yes "y" |
    ssh-keygen -t ed25519 -f "$tmp/$host_ca_ed25519" -C "$host_ca_ed25519" -N ""

  op item create --category=password --title="$user_ca_rsa" \
    "ssh.private_key[password]=$(cat "$tmp/$user_ca_rsa")" \
    "ssh.public_key[text]=$(cat "$tmp/$user_ca_rsa.pub")"

  op item create --category=password --title="$host_ca_rsa" \
    "ssh.private_key[password]=$(cat "$tmp/$host_ca_rsa")" \
    "ssh.public_key[text]=$(cat "$tmp/$host_ca_rsa.pub")"

  op item create --category=password --title="$user_ca_ed25519" \
    "ssh.private_key[password]=$(cat "$tmp/$user_ca_ed25519")" \
    "ssh.public_key[text]=$(cat "$tmp/$user_ca_ed25519.pub")"

  op item create --category=password --title="$host_ca_ed25519" \
    "ssh.private_key[password]=$(cat "$tmp/$host_ca_ed25519")" \
    "ssh.public_key[text]=$(cat "$tmp/$host_ca_ed25519.pub")"

  rm -rf "${tmp}"
}

main
