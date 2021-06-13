resource "kubernetes_namespace" "microservices" {
  metadata {
    name = "microservices"
  }
}

resource "kubernetes_service" "customers" {
  metadata {
    name = "customers"
    namespace = "microservices"
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
    namespace = "microservices"
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