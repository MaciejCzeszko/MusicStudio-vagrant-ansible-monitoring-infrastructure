#!/usr/bin/env bash
set -e

SSH_DIR="/home/vagrant/.ssh"
mkdir -p "$SSH_DIR"
touch "$SSH_DIR/authorized_keys"

if [ -f /vagrant/id_rsa.pub ]; then
  cat /vagrant/id_rsa.pub >> "$SSH_DIR/authorized_keys"
  sort -u -o "$SSH_DIR/authorized_keys" "$SSH_DIR/authorized_keys"
else
  echo "WARNING: id_rsa.pub not found. Run 'vagrant provision $VM_NAME' after control vm is up."
fi

chown -R vagrant:vagrant "$SSH_DIR"
chmod 700 "$SSH_DIR"
chmod 600 "$SSH_DIR/authorized_keys"

echo "$VM_NAME provisioning done."