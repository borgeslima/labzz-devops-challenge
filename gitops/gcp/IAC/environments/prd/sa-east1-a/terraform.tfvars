#####################################################################
# Global Configurations
#####################################################################

name    = "labzz-challenge"
project = "labzz-challenge"
region  = "southamerica-east1"

#####################################################################
# APIS GCP Configurations
#####################################################################


gcp_api_enabled = [
  "container.googleapis.com",
  "artifactregistry.googleapis.com",
  "binaryauthorization.googleapis.com",
  "trafficdirector.googleapis.com",
  "multiclusterservicediscovery.googleapis.com",
  "multiclusteringress.googleapis.com",
  "connectgateway.googleapis.com",
  "anthos.googleapis.com",
  "gkeconnect.googleapis.com",
  "dns.googleapis.com",
  "gkehub.googleapis.com",
  "cloudresourcemanager.googleapis.com"
]


#####################################################################
# VPC Configurations
#####################################################################

subnetworks = [{
  name                     = "southamerica-east1"
  region                   = "southamerica-east1"
  ip_cidr_range            = "10.1.0.0/20"
  private_ip_google_access = false

  nat = {
    nat_ip_allocate_option             = "MANUAL_ONLY"
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  }

  secondary_ip_ranges = [
    {
      range_name    = "primary"
      ip_cidr_range = "10.1.32.0/20"
    },
    {
      range_name    = "secondary"
      ip_cidr_range = "10.1.64.0/20"
    }
  ]
}]



#####################################################################
# GKE Standard Configurations
#####################################################################

autopilot_enabled = true

initial_node_count          = 1
remove_default_node_pool    = true
default_max_pods_per_node   = 110
enable_intranode_visibility = false
enable_l4_ilb_subsetting    = true
deletion_protection         = false

network_policy = {
  enabled  = true
  provider = "CALICO"
}

enable_kubernetes_alpha = false
enable_legacy_abac      = true


private_cluster_config = {
  enable_private_endpoint = false
  enable_private_nodes    = true
  master_ipv4_cidr_block  = "172.16.0.32/28"
  master_global_access_config = {
    enabled = true
  }
}


#####################################################################
# GKE NODE-POOL
#####################################################################


node_pools = [{

  name       = "n1-standard-1"
  node_count = 1

  autoscaling = {
    total_min_node_count = 1
    total_max_node_count = 3
    location_policy      = "BALANCED"
  }

  node_config = {
    machine_type = "n1-standard-1"
    disk_type    = "pd-ssd"
    disk_size_gb = 20
    preemptible  = false
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    tags     = []
    metadata = {}
    labels   = {}
  }
  timeouts = {
    create = "30m"
    update = "30m"
  }

}]


master_auth = {
  client_certificate_config = {
    issue_client_certificate = true
  }
}

addons_config = {

  gce_persistent_disk_csi_driver_config = {
    enabled = true
  }

  http_load_balancing = {
    disable = false
  }

  network_policy_config = {
    disabled = false
  }

}

maintenance_policy = {
  daily_maintenance_window = {
    start_time = "03:00"
  }
}


#####################################################################
# CLOUD SQL
#####################################################################


database_version = "POSTGRES_14"

private_network = {
  enabled = false
}

settings = {
  disk_size = "20"
  tier      = "db-f1-micro"
  data_cache_config = {
    data_cache_enabled = false
  }
  disk_type = "PD_SSD"
  ip_configuration = {
    ipv4_enabled = true
    authorized_networks = [{
      name  = "allow-all",
      range = "0.0.0.0/0"
    }]
  }
}
