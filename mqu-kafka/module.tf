resource "kubernetes_namespace" "emmet-brown" {
  metadata {
    name = "emmet-brown"
  }
}

resource "helm_release" "bitnami_kafka" {
  name = "kafka-release"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "kafka"
  version = "12.20.0"
  namespace = "emmet-brown"

  set {
    name = "clusterDomain"
    value = "cluster.local"
  }

  set {
    name = "config"
    value = <<EOT
      |-
      num.network.threads = 3
      num.io.threads = 8
      socket.send.buffer.bytes = 102400
      socket.receive.buffer.bytes = 102400
      socket.request.max.bytes = 104857600
      num.partitions = 1
      num.recovery.threads.per.data.dir = 1
      offsets.topic.replication.factor = 1
      transaction.state.log.replication.factor = 1
      transaction.state.log.min.isr = 1
      log.flush.interval.messages = 10000
      log.flush.interval.ms = 1000
      log.retention.hours = 168
      log.retention.bytes = 1073741824
      log.segment.bytes = 1073741824
      log.retention.check.interval.ms = 300000
      zookeeper.connection.timeout.ms = 6000
      group.initial.rebalance.delay.ms = 0
    EOT
  }

  set {
    name = "heapOpts"
    value = "-Xmx500m -Xms500m"
  }

  set {
    name = "deleteTopicEnable"
    value = true
  }

  set {
    name = "autoCreateTopicsEnable"
    value = true
  }

  set {
    name = "externalAccess.enabled"
    value = true
  }

  set {
    name = "externalAccess.autoDiscovery.enabled"
    value = true
  }

  set {
    name = "persistence.enabled"
    value = true
  }

  set {
    name = "persistence.size"
    value = "1Gi"
  }
}
