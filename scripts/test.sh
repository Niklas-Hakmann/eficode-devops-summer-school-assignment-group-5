#!/usr/bin/env bash
set -e

echo "$KUBECONFIG" | base64 -d > kubeconfig

NODE_IP=$(kubectl --kubeconfig kubeconfig get nodes -o jsonpath='{.items[0].status.addresses[?(@.type=="ExternalIP")].address}')
BACKEND_PORT=$(kubectl --kubeconfig kubeconfig get svc backend -o jsonpath='{.spec.ports[0].nodePort}')
FRONTEND_PORT=$(kubectl --kubeconfig kubeconfig get svc frontend -o jsonpath='{.spec.ports[0].nodePort}')

curl -f "http://${NODE_IP}:${BACKEND_PORT}/fortunes"
curl -f "http://${NODE_IP}:${FRONTEND_PORT}/healthz"