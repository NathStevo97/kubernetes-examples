

locals {
  cluster_type             = "gke-standard"
  default_workload_pool    = "${var.project_id}.svc.id.goog"
  secondary_pod_range_name = "gke-additional-pods-demo-pool"
}


resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = "kubeconfig-${var.env_name}"
}

data "google_client_config" "default" {}

data "google_compute_subnetwork" "subnetwork" {
  name       = "${var.subnetwork}-${var.env_name}"
  project    = var.project_id
  region     = var.region
  depends_on = [module.gcp-network]
}

module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/gke-standard-cluster"
  version = "~> 44.0"

  project_id = var.project_id
  name       = "${local.cluster_type}-cluster${var.cluster_name_suffix}"
  location   = var.region
  network    = "${var.network}-${var.env_name}"
  subnetwork = "${var.subnetwork}-${var.env_name}"

  # Needed for the Multi-Network for Pods configuration
  datapath_provider       = "ADVANCED_DATAPATH"
  enable_multi_networking = true

  ip_allocation_policy = {
    cluster_secondary_range_name  = var.ip_range_pods_name
    services_secondary_range_name = var.ip_range_services_name
  }

  private_cluster_config = {
    enable_private_endpoint = true
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
    master_global_access_config = {
      enabled = true
    }
  }

  deletion_protection      = false
  remove_default_node_pool = true
  initial_node_count       = 1

  workload_identity_config = {
    workload_pool = local.default_workload_pool
  }

  master_authorized_networks_config = {
    cidr_blocks = [{
      cidr_block   = data.google_compute_subnetwork.subnetwork.ip_cidr_range
      display_name = "VPC"
    }]
  }

  master_auth = {
    client_certificate_config = {
      issue_client_certificate = false
    }
  }

  addons_config = {
    dns_cache_config = {
      enabled = var.dns_cache
    }

    gce_persistent_disk_csi_driver_config = {
      enabled = var.gce_pd_csi_driver
    }
  }
  depends_on = [data.google_compute_subnetwork.subnetwork]
}
