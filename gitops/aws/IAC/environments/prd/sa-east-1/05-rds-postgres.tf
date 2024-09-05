#####################################################################
# EKS Module Design By Gabriel Lima on Organization Quarks Labs <3
# Link: https://github.com/quarks-labs/aws-security-group-module
#####################################################################

module "security_group" {
  source      = "git::git@github.com:quarks-labs/aws-security-group-module.git"
  name        = local.name
  description = local.name
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "PostgreSQL access from within VPC"
      cidr_blocks = module.vpc.vpc_cidr_block
    },
  ]

  tags = merge(var.tags, {

  })

  depends_on = [module.vpc]
}

module "rds-postgres" {
  source = "git::git@github.com:quarks-labs/aws-rds-module.git"

  identifier                     = local.name
  instance_use_identifier_prefix = var.rds_instance_use_identifier_prefix
  create_db_option_group         = var.rds_create_db_option_group
  create_db_parameter_group      = var.rds_create_db_parameter_group
  engine                         = var.rds_engine
  engine_version                 = var.rds_engine_version
  family                         = var.rds_family
  major_engine_version           = var.rds_major_engine_version
  instance_class                 = var.rds_instance_class
  allocated_storage              = var.rds_allocated_storage
  db_name                        = var.rds_db_name
  username                       = var.rds_username
  create_db_subnet_group         = true
  multi_az                       = var.rds_multi_az
  subnet_ids                     = concat(module.vpc.public_subnets, module.vpc.private_subnets)
  password                       = var.rds_password
  port                           = var.rds_port
  maintenance_window             = var.rds_maintenance_window
  backup_window                  = var.rds_backup_window
  backup_retention_period        = var.rds_backup_retention_period
  vpc_security_group_ids         = [module.security_group.security_group_id]

  tags = merge(var.tags, {
    ref = "https://github.com/quarks-labs/aws-vpc-module"
  })

  depends_on = [module.vpc, module.security_group]
}


