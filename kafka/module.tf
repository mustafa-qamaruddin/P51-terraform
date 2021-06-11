module "helm_remote_deployment" {
  remote_chart = "true"
  source = "https://charts.bitnami.com/bitnami"
  ## The name of the deployment
  deployment_name = "kafka"
  ## Name of the namespace
  deployment_environment = "kafka"
  ## Path for helm chart
  deployment_path = "bitnami/kafka"
  ## Chart version
  release_version = "12.20.0"
  ## your values.yaml file
  values = "values.yaml"
}