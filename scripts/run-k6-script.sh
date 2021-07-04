#!/usr/bin/env bash

set -eoux pipefail

trash /tmp/learning-k6
mkdir --parents /tmp/learning-k6
jsonnet k6-config.jsonnet >/tmp/learning-k6/k6-config.json

k6 run \
  --config=/tmp/learning-k6/k6-config.json \
  k6-script.js
