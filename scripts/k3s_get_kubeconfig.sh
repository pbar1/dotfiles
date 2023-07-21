#!/usr/bin/env bash

set -euo pipefail

ssh tec sudo k3s kubectl config view --flatten --minify | sed 's|127.0.0.1|192.168.0.5|g' > "$HOME/.kube/config"
