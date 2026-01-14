variable "name" { type = string }
variable "tags" { type = map(string) }

variable "vpc_id" { type = string }
variable "db_subnet_ids" { type = list(string) }
variable "allowed_sg_ids" { type = list(string) }

variable "engine" { type = string }          # mariadb or mysql
variable "engine_version" { type = string }
variable "instance_class" { type = string }
variable "allocated_storage" { type = number }

variable "db_name" { type = string }
variable "username" { type = string }
variable "password" { type = string }

variable "parameter_group_family" {
  description = "RDS parameter group family (e.g. mariadb10.6, mysql8.0)"
  type        = string
}
variable "storage_type" {
  description = "RDS storage type (gp2, gp3, io1, io2)"
  type        = string
  default     = "gp3"
}

variable "port" {
  description = "Database port"
  type        = number
  default     = 3306
}

variable "multi_az" {
  description = "Whether to enable Multi-AZ"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on deletion"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Apply changes immediately"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  description = "Backup retention days"
  type        = number
  default     = 7
}

variable "enabled_cloudwatch_logs_exports" {
  description = "CloudWatch logs exports list"
  type        = list(string)
  default     = []
}
