#!/bin/bash

# Configuration
S3_BUCKET="${s3_bucket}"
AWS_REGION="${aws_region}"
DATE=$(date +%Y-%m-%d-%H-%M)
BACKUP_DIR="/tmp/wordpress-backup-$DATE"

echo "Starting WordPress backup at $DATE"

# Create backup directory
mkdir -p $BACKUP_DIR

# Backup WordPress files
echo "Backing up WordPress files..."
tar -czf $BACKUP_DIR/wordpress-files-$DATE.tar.gz /var/www/html

# Backup database
echo "Backing up database..."
docker exec mysql mysqldump \
  -u wordpress \
  -pwordpress123 \
  wordpressdb > $BACKUP_DIR/database-$DATE.sql

# Upload to S3
echo "Uploading to S3..."
aws s3 cp $BACKUP_DIR/ \
  s3://$S3_BUCKET/backups/$DATE/ \
  --recursive \
  --region $AWS_REGION

# Cleanup local backup
rm -rf $BACKUP_DIR

echo "Backup completed successfully at $(date)"
