resource "kubernetes_namespace" "timelines_microservices" {
  metadata {
    name = "timelines-microservices"
  }
}

resource "kubernetes_service" "timelines" {
  metadata {
    name = "timelines"
    namespace = "timelines-microservices"
  }

  spec {
    selector = {
      app = kubernetes_pod.timelines.metadata.0.labels.app
    }
    port {
      port = 8080
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_pod" "timelines" {
  metadata {
    name = "timelines"
    namespace = "timelines-microservices"
    labels = {
      app = "timelinesMicroservice"
    }
  }

  spec {
    container {
      image = "mqu89/lorraine-baines-timelines:v2"
      name = "timelines"
    }
  }
}

resource "kubernetes_ingress" "ingress" {
  wait_for_load_balancer = false
  metadata {
    name = "ingress"
    namespace = "timelines-microservices"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = "marty-mcfly.local"
      http {
        path {
          path = "/clocktower/*"
          backend {
            service_name = kubernetes_service.timelines.metadata[0].name
            service_port = 8080
          }
        }
      }
    }
  }
}

output "svc_name" {
  value = kubernetes_service.timelines.metadata[0].name
}