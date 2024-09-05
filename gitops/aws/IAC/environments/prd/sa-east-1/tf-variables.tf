variable "name" {
  type        = string
  description = "Description name global solution"
}

variable "eks_version" {
  type = string
  description = "EKS Version"
}

variable "eks_cluster_endpoint_public_access" {
  type = bool
  description = "Mark to EKS public access"
}

variable "eks_cluster_endpoint_private_access" {
  type = bool
  description = "Mark to EKS private access"
}

variable "buckets" {
  type = list(object({
    bucket = string
  }))
  description = "Name of bucket"
}

variable "region" {
  type        = string
  description = "Name of region"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR VPC"
}

variable "vpc_azs" {
  type        = list(string)
  description = "List of Aviability Zone"
}

variable "vpc_private_subnets" {
  type        = list(string)
  description = "List of range of private subnets"
}

variable "vpc_public_subnets" {
  type        = list(string)
  description = "List of range of public subnets"
}

variable "vpc_enable_nat_gateway" {
  type        = bool
  default     = true
  description = "Enable Nat Gateway"
}

variable "vpc_enable_vpn_gateway" {
  type        = bool
  default     = true
  description = "Enable VPN Gateway"
}


variable "tags" {
  type        = map(any)
  description = "Tag of resources AWS"
}



variable "rds_instance_use_identifier_prefix" {
  type        = bool
  description = "Instance RDS Prefix Indetifier"
}

variable "rds_create_db_option_group" {
  type        = bool
  description = "Instance Option Group"
}

variable "rds_create_db_parameter_group" {
  type        = bool
  description = "Instance Parameter Group"
}

variable "rds_engine" {
  type        = string
  description = "Instance engine"
}

variable "rds_engine_version" {
  type        = string
  description = "Instance engine version"
  default = "15"
}

variable "rds_multi_az" {
  type = bool
  default = false
}

variable "rds_family" {
  type        = string
  description = "Instance familily"
  default = "postgres15"
}

variable "rds_major_engine_version" {
  type        = string
  description = "Instance engine version major"
  default = "14"
}

variable "rds_instance_class" {
  type        = string
  description = "Instance class instance"
  default = "db.t4g.medium"
}

variable "rds_allocated_storage" {
  type        = number
  description = "Instance allocated storage"
  default = 100
}

variable "rds_db_name" {
  type        = string
  description = "Instance name"
}

variable "rds_username" {
  type        = string
  description = "Instance username"
}

variable "rds_password" {
  type = string
  description = "Rds password"
}

variable "rds_port" {
  type        = number
  description = "Instance port"
  default = 5432
}

variable "rds_maintenance_window" {
  type        = string
  description = "Instance rds maintenance window"
}

variable "rds_backup_window" {
  type        = string
  description = "Instance rds backup window "
}

variable "rds_backup_retention_period" {
  type        = number
  description = "Instance rds backup window "
}
