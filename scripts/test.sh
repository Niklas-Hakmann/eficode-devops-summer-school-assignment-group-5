#!/usr/bin/env bash
set -e
echo "$KUBECONFIG" | base64 -d > kubeconfig
kubectl --kubeconfig kubeconfig port-forward pod/backend 9000:9000 &
kubectl --kubeconfig kubeconfig port-forward pod/frontend 8080:8080 &
trap 'kill $(jobs -p)' Exit

sleep 5

curl -u "$WORKSTATION_USER:$WORKSTATION_PASS" -f https://workstation-51.sdu.eficode.academy/proxy/9000/fortunes
curl -u "$WORKSTATION_USER:$WORKSTATION_PASS" -f https://workstation-51.sdu.eficode.academy/proxy/8080/healthz
