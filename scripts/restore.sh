#!/bin/bash

# Usage: ./restore.sh 2026-05-11-02-00
BACKUP_DATE=$1
S3_BUCKET="YOUR_BUCKET_NAME"
AWS_REGION="us-east-1"

if [ -z "$BACKUP_DATE" ]; then
  echo "Usage: ./restore.sh YYYY-MM-DD-HH-MM"
  exit 1
fi

echo "Restoring backup from $BACKUP_DATE"

# Download from S3
aws s3 cp s3://$S3_BUCKET/backups/$BACKUP_DATE/ \
  /tmp/restore/ \
  --recursive \
  --region $AWS_REGION

# Restore files
tar -xzf /tmp/restore/wordpress-files-$BACKUP_DATE.tar.gz -C /

# Restore database
docker exec -i mysql mysql \
  -u wordpress \
  -pwordpress123 \
  wordpressdb < /tmp/restore/database-$BACKUP_DATE.sql

echo "Restore completed successfully"
