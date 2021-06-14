resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "sherman-peabody"
  }
}

resource "helm_release" "nginx" {
  name = "nginx-release"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "nginx"
  version = "9.1.0"
  namespace = "sherman-peabody"

  set {
    name = "clusterDomain"
    value = "cluster.local"
  }
  set {
    name = "service.annotations.external-dns\\.alpha\\.kubernetes\\.io/hostname"
    value = "marty-mcfly.local"
  }
}
