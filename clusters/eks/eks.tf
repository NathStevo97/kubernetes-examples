module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.15.1"

  name               = local.cluster_name
  kubernetes_version = "1.33"

  vpc_id                 = module.vpc.vpc_id
  subnet_ids             = module.vpc.private_subnets
  endpoint_public_access = true

  # https://docs.aws.amazon.com/eks/latest/APIReference/API_Nodegroup.html#AmazonEKS-Type-Nodegroup-amiType

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }

    two = {
      name = "node-group-2"

      instance_types = ["t3.small"]

      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
}
