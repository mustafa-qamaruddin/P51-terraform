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
      image = "mqu89/lorraine-baines-timelines:v1"
      name = "timelines"
    }
  }
}