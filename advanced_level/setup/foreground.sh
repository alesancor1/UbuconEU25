#!/bin/bash

cd advanced_level
echo setting up snapd
while [ ! -f /tmp/background0 ]; do sleep 1; done

snap install rockcraft --classic
lxd init --auto
