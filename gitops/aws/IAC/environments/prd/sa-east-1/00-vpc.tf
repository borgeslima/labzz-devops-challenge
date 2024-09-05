#####################################################################
# EKS Module Design By Gabriel Lima on Organization Quarks Labs <3
# Link: https://github.com/quarks-labs/aws-vpc-module
#####################################################################

module "vpc" {
  source                       = "git::git@github.com:quarks-labs/aws-vpc-module.git"
  name                         = local.name
  cidr                         = var.vpc_cidr
  azs                          = var.vpc_azs
  private_subnets              = var.vpc_private_subnets
  public_subnets               = var.vpc_public_subnets
  enable_nat_gateway           = true
  single_nat_gateway           = false
  one_nat_gateway_per_az       = true
  create_database_subnet_group = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }

  vpc_tags = merge(var.tags, {
    ref = "https://github.com/quarks-labs/aws-vpc-module"
  })
}
