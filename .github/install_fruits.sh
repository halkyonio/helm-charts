#!/usr/bin/env bash
KUBERNETES_NAMESPACE=fruits
KIND_REGISTRY_GROUP=local
VERSION=latest

# Update index.yaml
make update-charts branch=main

# Install Fruits
kubectl create namespace $KUBERNETES_NAMESPACE

# And install application from the Helm repository
helm repo add local http://localhost:8080
helm install fruits-app halkyonio/fruits-app -n $KUBERNETES_NAMESPACE --set app.image=quay.io/halkyonio/atomic-fruits:$VERSION --set app.serviceBinding.enabled=false
kubectl wait --for=condition=ready --timeout=5m pod -l app.kubernetes.io/name=db -n $KUBERNETES_NAMESPACE
kubectl wait deployment atomic-fruits --for condition=Available=True --timeout=5m -n $KUBERNETES_NAMESPACE

POD_NAME=$(kubectl get pod -l app.kubernetes.io/name=atomic-fruits -n $KUBERNETES_NAMESPACE -o name)
RESULT=$(kubectl exec -i $POD_NAME -n $KUBERNETES_NAMESPACE -- sh -c "curl -s -i localhost:8080/home")
if [[ "$RESULT" = *"500 Internal Server Error"* ]]
then
  echo "Fruits is not working"
  exit 1
fi