#!/bin/bash
yum update -y
yum install -y docker amazon-efs-utils amazon-cloudwatch-agent

# Start Docker
systemctl start docker
systemctl enable docker

# Mount EFS
mkdir -p /var/www/html
mount -t efs ${efs_id}:/ /var/www/html
echo "${efs_id}:/ /var/www/html efs defaults,_netdev 0 0" >> /etc/fstab

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Create WordPress docker-compose
mkdir -p /opt/wordpress
cat > /opt/wordpress/docker-compose.yml <<EOF
version: '3.8'
services:
  wordpress:
    image: wordpress:latest
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: ${db_host}
      WORDPRESS_DB_USER: ${db_user}
      WORDPRESS_DB_PASSWORD: ${db_password}
      WORDPRESS_DB_NAME: ${db_name}
    volumes:
      - /var/www/html:/var/www/html
    restart: always

  nginx:
    image: nginx:alpine
    ports:
      - "8080:80"
    volumes:
      - /opt/wordpress/nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - wordpress
    restart: always
EOF

# Start WordPress
cd /opt/wordpress
docker-compose up -d

# Install CloudWatch Agent
yum install -y amazon-cloudwatch-agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
  -a fetch-config -m ec2 -s

# Setup backup cron job
echo "0 2 * * * /opt/scripts/backup.sh" | crontab -
