variable "db_username" {
  description = "RDS username"
  type        = string
  default = "admin"
}

variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "aws_region" {
  description = "AWS region where RDS will be created"
  type        = string
  default     = "ap-south-1"
}
