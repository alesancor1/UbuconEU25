#!/bin/bash

PID_FILE="/tmp/snapd-install.pid"

cd advanced_level

echo installing snapd...
apt update 
apt install -y snapd &
echo $! > $PID_FILE
