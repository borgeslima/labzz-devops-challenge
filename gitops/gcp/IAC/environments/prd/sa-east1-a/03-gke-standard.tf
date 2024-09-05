#####################################################################
# GKE MODULE Design By Gabriel Lima on Organization Quarks Labs <3
# Link: https://github.com/quarks-labs/gcp-container-cluster-module
#####################################################################

module "gke-standard" {

  source = "git@github.com:quarks-labs/gcp-container-cluster-module.git"

  count = var.autopilot_enabled ? 0 : 1

  name    = local.name
  region  = var.region
  project = var.project

  initial_node_count          = var.initial_node_count
  remove_default_node_pool    = var.remove_default_node_pool
  default_max_pods_per_node   = var.default_max_pods_per_node
  enable_intranode_visibility = var.enable_intranode_visibility
  enable_l4_ilb_subsetting    = var.enable_l4_ilb_subsetting
  deletion_protection         = var.deletion_protection
  master_auth                 = var.master_auth
  addons_config               = var.addons_config
  enable_kubernetes_alpha     = var.enable_kubernetes_alpha
  enable_legacy_abac          = var.enable_legacy_abac
  network_policy              = var.network_policy
  private_cluster_config      = var.private_cluster_config

  network    = module.network.network_self_link
  subnetwork = module.network.subnetwork_self_link[0]

  ip_allocation_policy = {
    cluster_secondary_range_name  = tostring([for ips in module.network.subnetwork_secondary_ip_ranges : ips][0][0])
    services_secondary_range_name = tostring([for ips in module.network.subnetwork_secondary_ip_ranges : ips][0][1])
  }

  maintenance_policy = var.maintenance_policy
  node_pools         = concat(var.node_pools, [])
  depends_on         = [module.network, google_project_service.apis]
}
