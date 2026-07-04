#!/bin/bash
set -eux

echo "CloudShield Bootstrap Started "

apt-get update -y

apt-get install -y \
curl \
wget \
git \
unzip \
ca-certificates

echo "Creating 2GB swap..."

fallocate -l 2G /swapfile

chmod 600 /swapfile

mkswap /swapfile

swapon /swapfile

echo "/swapfile none swap sw 0 0" >> /etc/fstab

echo "Swap created successfully"

echo "Installing k3s..."

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --disable traefik --disable servicelb" sh -

echo "Waiting for k3s..."

until systemctl is-active --quiet k3s
do
    sleep 5
done

echo "CloudShield Bootstrap Complete"