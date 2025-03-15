#!/bin/bash
# Set the K3s version you want to install
K3S_VERSION=${K3S_VERSION}
# Define K3S_CLUSTER_TOKEN
K3S_CLUSTER_TOKEN=${K3S_CLUSTER_TOKEN}
K3S_SERVER_URL=${K3S_SERVER_URL}
#!/bin/bash
curl -sfL https://get.k3s.io | K3S_VERSION=${K3S_VERSION} K3S_TOKEN=${K3S_CLUSTER_TOKEN} sh -s - agent --server https://${K3S_SERVER_URL}:6443

curl -sfL https://get.k3s.io | K3S_VERSION=v1.24.6+k3s1 K3S_TOKEN=Cz6ygIcRr3td6xKQZjYJVFmgkYn3SZ sh -s - agent --server https://telnet k3s-master-lb-a10438e9c29ad6e5.elb.us-east-1.amazonaws.com:6443