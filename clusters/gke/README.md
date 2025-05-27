Ensure Kubernetes API is enabled: https://console.developers.google.com/apis/api/container.googleapis.com/

`terraform apply --var-file=terraform.tfvars`

`gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)`