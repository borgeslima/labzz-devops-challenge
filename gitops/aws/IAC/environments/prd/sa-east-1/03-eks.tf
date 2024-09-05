

#####################################################################
# EKS Module Design By Gabriel Lima on Organization Quarks Labs <3
# Link: https://github.com/quarks-labs/aws-eks-module
#####################################################################

 
module "eks" {
  source = "git::git@github.com:quarks-labs/aws-eks-module.git"

  cluster_name                    = local.name
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false
  cluster_version                 = "1.30"

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets
  enable_cluster_creator_admin_permissions = true

  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  create_kms_key = true

  eks_managed_node_groups = {
    node_group_t3a_large = {
      name           = "node-pool-t3a-group"
      min_size       = 1
      max_size       = 2
      platform       = "bottlerocket"
      instance_types = ["t3a.large"]
      desired_size   = 2
      capacity_type  = "ON_DEMAND"
    }
  }

  node_security_group_tags = merge({
    "kubernetes.io/cluster/${local.name}" = null
  })

  tags = merge(var.tags, {
    ref = "https://github.com/quarks-labs/aws-vpc-module"
  })
}
