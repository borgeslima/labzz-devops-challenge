#####################################################################
# GKE MODULE Design By Gabriel Lima on Organization Quarks Labs <3
# Link: https://github.com/quarks-labs/gcp-network-module
#####################################################################

module "network" {

  source = "git::https://github.com/quarks-labs/gcp-network-module.git?ref=0.0.1"

  region                  = var.region
  name                    = local.name
  project                 = var.project
  auto_create_subnetworks = true
  subnetworks             = concat(var.subnetworks, [])
  depends_on              = [google_project_service.apis]
}
