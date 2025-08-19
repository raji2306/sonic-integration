provider "aws" {
  region = "us-east-1" # change if needed
}

# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Security group to allow public access
resource "aws_security_group" "rds_sg" {
  name        = "rds-public-sg"
  description = "Allow public access to RDS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open to all (use carefully!)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Subnet group (use default subnets)
resource "aws_db_subnet_group" "default" {
  name       = "default-subnet-group"
  subnet_ids = data.aws_subnets.default.ids
}

# RDS Instance
resource "aws_db_instance" "test" {
  identifier              = "test-rds-db"
  allocated_storage       = 20
  max_allocated_storage   = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"

  username                = var.db_username
  password                = var.db_password

  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  publicly_accessible     = true

  skip_final_snapshot     = true
  deletion_protection     = false
  multi_az                = false
  availability_zone       = "us-east-1a"
  apply_immediately       = true
  backup_retention_period = 0
}
