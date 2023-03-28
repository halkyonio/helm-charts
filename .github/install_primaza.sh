#!/usr/bin/env bash
KUBERNETES_NAMESPACE=primaza
KIND_REGISTRY_GROUP=local
VERSION=0.0.1-SNAPSHOT

# Update index.yaml
make update-charts branch=main

# Install Primaza
kubectl create namespace $KUBERNETES_NAMESPACE

# And install application from the Helm repository
helm repo add local http://localhost:8080
helm install primaza-app local/primaza-app -n $KUBERNETES_NAMESPACE --set app.image=quay.io/halkyonio/primaza-app:$VERSION
kubectl wait --for=condition=ready --timeout=5m pod -l app.kubernetes.io/name=primaza-app -n $KUBERNETES_NAMESPACE

POD_NAME=$(kubectl get pod -l app.kubernetes.io/name=primaza-app -n $KUBERNETES_NAMESPACE -o name)
RESULT=$(kubectl exec -i $POD_NAME --container primaza-app -n $KUBERNETES_NAMESPACE -- sh -c "curl -s -i localhost:8080/home")
if [[ "$RESULT" = *"500 Internal Server Error"* ]]
then
  echo "Primaza is not working"
  exit 1
fi