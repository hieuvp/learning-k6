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

helm install influxdb \
  --values=visualization/influxdb-values.yaml \
  --wait --timeout=300s \
  --namespace=k6-test \
  ./visualization/influxdb

helm install grafana \
  --set-string admin.password=admin \
  --namespace=k6-test \
  ./visualization/grafana

kubectl create configmap test-with-visualization \
  --from-file=tests/k6/dist/test.js \
  --namespace=k6-test

kubectl apply \
  --filename=visualization/k6-resource.yml \
  --namespace=k6-test

set +x

printf "\nkubectl port-forward --namespace=k6-test svc/grafana 3000:3000\n"
printf "Grafana     : http://127.0.0.1:3000 (admin/admin)\n\n"

# Use InfluxDB as data source
printf "Data Source : http://influxdb:8086/k6\n"

# k6 Load Testing Results
printf "Dashboard   : https://grafana.com/grafana/dashboards/10660\n\n"
# The most popular  : https://grafana.com/grafana/dashboards/2587
