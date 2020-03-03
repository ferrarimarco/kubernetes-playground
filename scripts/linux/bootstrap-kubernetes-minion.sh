#!/bin/sh

SCRIPT_PATH="/vagrant/scripts/linux"

master_address="$1"
token="$2"

kubernetes_cluster_ip_cidr="$3"

network_plugin_id="$4"

playground_name="$5"


if [ "$network_plugin_id" = 'weavenet' ]; then
    echo "Setup networking for weavenet"
    echo "Setting up a route to Kubernetes cluster IP ($kubernetes_cluster_ip_cidr) via $master_address"

    #TODO this is not persistent across reboot
    ip route add "$kubernetes_cluster_ip_cidr" via "$master_address"

elif [ "$network_plugin_id" = 'calico' ]; then
    echo "Setup networking for calico"
    # nothing is needed

elif [ "$network_plugin_id" = 'flannel' ]; then
    echo "Setup networking for flannel"
    
    $SCRIPT_PATH/config-etc-hosts.sh "$playground_name"
    
fi


echo "Initializing Kubernetes minion to join: $master_address and token: $token"
kubeadm join "$master_address":6443 --token "$token" --discovery-token-unsafe-skip-ca-verification