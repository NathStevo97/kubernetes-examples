data "aws_availability_zones" "available" {}

locals {
  eks_cluster_name = "${local.resource_prefix}-cluster-${local.resource_suffix}"
  resource_prefix  = "eks-demo"
  resource_suffix  = random_string.suffix.result
  vpc_name         = "${local.resource_prefix}-cluster-${local.resource_suffix}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}
