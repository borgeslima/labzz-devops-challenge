################################################################################
# APIS
################################################################################

resource "google_project_service" "apis" {
  for_each = try({ for idx, api in var.gcp_api_enabled : api => api }, {})
  project  = var.project
  service  = each.value
}
