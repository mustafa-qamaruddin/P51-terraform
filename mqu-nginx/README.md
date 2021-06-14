NAME: nginx-release
LAST DEPLOYED: Mon Jun 14 17:49:30 2021
NAMESPACE: sherman-peabody
STATUS: failed
REVISION: 1
TEST SUITE: None
NOTES:
** Please be patient while the chart is being deployed **

NGINX can be accessed through the following DNS name from within your cluster:

    nginx-release.sherman-peabody.svc.cluster.local (port 80)

To access NGINX from outside the cluster, follow the steps below:

1. Get the NGINX URL by running these commands:

NOTE: It may take a few minutes for the LoadBalancer IP to be available.
Watch the status with: 'kubectl get svc --namespace sherman-peabody -w nginx-release'

    export SERVICE_PORT=$(kubectl get --namespace sherman-peabody -o jsonpath="{.spec.ports[0].port}" services nginx-release)
    export SERVICE_IP=$(kubectl get svc --namespace sherman-peabody nginx-release -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
    echo "http://${SERVICE_IP}:${SERVICE_PORT}"
