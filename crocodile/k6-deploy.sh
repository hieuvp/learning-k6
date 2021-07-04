#!/usr/bin/env bash

set -eoux pipefail

kubectl delete namespace k6-test || true
kubectl create namespace k6-test

kubectl create configmap crocodile-stress-test \
  --from-file=crocodile/k6-test-script.js \
  --namespace=k6-test \
  --output=yaml --dry-run |
  sed "s/k6-test-script.js/test.js/" |
  kubectl apply --filename -

kubectl apply \
  --filename=crocodile/k6-resource.yml \
  --namespace=k6-test
