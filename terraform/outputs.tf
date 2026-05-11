output "alb_dns_name" {
  value = "http://${aws_lb.main.dns_name}"
  description = "WordPress site URL"
}

output "rds_endpoint" {
  value = aws_db_instance.wordpress.address
  description = "RDS endpoint"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.backups.bucket
  description = "S3 backup bucket name"
}

output "efs_id" {
  value = aws_efs_file_system.wordpress.id
  description = "EFS file system ID"
}
