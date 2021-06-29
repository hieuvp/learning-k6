#!/usr/bin/env bash

set -eoux pipefail

# minikube stop
# minikube delete

# minikube start --driver=virtualbox

cd operator
make deploy
make install

kubectl get serviceaccounts k6-operator-k6-operator --namespace=k6-operator-system --output=yaml | sed 's/k6-operator-k6-operator/k6-operator/g' | kubectl apply --filename -
kubectl get rolebindings k6-operator-leader-election-rolebinding --namespace=k6-operator-system --output=yaml | sed 's/k6-operator-k6-operator/k6-operator/g' | kubectl apply --filename -
kubectl get roles k6-operator-leader-election-role --namespace=k6-operator-system --output=yaml | sed 's/k6-operator-k6-operator/k6-operator/g' | kubectl apply --filename -

kubectl get clusterrolebindings k6-operator-manager-rolebinding --output=yaml | sed 's/k6-operator-k6-operator/k6-operator/g' | kubectl apply --filename -
kubectl get clusterrolebindings k6-operator-proxy-rolebinding --output=yaml | sed 's/k6-operator-k6-operator/k6-operator/g' | kubectl apply --filename -

kubectl get clusterroles k6-operator-manager-role --output=yaml | sed 's/k6-operator-k6-operator/k6-operator/g' | kubectl apply --filename -
kubectl get clusterroles k6-operator-metrics-reader --output=yaml | sed 's/k6-operator-k6-operator/k6-operator/g' | kubectl apply --filename -
kubectl get clusterroles k6-operator-proxy-role --output=yaml | sed 's/k6-operator-k6-operator/k6-operator/g' | kubectl apply --filename -
