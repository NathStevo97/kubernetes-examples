resource "google_service_account" "gke_service_account" {
  project      = var.project_id
  account_id   = var.service_account_id
  display_name = "GKE Terraform Service Account"
}
