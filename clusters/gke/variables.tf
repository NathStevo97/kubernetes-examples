variable "project_id" {
  description = "The project ID to host the cluster in"
}
variable "cluster_name" {
  description = "The name for the GKE cluster"
  default     = "learnk8s-cluster"
}

variable "cluster_name_suffix" {
  description = "A suffix to append to the default cluster name"
  default     = "demo"
}

variable "env_name" {
  description = "The environment for the GKE cluster"
  default     = "prod"
}
variable "region" {
  description = "The region to host the cluster in"
  default     = "europe-west1"
}
variable "network" {
  description = "The VPC network created to host the cluster in"
  default     = "gke-network"
}
variable "subnetwork" {
  description = "The subnetwork created to host the cluster in"
  default     = "gke-subnet"
}

variable "ip_range_pods" {
  description = "The secondary ip range to use for pods"
}

variable "ip_range_pods_name" {
  description = "The secondary ip range to use for pods"
  default     = "ip-range-pods"
}

variable "ip_range_services" {
  description = "The secondary ip range to use for services"
}

variable "service_account" {
  description = "Service account to associate to the nodes in the cluster"
}

variable "ip_range_services_name" {
  description = "The secondary ip range to use for services"
  default     = "ip-range-services"
}


variable "dns_cache" {
  description = "Boolean to enable / disable NodeLocal DNSCache "
  default     = false
}

variable "gce_pd_csi_driver" {
  type        = bool
  description = "(Beta) Whether this cluster should enable the Google Compute Engine Persistent Disk Container Storage Interface (CSI) Driver."
  default     = false
}
