#!/bin/bash

#=========================[Define Variables]
VALUES_DIR=./values
CHARTS_DIR=./charts
INGRESS_DIR=./ingress
NAMESPACE=monitoring
#=========================[Define Functions]
CREATE_NAMESPACE() {
kubectl create namespace monitoring
CREATE_PROMETHEUS_INGRESS
CREATE_GRAFANA_INGRESS
}

CREATE_SMTP_SECRET(){
kubectl apply -f /root/kube-manifests-new/helm-prometheus/other-conf/smtp/smtp-new.yaml
}

CREATE_EXTERNAL_ETCD_SECRET() {
kubectl -n $NAMESPACE create secret generic etcd-client-cert \
--from-file=ca.pem=/etc/ssl/etcd/ssl/ca.pem \
--from-file=etcd-cert.pem=/etc/ssl/etcd/ssl/member-k8s-master01.pem \
--from-file=etcd-key.pem=/etc/ssl/etcd/ssl/member-k8s-master01-key.pem
}

CREATE_PROMETHEUS_INGRESS() {
kubectl apply -f $INGRESS_DIR/01-basic-auth-ui.yaml -f $INGRESS_DIR/02-ingress-prometheus.yaml
}

CREATE_GRAFANA_INGRESS() {
kubectl apply -f $INGRESS_DIR/03-ingress-grafana.yaml
}

DEPLOY_PROMETHEUS_STACK() {

echo -e "\033[1;34m[Prometheus-Stack Available Versions To Install]\033[0m\n\033[1;36m1) kube-prometheus-stack-46.8.0\n2) kube-prometheus-stack-51.3.0\n3) kube-prometheus-stack-62.3.1\n4) kube-prometheus-stack-68.3.2 \033[0m\n "
echo -e "\033[1;35m====================[Select Desire Version]=======================\033[0m"
read -p "Please Enter Number Your Desired Prometheus-Stack Version(0 exit): " INPUT

case $INPUT in
    1)
        CREATE_NAMESPACE
        CREATE_EXTERNAL_ETCD_SECRET
        helm install prometheus-stack $CHARTS_DIR/kube-prometheus-stack-46.8.0.tgz --version 46.8.0 -n $NAMESPACE -f $VALUES_DIR/def-val-46.8.0.yaml --create-namespace
        ;;
    2)
        CREATE_NAMESPACE
        CREATE_EXTERNAL_ETCD_SECRET
        helm install prometheus-stack $CHARTS_DIR/kube-prometheus-stack-51.3.0.tgz --version 51.3.0 -n $NAMESPACE -f $VALUES_DIR/def-val-51.3.0.yaml --create-namespace
        ;;
    3)
        CREATE_NAMESPACE
        CREATE_SMTP_SECRET
        CREATE_EXTERNAL_ETCD_SECRET
        helm install prometheus-stack $CHARTS_DIR/kube-prometheus-stack-62.3.1.tgz --version 62.3.1 -n $NAMESPACE -f $VALUES_DIR/def-val-62.3.1.yaml --create-namespace
        ;;
    4)
        CREATE_NAMESPACE
        CREATE_SMTP_SECRET
        CREATE_EXTERNAL_ETCD_SECRET
        helm install prometheus-stack $CHARTS_DIR/kube-prometheus-stack-68.3.2.tgz --version 68.3.2 -n $NAMESPACE -f $VALUES_DIR/def-val-68.3.2.yaml --create-namespace
        ;;
    0)
        echo "Exited ...!!!"
        exit 0
        ;;
    *)
        echo "Input Is Not Valid, Please Enter Valid Input.....!!!"
        DEPLOY_PROMETHEUS_STACK
        ;;
esac
}

#======================[Main]
DEPLOY_PROMETHEUS_STACK
