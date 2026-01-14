variable "region" { type = string }

variable "db_engine" { type = string }
variable "db_engine_version" { type = string }
variable "db_instance_class" { type = string }
variable "db_allocated_storage" { type = number }
variable "db_name" { type = string }
variable "db_username" { type = string }
variable "db_password" { type = string }
variable "name" {
  type = string
}
variable "root_domain" { type = string }
variable "frontend_domain" { type = string }
variable "tags" {
  type = map(string)
}
