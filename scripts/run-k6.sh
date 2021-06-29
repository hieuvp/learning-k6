#!/usr/bin/env bash

set -eoux pipefail

# cd tests/k6
# k6 run script.js

# Virtual Users (VUs)
k6 run \
  --vus=10 \
  --duration=30s \
  script.js
