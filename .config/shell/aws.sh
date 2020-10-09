#!/usr/bin/env bash

awsenv() {
  local aws_profile
  aws_profile=$(aws-vault list --profiles | fzf --height 40% --reverse)
  source <(aws-vault exec $aws_profile -- env | grep AWS | while read line; do echo "export $line"; done)
}
