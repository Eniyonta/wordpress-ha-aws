provider "aws" {
  region = var.aws_region
}

# S3 bucket for backups
resource "aws_s3_bucket" "backups" {
  bucket = "${var.project_name}-backups-${random_id.suffix.hex}"
  tags   = { Name = "${var.project_name}-backups" }
}

resource "aws_s3_bucket_lifecycle_configuration" "backups" {
  bucket = aws_s3_bucket.backups.id
  rule {
    id     = "delete-old-backups"
    status = "Enabled"
    expiration {
      days = 30
    }
    filter {}
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

# EFS for shared WordPress content
resource "aws_efs_file_system" "wordpress" {
  creation_token = "${var.project_name}-efs"
  tags           = { Name = "${var.project_name}-efs" }
}

resource "aws_efs_mount_target" "private_a" {
  file_system_id  = aws_efs_file_system.wordpress.id
  subnet_id       = aws_subnet.private_a.id
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_mount_target" "private_b" {
  file_system_id  = aws_efs_file_system.wordpress.id
  subnet_id       = aws_subnet.private_b.id
  security_groups = [aws_security_group.efs_sg.id]
}
