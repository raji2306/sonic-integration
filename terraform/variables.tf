variable "db_username" {
  description = "RDS username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS password"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "devops"
}

variable "db_identifier" {
  description = "DB instance identifier"
  type        = string
  default     = "devops"
}

variable "aws_region" {
  description = "AWS region where RDS will be created"
  type        = string
  default     = "ap-south-1"
}
