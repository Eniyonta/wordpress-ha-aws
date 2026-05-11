#!/bin/bash
# Instance bootstrap script

yum update -y
yum install -y docker amazon-efs-utils

systemctl start docker
systemctl enable docker

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "Bootstrap complete"
