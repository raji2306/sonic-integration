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

variable "db_identifier" {
  description = "DB instance identifier"
  type        = string
  default     = "devops"
}

variable "db_name" {
  description = "Initial database name"
  type        = string
  default     = "devops"
}

variable "db_instance_class" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "db_engine" {
  description = "RDS engine type"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "RDS engine version"
  type        = string
  default     = "8.0"
}

variable "db_allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_max_allocated_storage" {
  description = "Max allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_storage_type" {
  description = "Storage type for RDS"
  type        = string
  default     = "gp2"
}

variable "db_publicly_accessible" {
  description = "Whether RDS is publicly accessible"
  type        = bool
  default     = true
}

variable "db_multi_az" {
  description = "Whether to deploy multi-AZ RDS"
  type        = bool
  default     = false
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot on deletion"
  type        = bool
  default     = true
}

variable "db_deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "db_backup_retention" {
  description = "Backup retention period in days"
  type        = number
  default     = 0
}

variable "aws_region" {
  description = "AWS region where RDS will be created"
  type        = string
  default     = "ap-south-1"
}
