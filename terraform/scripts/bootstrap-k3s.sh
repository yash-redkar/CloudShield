#!/bin/bash
set -eux

echo "CloudShield Bootstrap Started"

apt-get update -y

apt-get install -y curl wget git unzip ca-certificates

# Create 2GB swap if it does not exist
if [ ! -f /swapfile ]; then
  fallocate -l 2G /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo "/swapfile none swap sw 0 0" >> /etc/fstab
fi

echo "Installing k3s with Traefik enabled..."

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server" sh -

echo "Waiting for k3s..."

until systemctl is-active --quiet k3s
do
  sleep 5
done

echo "CloudShield Bootstrap Complete"