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
      image = "mqu89/george-mcfly-customers:v4"
      name = "customers"
    }
  }
}

resource "kubernetes_ingress" "ingress" {
  wait_for_load_balancer = false
  metadata {
    name = "ingress"
    namespace = "customers-microservices"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/starlighter/*"
          backend {
            service_name = kubernetes_service.customers.metadata[0].name
            service_port = 8080
          }
        }
      }
    }
  }
}
