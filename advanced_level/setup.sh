cd advanced_level

echo installing snapd...
apt update && apt install -y snapd &
echo $! > /tmp/snapd-install.pid

PID=$(cat "$PID_FILE")
while kill -0 "$PID" 2>/dev/null; do
    sleep 1
done

snap install rockcraft classic
lxd init --auto
