install:
	helm repo add jetstack https://charts.jetstack.io
	helm repo update
	helm upgrade --install cert-manager jetstack/cert-manager --create-namespace --namespace cert-manager --version v1.12.0 --set installCRDs=true

uninstall:
	helm uninstall cert-manager --namespace cert-manager
	kubectl delete namespace cert-manager
	helm repo remove jetstack
	helm repo update