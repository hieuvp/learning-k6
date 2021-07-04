#!/usr/bin/env bash

set -eoux pipefail

# minikube stop
# minikube delete

minikube start --driver=virtualbox

# https://github.com/k6io/operator/tree/v0.0.4
cd operator

make deploy
make install
