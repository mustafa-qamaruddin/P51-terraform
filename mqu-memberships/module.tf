resource "kubernetes_service" "memberships" {
  metadata {
    name = "memberships"
    namespace = "microservices"
  }

  spec {
    selector = {
      app = kubernetes_pod.memberships.metadata.0.name
    }
    port {
      port = 8080
      name = kubernetes_pod.memberships.metadata[0].name
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_pod" "memberships" {
  metadata {
    name = "memberships"
    namespace = "microservices"
    labels = {
      app = "memberships"
    }
  }

  spec {
    container {
      image = "mqu89/emmet-brown-memberships:v3"
      name = "memberships"
    }
  }
}

resource "kubernetes_ingress" "ingress" {
  wait_for_load_balancer = true
  metadata {
    name = "ingress-memberships"
    namespace = "microservices"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/strickland/api/v1/membership"
          backend {
            service_name = kubernetes_service.memberships.metadata[0].name
            service_port = 8080
          }
        }
        path {
          path = "/strickland/api/v1/membership/revoke"
          backend {
            service_name = kubernetes_service.memberships.metadata[0].name
            service_port = 8080
          }
        }
      }
    }
  }
}