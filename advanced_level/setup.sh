cd advanced_level
apt update
DEBIAN_FRONTEND=noninteractive apt install -y snapd || true
# Ignore errors here because snapd may fail to start services properly

# Wait for snapd.socket to be ready or skip installing rockcraft snap if not critical
sleep 5

snap install rockcraft --classic || echo "snap install failed, skipping"

lxd init --auto || echo "lxd init failed, skipping"
