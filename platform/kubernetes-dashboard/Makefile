setup:
	helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
	helm upgrade --install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard --create-namespace --namespace kubernetes-dashboard

port-foward:
	kubectl port-forward -n kubernetes-dashboard service/kubernetes-dashboard 8080:443

generate-token:
	kubectl -n kubernetes-dashboard create token SERVICE_ACCOUNT