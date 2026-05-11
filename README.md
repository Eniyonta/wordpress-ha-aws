# ZSoftly Highly Available WordPress on AWS

## Project Overview

This project deploys a **Highly Available WordPress application on AWS** using Infrastructure as Code (Terraform), Docker, and CI/CD automation. The architecture is designed for scalability, fault tolerance, security, and automated backups.

It includes:

* Multi-AZ deployment
* Auto Scaling group for EC2 instances
* Application Load Balancer
* RDS MySQL database
* Shared storage (EFS)
* Nginx reverse proxy
* SSL encryption (Let’s Encrypt)
* CI/CD pipeline using GitHub Actions
* Monitoring using CloudWatch

---

##  Architecture Overview

### Core Flow

User → Load Balancer → EC2 (Auto Scaling Group) → Nginx → WordPress → RDS MySQL

### AWS Components

* VPC with public & private subnets
* Application Load Balancer (ALB)
* EC2 Auto Scaling Group
* RDS MySQL (Multi-AZ)
* EFS for shared WordPress files
* S3 for backups
* CloudWatch for monitoring
* Route 53 (optional domain mapping)

---

## Tech Stack

* AWS (EC2, RDS, ALB, VPC, EFS, S3)
* Terraform (Infrastructure as Code)
* Docker (containerized WordPress setup)
* Nginx (reverse proxy)
* MySQL (database backend)
* GitHub Actions (CI/CD)
* Bash scripting (automation)

---

## Deployment Steps

### 1. Clone Repository

```bash
git clone <repo-url>
cd project-root
```

### 2. Initialize Terraform

```bash
cd terraform
terraform init
```

### 3. Deploy Infrastructure

```bash
terraform plan
terraform apply -auto-approve
```

---

## Docker Setup (Local Testing)

```bash
docker-compose up -d
```

Access locally:

```
http://wordpress-ha-alb-931749903.us-east-1.elb.amazonaws.com
```

---

## SSL Configuration

* SSL certificates generated using Let’s Encrypt
* Auto-renewal via cron job
* HTTPS enforced through Nginx

---

##  CI/CD Pipeline

GitHub Actions automatically:

* Deploy WordPress themes/plugins
* Run health checks
* Trigger rollback if deployment fails

---

##  Backup Strategy

* Daily WordPress backup to S3
* Daily MySQL database dump
* Retention: last 30 days
* Automated via cron jobs

---

## Monitoring & Logging

* CloudWatch logs for EC2 instances
* CPU, memory, and disk metrics
* Alerts for:

  * High CPU usage
  * Instance failure
  * Load balancer health issues

---

## Security Implementation

* Private subnets for EC2 instances
* Least privilege IAM roles
* Security groups restricting access
* WordPress hardening (wp-config, file permissions)
* HTTPS enforced via SSL

---

##  High Availability Features

* Multi-AZ deployment
* Auto Scaling Group (min 2 instances)
* Load Balancer health checks
* RDS Multi-AZ failover
* Shared EFS storage

---

##  Testing

### Load Testing

Simulated concurrent users to validate scaling

### Failover Testing

Stopped EC2 instance to verify ALB rerouting

### Backup Testing

Restored database and files from S3 backups

### SSL Testing

Verified HTTPS and certificate validity

---

## Cost Optimization

* Small/medium EC2 instances for dev
* S3 lifecycle policies enabled
* Auto Scaling to reduce idle resources

---

## Troubleshooting

### WordPress not loading

* Check ALB target health
* Verify EC2 instance status

### Database connection error

* Validate RDS endpoint in wp-config.php

### 502 Bad Gateway

* Nginx not running or wrong upstream config

---

##  Screenshots Required

* WordPress homepage
* wp-admin dashboard
* ALB target group health
* CloudWatch monitoring dashboard
* Successful backup logs

---

##  Future Improvements

* CloudFront CDN integration
* Multi-region deployment
* Blue/Green deployment strategy
* Infrastructure testing with Terratest

---

## 👨‍ Author

Sylvia: ZSoftly Capstone Project part 3 – Highly Available WordPress on AWS
