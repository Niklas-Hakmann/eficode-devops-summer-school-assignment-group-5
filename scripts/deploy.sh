#!/usr/bin/env bash
set -e

echo "$KUBECONFIG" | base64 -d > kubeconfig


kubectl --kubeconfig kubeconfig apply -f redis/redis-pvc.yml
kubectl --kubeconfig kubeconfig apply -f redis/redis-pod.yml
kubectl --kubeconfig kubeconfig apply -f redis/redis-service.yml

kubectl --kubeconfig kubeconfig apply -f backend/backend-pod.yml
kubectl --kubeconfig kubeconfig apply -f frontend/frontend-pod.yml
