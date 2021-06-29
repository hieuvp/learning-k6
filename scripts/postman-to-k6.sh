#!/usr/bin/env bash

set -eoux pipefail

trash tests/k6

# Convert Postman collection to k6 test
cd tests/postman
postman-to-k6 collection.json \
  --environment=environment.json \
  --separate \
  --output=../k6/script.js
