WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /home/mustafa/.kube/config
WARNING: Kubernetes configuration file is world-readable. This is insecure. Location: /home/mustafa/.kube/config
NAME: kafka-release
LAST DEPLOYED: Sat Jun 12 19:29:13 2021
NAMESPACE: emmet-brown
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

ZooKeeper can be accessed via port 2181 on the following DNS name from within your cluster:

    kafka-release-zookeeper.emmet-brown.svc.cluster.local

To connect to your ZooKeeper server run the following commands:

    export POD_NAME=$(kubectl get pods --namespace emmet-brown -l "app.kubernetes.io/name=zookeeper,app.kubernetes.io/instance=kafka-release,app.kubernetes.io/component=zookeeper" -o jsonpath="{.items[0].metadata.name}")
    kubectl exec -it $POD_NAME -- zkCli.sh

To connect to your ZooKeeper server from outside the cluster execute the following commands:

    kubectl port-forward --namespace emmet-brown svc/kafka-release-zookeeper 2181:2181 &
    zkCli.sh 127.0.0.1:2181



** Please be patient while the chart is being deployed **

Kafka can be accessed by consumers via port 9092 on the following DNS name from within your cluster:

    kafka-release.emmet-brown.svc.cluster.local

Each Kafka broker can be accessed by producers via port 9092 on the following DNS name(s) from within your cluster:

    kafka-release-0.kafka-release-headless.emmet-brown.svc.cluster.local:9092

To create a pod that you can use as a Kafka client run the following commands:

    kubectl run kafka-release-client --restart='Never' --image docker.io/bitnami/kafka:2.8.0-debian-10-r30 --namespace emmet-brown --command -- sleep infinity
    kubectl exec --tty -i kafka-release-client --namespace emmet-brown -- bash

    PRODUCER:
        kafka-console-producer.sh \
            
            --broker-list kafka-release-0.kafka-release-headless.emmet-brown.svc.cluster.local:9092 \
            --topic test

    CONSUMER:
        kafka-console-consumer.sh \
            
            --bootstrap-server kafka-release.emmet-brown.svc.cluster.local:9092 \
            --topic test \
            --from-beginning
