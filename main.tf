provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "mqu-kafka" {
  source = "./mqu-kafka"
}

module "mqu-customers" {
  source = "./mqu-customers"
  depends_on = [
    module.mqu-kafka
  ]
}

module "mqu-memberships" {
  source = "./mqu-memberships"
  depends_on = [
    module.mqu-kafka
  ]
}

module "mqu-timelines" {
  source = "./mqu-timelines"
  depends_on = [
    module.mqu-kafka
  ]
}

module "mqu-nginx" {
  source = "./mqu-nginx"
  depends_on = [
    module.mqu-customers,
    module.mqu-memberships,
    module.mqu-timelines
  ]
  customers_svc_name = module.mqu-customers.svc_name
  memberships_svc_name = module.mqu-memberships.svc_name
  timelines_svc_name = module.mqu-timelines.svc_name
}