output "eks_cluster_endpoint" {
  description = "Endpoint for EKS Control Plane"
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_certificate_authority" {
  #value = aws_eks_cluster.aws_eks.cluster_certificate_authority_data
  value     = module.eks.cluster_certificate_authority_data
  sensitive = true
}

output "region" {
  description = "AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.eks.cluster_name
}
