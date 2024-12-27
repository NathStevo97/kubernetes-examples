#!/bin/bash

function Docker {
  echo "Installing Docker"
  curl -sL get.docker.com | sh
  sudo usermod -aG docker "$USER"
}

function Kubectl {
  echo "Installing Kubectl"
  curl -sLO "https://storage.googleapis.com/kubernetes-release/release/$(curl -sL https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x ./kubectl
  sudo mv ./kubectl /usr/local/bin/kubectl
  echo 'source <(kubectl completion bash)' >>~/.bashrc
  echo 'alias k=kubectl' >>~/.bashrc
  echo 'complete -F __start_kubectl k' >>~/.bashrc
}

function K3D {
  echo "Installing K3D"
  curl -sL https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
}

function Helm {
  echo "Installing Helm"
  curl -sL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
}

function LinuxTools {
  echo "Installing basic GNU/Linux Tools"
  sudo -E sh -c DEBIAN_FRONTEND=noninteractive apt update -qq >/dev/null
  sudo -E sh -c DEBIAN_FRONTEND=noninteractive apt install -y -qq curl jq make unzip zip vim git >/dev/null
}

function Kind {
  # For AMD64 / x86_64
  [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.26.0/kind-linux-amd64
  chmod +x ./kind
  sudo mv ./kind /usr/local/bin/kind
}

function Required {
  LinuxTools
  Kubectl
  Helm
  K3D
  Kind
}

function Install {
  Required
  # Operators
}

Install