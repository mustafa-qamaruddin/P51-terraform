resource "kubernetes_service" "timelines" {
  metadata {
    name = "timelines"
    namespace = "microservices"
  }

  spec {
    selector = {
      app = kubernetes_pod.timelines.metadata.0.name
    }
    port {
      port = 8080
      name = kubernetes_pod.timelines.metadata[0].name
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_pod" "timelines" {
  metadata {
    name = "timelines"
    namespace = "microservices"
    labels = {
      app = "timelines"
    }
  }

  spec {
    container {
      image = "mqu89/lorraine-baines-timelines:v3"
      name = "timelines"
    }
  }
}

resource "kubernetes_ingress" "ingress" {
  wait_for_load_balancer = true
  metadata {
    name = "ingress-timelines"
    namespace = "microservices"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      http {
        path {
          path = "/clocktower/api/v1/timeline"
          backend {
            service_name = kubernetes_service.timelines.metadata[0].name
            service_port = 8080
          }
        }
      }
    }
  }
}
