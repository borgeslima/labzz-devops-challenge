
#####################################################################
# Global Configurations
#####################################################################

name = "labzz-flowise"
tags = {
  environment = "dev"
  resource    = "flowise"
  design_by   = "http://github.com/borgeslima"
}

#####################################################################
# AWS Global Configurations
#####################################################################
region = "sa-east-1"

#####################################################################
# S3 Configurations
#####################################################################

buckets = [
  /*{
  bucket = "bucket-example"
}*/
]

#####################################################################
# EKS Configurations
#####################################################################

eks_version                         = "1.30"
eks_cluster_endpoint_public_access  = true
eks_cluster_endpoint_private_access = false

#####################################################################
# EKS Configurations
#####################################################################

vpc_cidr               = "10.3.0.0/16"
vpc_azs                = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
vpc_private_subnets    = ["10.3.32.0/19", "10.3.96.0/19", "10.3.160.0/19"]
vpc_public_subnets     = ["10.3.64.0/19", "10.3.128.0/19", "10.3.192.0/19"]
vpc_enable_nat_gateway = true
vpc_enable_vpn_gateway = true

#####################################################################
# RDS Configurations
#####################################################################

rds_instance_use_identifier_prefix = false
rds_create_db_option_group         = false
rds_create_db_parameter_group      = false
rds_engine                         = "postgres"
rds_engine_version                 = "15"
rds_family                         = "postgres15"
rds_major_engine_version           = "14"
rds_instance_class                 = "db.t4g.medium"
rds_allocated_storage              = 50
rds_db_name                        = "labbz"
rds_username                       = "labbz"
rds_port                           = 5432
rds_maintenance_window             = "Mon:00:00-Mon:03:00"
rds_backup_window                  = "03:00-06:00"
rds_backup_retention_period        = 0
