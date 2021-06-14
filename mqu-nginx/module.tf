resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
  }
}

resource "kubernetes_ingress" "ingress" {
  metadata {
    name = "terraform-ingress"
    namespace = "ingress"
  }
  spec {
    rule {
      http {
        path {
          backend {
            service_name = var.customers_svc
            service_port = 8080
          }

          path = "/starlighter/*"
        }

        path {
          backend {
            service_name = var.membership_svc
            service_port = 8080
          }

          path = "/strickland/*"
        }

        path {
          backend {
            service_name = var.timelines_svc
            service_port = 8080
          }

          path = "/clocktower/*"
        }
      }
    }
  }
}