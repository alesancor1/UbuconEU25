#!/bin/bash

apt update 
apt install -y snapd

sleep 5

snap install rockcraft --classic
lxd init --auto

# Define the skopeo-copy function
cat << 'EOF' >> ~/.bashrc

# Custom skopeo-copy function for Rockcraft OCI rocks
skopeo-copy() {
    short_name=$(echo "$1" | cut -d '_' -f1)
    short_version=$(echo "$1" | cut -d '_' -f2)
    sudo rockcraft.skopeo --insecure-policy copy oci-archive:"$1" docker-daemon:"$short_name":"$short_version"
}
EOF

# Source .bashrc immediately (only applies to current script session)
source ~/.bashrc

# Signal completion
echo done > /tmp/background0
