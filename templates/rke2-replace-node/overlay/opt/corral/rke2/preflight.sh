#!/bin/bash
set -ex

apt-get update || true

apt install -y jq || true

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

mkdir ~/.kube

echo $CORRAL_kubeconfig | base64 -d > ~/.kube/config
chmod 400 ~/.kube/config


echo "corral_set kubernetes_version=$(kubectl get nodes -o custom-columns=:status.nodeInfo.kubeletVersion | tail -n 1)"