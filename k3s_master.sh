#!/bin/bash
# Set the K3s version you want to install
K3S_VERSION=${K3S_VERSION}
# Define K3S_CLUSTER_TOKEN
K3S_CLUSTER_TOKEN=${K3S_CLUSTER_TOKEN}
K3S_SERVER_URL=${K3S_SERVER_URL}
K3S_NODEIP=${K3S_NODEIP}

sudo apt-get update && sudo apt-get install -y cron

curl -sfL https://get.k3s.io | K3S_VERSION=${K3S_VERSION} K3S_TOKEN=${K3S_CLUSTER_TOKEN} sh -s - server --tls-san=${K3S_SERVER_URL} --node-ip=${K3S_NODEIP}


cat <<'EOF' > /usr/local/bin/drain_node.sh
#!/bin/bash

# Watch for nodes in NotReady state
kubectl get nodes --watch | while read line; do
  node_status=$(echo $line | awk '{print $2}')
  node_name=$(echo $line | awk '{print $1}')
  
  # Check if the node is NotReady
  if [[ "$node_status" == "NotReady" ]]; then
    echo "Node $node_name is NotReady, draining the node..."
    kubectl drain $node_name --ignore-daemonsets --delete-local-data
  fi
done
EOF

sudo chmod +x /usr/local/bin/drain_node.sh

# Create a cron job to run the drain node script every minute (or change the timing as needed)
echo "* * * * * root /usr/local/bin/drain_node.sh" | sudo tee /etc/cron.d/drain_node_cron