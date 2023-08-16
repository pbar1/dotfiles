#!/usr/bin/env bash

set -euo pipefail

rm -rf /etc/rancher/k3s
rm -rf /run/k3s
rm -rf /run/flannel
rm -rf /var/lib/rancher/k3s
rm -rf /var/lib/kubelet
rm -f /usr/local/bin/k3s
rm -f /usr/local/bin/k3s-killall.sh
rm -rf /var/lib/containers
rm -rf /var/lib/docker
rm -rf /var/lib/rancher
rm -rf /var/lib/cni

# fd 'rancher|cni|container|crio|docker|netns|k3s|cilium|flannel|pod|calico' /etc /var /run /usr -t d | sort -u
rm -rf /etc/cni/
rm -rf /etc/containers/
rm -rf /etc/crio/
rm -rf /etc/crio/crio.conf.d/
rm -rf /etc/rancher/
rm -rf /var/cache/containers/
rm -rf /var/lib/cni/
rm -rf /var/lib/cni/networks/crio/
rm -rf /var/log/containers/
rm -rf /var/log/crio/
rm -rf /opt/cni/
rm -rf /opt/containerd/
rm -rf /var/log/pods
