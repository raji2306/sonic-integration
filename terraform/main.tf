# Get default VPC
data "aws_vpc" "default" {
  default = true
}

# Get default subnets in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Lookup existing security group (if already created manually)
data "aws_security_group" "rds_sg" {
  filter {
    name   = "group-name"
    values = ["rds-public-sg"]
  }
  vpc_id = data.aws_vpc.default.id
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

# Lookup existing DB subnet group (if already exists in AWS)
data "aws_db_subnet_group" "default" {
  name = "default-subnet-group"
}

# RDS Instance
resource "aws_db_instance" "test" {
  identifier              = "devops"           # DB instance identifier
  db_name                 = "devops"           # Initial database name
  allocated_storage       = 20
  max_allocated_storage   = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"

  username                = var.db_username
  password                = var.db_password

  db_subnet_group_name    = data.aws_db_subnet_group.default.name
  vpc_security_group_ids  = [data.aws_security_group.rds_sg.id]
  publicly_accessible     = true

  skip_final_snapshot     = true
  deletion_protection     = false
  multi_az                = false
  apply_immediately       = true
  backup_retention_period = 0
}
