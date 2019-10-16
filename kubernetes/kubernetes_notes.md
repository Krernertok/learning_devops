# Kubernetes Notes

## Basic commands

Run an image on the cluster:

    kubectl run DEPLOYMENT_NAME --image IMAGE_NAME

Get status of pods:

    kubectl get pods

Watch pods:

    kubectl get pods -w

Get status of cluster:

    kubectl get all

Get pod details:

    kubectl describe pod/POD_NAME

Scale deployment

    kubectl scale deploy/DEPLOYMENT_NAME --replicas N

Get deployment logs (`N` log lines):

    kubectl logs deploy/DEPLOYMENT_NAME --follow --tail N

Or:

    kubectl logs -l run=LABEL

Delete pod:

    kubectl delete pod/POD_NAME

Remove deployment:

    kubectl delete deploy/DEPLOYMENT_NAME

## Services

Service types:

- ClusterIP
  - Only within the cluster
- NodePort
  - Port is open on every node
  - Anyone can access (if they can reach a node)
- LoadBalancer
  - Usually only when using a loadbalancer outside the cluster
- ExternalName
  - Gives pods a DNS name to use for something located outside of the cluster

Create a ClusterIP service (after creating and scaling a deployment):

    kubectl expose deploy/DEPLOYMENT_NAME --port PORT_NUMBER

List services:

    kubectl get services

Create a NodePort:

    kubectl expose deploy/DEPLOYMENT_NAME --port PORT_NUMBER --name NODEPORT_NAME --type NodePort

To create a LoadBalancer type service, use `LoadBalancer` as the type.

Delete service:

    kubectl delete service/SERVICE_NAME

