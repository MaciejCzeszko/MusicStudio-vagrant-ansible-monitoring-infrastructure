#!/usr/bin/env bash
set -e

# Install ansible
apt-get update -y
apt-get install -y ansible

# Generate SSH keypair for vagrant user if not already generated
SSH_DIR="/home/vagrant/.ssh/"
mkdir -p "$SSH_DIR"
if [ ! -f "$SSH_DIR/id_rsa" ]; then
  sudo -u vagrant ssh-keygen -t rsa -N "" -f "$SSH_DIR/id_rsa"
fi
chown -R vagrant:vagrant "$SSH_DIR"
chmod 700 "$SSH_DIR"

# Copy public key to shared folder so other vms can access it
cp "$SSH_DIR/id_rsa.pub" /vagrant/id_rsa.pub

# Skip host key confirmation prompts
cat <<EOF > "$SSH_DIR/config"
Host 192.168.56.*
  StrictHostKeyChecking no
  UserKnownHostsFile /dev/null
EOF
chown vagrant:vagrant "$SSH_DIR/config"
chmod 600 "$SSH_DIR/config"

# Ansible inventory
mkdir -p /home/vagrant/ansible
cat <<EOF > /home/vagrant/ansible/hosts
[frontend]
frontend ansible_host=192.168.56.101

[backend]
backend ansible_host=192.168.56.102

[database]
database ansible_host=192.168.56.103

[all:vars]
ansible_user=vagrant
ansible_ssh_private_key_file=/home/vagrant/.ssh/id_rsa
EOF

echo "Control provisioning done. Ansible installed, SSH key generated"