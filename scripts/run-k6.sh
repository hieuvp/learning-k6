#!/usr/bin/env bash

set -eoux pipefail

cd tests/k6
k6 run script.js
