# Kubernetes Notes

## Basic commands

Run an image on the cluster:

    kubectl run DEPLOYMENT_NAME --image IMAGE_NAME

Get status of pods:

    kubectl get pods

Get status of cluster:

    kubectl get all

Remove deployment:

    kubectl delete deployment DEPLOYMENT_NAME
