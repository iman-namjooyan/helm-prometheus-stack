#!/bin/bash
helm uninstall -n monitoring prometheus-stack
sleep 5
kubectl delete crd alertmanagerconfigs.monitoring.coreos.com
kubectl delete crd alertmanagers.monitoring.coreos.com
kubectl delete crd podmonitors.monitoring.coreos.com
kubectl delete crd probes.monitoring.coreos.com
kubectl delete crd prometheusagents.monitoring.coreos.com
kubectl delete crd prometheuses.monitoring.coreos.com
kubectl delete crd prometheusrules.monitoring.coreos.com
kubectl delete crd scrapeconfigs.monitoring.coreos.com
kubectl delete crd servicemonitors.monitoring.coreos.com
kubectl delete crd thanosrulers.monitoring.coreos.com
kubectl delete secrets -n monitoring prometheus-stack-kube-prom-admission
kubectl delete pvc -n monitoring --all --grace-period 0 --force
kubectl delete secret -n monitoring etcd-client-cert
kubectl delete ns monitoring
