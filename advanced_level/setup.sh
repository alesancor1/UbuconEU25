echo "Setting up the scenario..."
echo "Installing snapd..."

apt update
apt install snapd

clear

echo "Setting up the scenario..."
echo "Installing rockcraft snap..."
snap install rockcraft --classic

clear

echo "Seting up lxd..."
lxd init --auto

echo "Done!"

sleep 3

clear