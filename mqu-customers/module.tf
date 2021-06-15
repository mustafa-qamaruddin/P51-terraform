resource "kubernetes_service" "customers" {
  metadata {
    name = "customers"
    namespace = "microservices"
  }

  spec {
    selector = {
      app = kubernetes_pod.customers.metadata.0.name
    }
    port {
      port = 8080
      name = kubernetes_pod.customers.metadata.0.name
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_pod" "customers" {
  metadata {
    name = "customers"
    namespace = "microservices"
    labels = {
      app = "customers"
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
  wait_for_load_balancer = true
  metadata {
    name = "ingress-customers"
    namespace = "microservices"
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
