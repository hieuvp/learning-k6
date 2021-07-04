#!/usr/bin/env bash

set -eoux pipefail

(
  trash tests/k6

  cd tests/postman
  postman-to-k6 collection.json \
    --environment=environment.json \
    --separate \
    --output=../k6/script.js
)

(
  cp postman/rollup.config.js tests/k6
  cd tests/k6
  npm install @rollup/plugin-commonjs@19.0.0 --save-dev
  rollup --config rollup.config.js
)

kubectl delete namespace k6-test || true
kubectl create namespace k6-test

kubectl create configmap postman-collection-test \
  --from-file=tests/k6/dist/test.js \
  --namespace=k6-test

kubectl apply \
  --filename=postman/k6-resource.yml \
  --namespace=k6-test
