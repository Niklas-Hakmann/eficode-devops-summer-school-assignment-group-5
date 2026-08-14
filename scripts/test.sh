#!/usr/bin/env bash
set -e
echo "$KUBECONFIG" | base64 -d > kubeconfig
kubectl --kubeconfig kubeconfig port-forward pod/backend 9000:9000 &
kubectl --kubeconfig kubeconfig port-forward pod/frontend 8080:8080 &
trap 'kill $(jobs -p)' Exit

sleep 5

curl -f http://localhost:9000/fortunes
curl -f http://localhost:8080/healthz