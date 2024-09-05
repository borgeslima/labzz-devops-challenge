#####################################################################
# GKE MODULE Design By Gabriel Lima on Organization Quarks Labs <3
# Link: https://github.com/quarks-labs/gcp-container-cluster-autopilot-module
#####################################################################


module "gke-autopilot" {

  source = "git::git@github.com:quarks-labs/gcp-container-cluster-autopilot-module.git?ref=1.0.0"

  count = var.autopilot_enabled ? 1 : 0

  name    = local.name
  region  = var.region
  project = var.project

  initial_node_count = var.initial_node_count

  network    = module.network.network_self_link
  subnetwork = module.network.subnetwork_self_link[0]

  ip_allocation_policy = {
    cluster_secondary_range_name  = tostring([for ips in module.network.subnetwork_secondary_ip_ranges : ips][0][0])
    services_secondary_range_name = tostring([for ips in module.network.subnetwork_secondary_ip_ranges : ips][0][1])
  }

  master_auth = {
    client_certificate_config = {
      issue_client_certificate = true
    }
  }

  maintenance_policy = var.maintenance_policy

  depends_on = [module.network, google_project_service.apis]
}

