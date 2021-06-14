resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
  }
}

resource "kubernetes_ingress" "ingress" {
  wait_for_load_balancer = false
  metadata {
    name = "ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = "marty-mcfly.local"
      http {
        path {
          path = "/starlighter/*"
          backend {
            service_name = var.customers_svc_name
            service_port = 8080
          }
        }
        path {
          path = "/strickland/*"
          backend {
            service_name = var.memberships_svc_name
            service_port = 8080
          }
        }
        path {
          path = "/clocktower/*"
          backend {
            service_name = var.timelines_svc_name
            service_port = 8080
          }
        }
      }
    }
  }
}