

provider "helm" {
  kubernetes {
    host                   = "https://${module.gke-autopilot[0].endpoint}"
    token                  = data.google_client_config.provider.access_token
    cluster_ca_certificate = base64decode(module.gke-autopilot[0].master_auth[0].cluster_ca_certificate)
  }
}

resource "helm_release" "cert-manager" {

  name              = "cert-manager"
  repository        = "https://charts.jetstack.io"
  chart             = "cert-manager"
  namespace         = "cert-manager"
  force_update      = true
  cleanup_on_fail   = true
  create_namespace  = true
  wait              = true
  disable_crd_hooks = true
  version           = "v1.15.3"
  skip_crds         = true
  timeout           = 30000
  values            = try(["${file("./helms/cert-manager/values.yaml")}", ], [])

  depends_on = [
    module.gke-autopilot,
    module.gke-standard
  ]
}


resource "helm_release" "cert-manager-config" {
  name              = "cert-manager-config"
  chart             = "./helms/cert-manager-config"
  namespace         = "default"
  force_update      = true
  cleanup_on_fail   = true
  create_namespace  = true
  wait              = true
  disable_crd_hooks = true
  version           = "0.1.3"
  skip_crds         = false
  timeout           = 300000
  values            = try(["${file("./helms/cert-manager-config/values.yaml")}", ], [])
  depends_on = [
    module.gke-autopilot,
    module.gke-standard,
    helm_release.cert-manager
  ]
}

resource "helm_release" "ingress-nginx" {
  name              = "ingress-nginx"
  repository        = "https://kubernetes.github.io/ingress-nginx"
  chart             = "ingress-nginx"
  namespace         = "ingress-nginx"
  force_update      = true
  cleanup_on_fail   = true
  create_namespace  = true
  wait              = true
  disable_crd_hooks = true
  version           = "4.7.0"
  skip_crds         = false
  timeout           = 300000
  values            = try(["${file("./helms/ingress-nginx/values.yaml")}", ], [])

  depends_on = [
    module.gke-autopilot,
    module.gke-standard,
    helm_release.cert-manager,
    helm_release.cert-manager-config
  ]
}


resource "helm_release" "flowise" {
  name              = "flowise"
  repository        = "https://cowboysysop.github.io/charts"
  chart             = "flowise"
  namespace         = "flowise"
  force_update      = true
  cleanup_on_fail   = true
  create_namespace  = true
  wait              = true
  disable_crd_hooks = true
  skip_crds         = false
  timeout           = 300000
  values            = try(["${file("./helms/flowise/values.yaml")}", ], [])

  depends_on = [
    module.gke-autopilot,
    module.gke-standard,
    helm_release.cert-manager,
  ]
}

/*
resource "helm_release" "dynatrace" {
  name              = "dynatrace-operator"
  repository        = "oci://public.ecr.aws/dynatrace/"
  chart             = "dynatrace-operator"
  namespace         = "dynatrace"
  force_update      = true
  cleanup_on_fail   = true
  create_namespace  = true
  wait              = true
  disable_crd_hooks = true
  skip_crds         = false
  timeout           = 300000
  // values            = try(["${file("./helms/dynatrace/values.yaml")}", ], [])

  depends_on = [
    module.gke-autopilot,
    module.gke-standard
  ]
}

*/



