#!/bin/bash

#helm upgrade prometheus-stack kube-prometheus-stack-46.8.0.tgz --version 46.8.0 -n monitoring -f def-val.yaml
#helm upgrade prometheus-stack /root/kube-manifests-new/helm-prometheus/charts/kube-prometheus-stack-51.3.0.tgz --version 51.3.0 -n monitoring -f /root/kube-manifests-new/helm-prometheus/values/def-val-51.3.0.yaml

helm upgrade prometheus-stack /root/kube-manifests-new/helm-prometheus/charts/kube-prometheus-stack-62.3.1.tgz --version 62.3.1 -n monitoring -f /root/kube-manifests-new/helm-prometheus/values/def-val-62.3.1.yaml
