variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "wordpress-ha"
}

variable "db_password" {
  description = "RDS MySQL password"
  type        = string
  sensitive   = true
}

variable "db_username" {
  default = "wordpress"
}

variable "db_name" {
  default = "wordpressdb"
}
