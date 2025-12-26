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
