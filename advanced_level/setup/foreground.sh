#!/bin/bash

cd advanced_level
echo setting up snapd
while [ ! -f /tmp/background0 ]; do sleep 1; done

snap install rockcraft --classic
lxd init --auto

alias skopeo-copy='function _skopeo_copy() { \
    short_name=$(echo $1 | cut -d '_' -f1); \
    short_version=$(echo $1 | cut -d '_' -f2); \
    sudo rockcraft.skopeo --insecure-policy copy oci-archive:$1 docker-daemon:$short_name:$short_version \
}; _skopeo_copy'
