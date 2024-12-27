
# NGINX

## Get the Repo
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm search repo ingress-nginx --versions
```

## Get the Values
```bash
CHART_VERSION="4.4.0"
APP_VERSION="1.5.1"

mkdir ./platform/ingress/nginx/

helm template ingress-nginx ingress-nginx \
--repo https://kubernetes.github.io/ingress-nginx \
--version ${CHART_VERSION} \
--namespace ingress-nginx \
> ./platform/ingress/nginx/nginx-ingress.${APP_VERSION}.yaml
```

## Deploy NGINX

```bash
kubectl create namespace ingress-nginx
kubectl apply -f ./kubernetes/ingress/controller/nginx/manifests/nginx-ingress.${APP_VERSION}.yaml
```

## Verify Deployment

```bash
kubectl -n ingress-nginx port-forward svc/ingress-nginx-controller 443
```

Check https://localhost/ and note the "fake" SSL certificate used.