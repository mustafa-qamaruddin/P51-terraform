provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "mqu-kafka" {
  source = "./mqu-kafka"
}