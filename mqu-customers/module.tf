resource "kubernetes_namespace" "customers_microservices" {
  metadata {
    name = "customers-microservices"
  }
}

resource "kubernetes_service" "customers" {
  metadata {
    name = "customers"
    namespace = "customers-microservices"
  }

  spec {
    selector = {
      app = kubernetes_pod.customers.metadata.0.labels.app
    }
    port {
      port = 8080
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_pod" "customers" {
  metadata {
    name = "customers"
    namespace = "customers-microservices"
    labels = {
      app = "CustomersMicroservice"
    }
  }

  spec {
    container {
      image = "mqu89/george-mcfly-customers:v0"
      name = "customers"
    }
  }
}