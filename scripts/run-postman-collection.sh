#!/usr/bin/env bash

set -eoux pipefail

(
  # Converts Postman collections to k6 script code
  # https://github.com/k6io/postman-to-k6

  trash tests/k6

  cd tests/postman
  postman-to-k6 collection.json \
    --environment=environment.json \
    --separate \
    --output=../k6/script.js
)

(
  cd tests/k6

  k6 run \
    --vus=10 \
    --duration=20s \
    script.js
)
