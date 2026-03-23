variable "appId" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}

variable "location" {
  default     = "uksouth"
  description = "Location for resources to be deployed to"
}

variable "agent_count" {
  default = 3
}

variable "ssh_public_key" {
  description = "Public SSH Key For AKS Access"
}

variable "dns_prefix" {
  default = "k8stest"
}

variable "cluster_name" {
  default = "k8stest"
}
