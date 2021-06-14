resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
  }
}

resource "kubernetes_ingress" "ingress" {
  wait_for_load_balancer = true
  metadata {
    name = "ingress"
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
            service_name = "customers"
            service_port = 8080
          }
        }
        path {
          path = "/strickland/*"
          backend {
            service_name = "memberships"
            service_port = 8080
          }
        }
        path {
          path = "/clocktower/*"
          backend {
            service_name = "timelines"
            service_port = 8080
          }
        }
      }
    }
  }
}