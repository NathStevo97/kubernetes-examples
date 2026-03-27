variable "eks_version" {
  default     = "1.34"
  type        = string
  description = "Kubernetes version for EKS cluster deployment"
}

variable "region" {
  description = "AWS Region"
  default     = "eu-west-2"
  type        = string
}
