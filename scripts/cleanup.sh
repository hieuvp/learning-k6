#!/usr/bin/env bash

set -eoux pipefail

(
  minikube stop || true
  minikube delete
)

(
  cd k6
  docker-compose down
)
