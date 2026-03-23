# Kube-Prometheus Stack

## Setup

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm search repo prometheus-community/kube-prometheus-stack --versions
```

- Make the namespace: `kubectl create ns monitoring`

- Install: `helm install -n monitoring [RELEASE_NAME] prometheus-community/kube-prometheus-stack`
- Release Name can be anything e.g. `monitoring`

## Get the Values

```bash
CHART_VERSION="82.0.0"
APP_VERSION="0.89.0"

mkdir ./kubernetes/monitoring/prometheus-grafana/manifests

helm template kube-prometheus-stack kube-prometheus-stack \
--repo https://prometheus-community.github.io/helm-charts \
--version "82.0.0" \
--namespace monitoring \
> ./platform/monitoring/kube-prometheus-stack-0.89.0.yaml
