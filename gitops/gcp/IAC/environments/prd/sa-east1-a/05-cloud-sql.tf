
#####################################################################
# GKE MODULE Design By Gabriel Lima on Organization Quarks Labs <3
# Link: https://github.com/quarks-labs/gcp-sql-database-instance-module
#####################################################################

module "cloud-sql" {
  source = "git::git@github.com:quarks-labs/gcp-sql-database-instance-module.git"

  name                = local.name
  project             = var.project
  region              = var.region
  database_version    = var.database_version
  deletion_protection = var.deletion_protection
  private_network     = var.private_network
  databases           = try(var.databases, [])
  users               = try(var.users, [])
  settings            = var.settings
}
