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

## Generators

Generators == templates

Output generator to yaml with `--dry-run -o yaml'

Example:

    kubectl create deployment test --image nginx --dry-run -o yaml
 
    kubectl create job test --image nginx --dry-run -o yaml

## K8s with YAML

Basic command for doing things with YAML:

    kubectl apply -f filename.yml

Multiple yaml files:

    kubectl apply -f myyaml/

From a URL:

    kubectl apply -f https://bret.run/pod.yml

Keys for each `kind`:

    kubectl explain services --recursive

More information:

    kubectl explain services.spec

Drill down:

    kubectl explain services.spec.type

Server dry run:

    kubectl apply -f filename.yml --server-dry-run

Diff of what would happen:

    kubectl diff -f filename.yml

Labels go under `metadata:` and use a simple `key: value` format. Used as a glue for identifying which pods to change.

## Topics to continue

- Storage
  - StatefulSets (e.g. for DBs)
  - Volumes
  - PersistentVolumes
  - CSI plugins (in the future)
- Ingress
  - Ingress controllers
    - Nginx
    - Traefik - Bret's recommendation
    - HAProxy
    - F5
    - Envoy
    - Istio
- Custom Resource Definitions (CRDs) and the operator pattern
- Higher deployment abstractions
  - E.g. Helm
  - Compose on Kubernetes (using compose on k8s)
  - Templating YAML: Kustomize
- Kubernetes Dashboard
- Namespaces and Context
  - `kubectl get all --all-namespaces`
  - kubectl config get-contexts
  - ~/.kube/config
