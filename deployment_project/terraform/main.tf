provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = var.terraform_bucket_name
    key    = "terraform/state"
    region = var.region
  }
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.eks_cluster_name
  cluster_version = "1.21"

  node_groups = {
    eks_nodes = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1

      instance_type = "t3.medium"
    }
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids
}

resource "aws_rds_instance" "mysql_db" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql8.0"
  publicly_accessible  = false
  vpc_security_group_ids = [var.vpc_security_group_id]
  db_subnet_group_name   = var.db_subnet_group
}

resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "redis-cluster"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  port                 = 6379
  subnet_group_name    = var.elasticache_subnet_group
}

resource "aws_ses_domain_identity" "identity" {
  domain = var.ses_domain
}
        