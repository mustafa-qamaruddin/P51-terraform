resource "kubernetes_namespace" "memberships_microservices" {
  metadata {
    name = "memberships-microservices"
  }
}

resource "kubernetes_service" "memberships" {
  metadata {
    name = "memberships"
    namespace = "memberships-microservices"
  }

  spec {
    selector = {
      app = kubernetes_pod.memberships.metadata.0.labels.app
    }
    port {
      port = 8080
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_pod" "memberships" {
  metadata {
    name = "memberships"
    namespace = "memberships-microservices"
    labels = {
      app = "membershipsMicroservice"
    }
  }

  spec {
    container {
      image = "mqu89/emmet-brown-memberships:v1"
      name = "memberships"
    }
  }
}