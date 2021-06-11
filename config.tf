provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "kafka" {
  source = "./kafka"
}