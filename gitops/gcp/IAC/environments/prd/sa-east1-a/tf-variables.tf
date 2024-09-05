
variable "name" {
  type        = string
  description = "Default name of solution"
}

variable "project" {
  type        = string
  description = "project_id of solution"
}

variable "region" {
  type        = string
  description = "region of solution"
}

variable "node_pools" {
  type = list(object({
    name       = string
    node_count = number
    autoscaling = object({
      total_min_node_count = number
      total_max_node_count = number
      location_policy      = string
    })
    node_config = object({
      machine_type = string
      disk_type    = string
      disk_size_gb = number
      preemptible  = bool
      oauth_scopes = set(string)
      tags         = list(string)
      metadata     = map(string)
      labels       = map(string)
    })
    timeouts = object({
      create = string
      update = string
    })
  }))
  description = "Node Pool"
}

variable "master_auth" {
  type = object({
    client_certificate_config = object({
      issue_client_certificate = bool
    })
  })
}

variable "gcp_api_enabled" {
  type = list(string)
}

variable "addons_config" {
  type = object({
    gce_persistent_disk_csi_driver_config = object({
      enabled = bool
    })
    http_load_balancing = object({
      disable = bool
    })
    network_policy_config = object({
      disabled = bool
    })
  })
}

variable "private_cluster_config" {
  type = object({
    enable_private_endpoint = bool
    enable_private_nodes    = bool
    master_ipv4_cidr_block  = string
    master_global_access_config = object({
      enabled = bool
    })
  })
}

variable "autopilot_enabled" {
  type    = bool
  default = false
}

variable "enable_kubernetes_alpha" {
  type = bool
}

variable "enable_legacy_abac" {
  type = bool
}

variable "network_policy" {
  type = object({
    enabled  = bool
    provider = string
  })
}

variable "maintenance_policy" {
  type = object({
    daily_maintenance_window = object({
      start_time = string
    })
  })
}

variable "initial_node_count" {
  type = number
}

variable "remove_default_node_pool" {
  type = bool
}

variable "default_max_pods_per_node" {
  type    = number
  default = 110
}

variable "enable_intranode_visibility" {
  type = bool
}

variable "enable_l4_ilb_subsetting" {
  type = bool
}

variable "deletion_protection" {
  type = bool
}

variable "subnetworks" {
  type = list(object({
    name                     = string
    region                   = string
    ip_cidr_range            = string
    private_ip_google_access = bool
    nat = object({
      nat_ip_allocate_option             = string
      source_subnetwork_ip_ranges_to_nat = string
    })
    secondary_ip_ranges = list(object({
      range_name    = string
      ip_cidr_range = string
    }))
  }))
  description = "List of GCP Subnetworks"
}


variable "database_version" {
  type = string
}

variable "private_network" {
  type = object({
    enabled = bool
  })
}

variable "databases" {
  type = list(object({
    name = string
  }))
}

variable "users" {
  type = list(object({
    name     = string
    password = string
  }))
}

variable "settings" {
  type = object({
    disk_size = string
    tier      = string
    disk_type = string
    data_cache_config = object({
      data_cache_enabled = bool
    })
    ip_configuration = object({
      ipv4_enabled = bool
      authorized_networks = list(object({
        name  = string
        range = string
      }))
    })
  })
}
