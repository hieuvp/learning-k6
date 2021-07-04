#!/usr/bin/env bash

set -eoux pipefail

# minikube stop
# minikube delete

minikube start --driver=virtualbox

cd operator
make deploy
make install
