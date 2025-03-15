#!/bin/bash
# Set the K3s version you want to install
K3S_VERSION=${K3S_VERSION}
# Define K3S_CLUSTER_TOKEN
K3S_CLUSTER_TOKEN=${K3S_CLUSTER_TOKEN}
K3S_SERVER_URL=${K3S_SERVER_URL}
#!/bin/bash
curl -sfL https://get.k3s.io | K3S_VERSION=${K3S_VERSION} K3S_TOKEN=${K3S_CLUSTER_TOKEN} sh -s - agent --server https://${K3S_SERVER_URL}:6443
