#!/usr/bin/env bash

KUBERNETES_NAMESPACE=fruits
POD_NAME=$(kubectl get pod -l app.kubernetes.io/name=fruits-app -n $KUBERNETES_NAMESPACE -o name)
kubectl logs $POD_NAME -n $KUBERNETES_NAMESPACE
kubectl describe $POD_NAME -n $KUBERNETES_NAMESPACE