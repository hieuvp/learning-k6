#!/usr/bin/env bash

set -eoux pipefail

# Results visualization > InfluxDB + Grafana
# https://k6.io/docs/results-visualization/influxdb-+-grafana/

cd k6

docker-compose down
docker-compose up --detach

set +x

printf "\nGrafana: http://127.0.0.1:3000\n\n"

docker-compose run --volume \
  "${PWD}/samples":/scripts \
  k6 run /scripts/es6sample.js
