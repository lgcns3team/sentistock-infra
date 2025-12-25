variable "name" { type = string }
variable "region" { type = string }

variable "vpc_id" { type = string }

variable "private_app_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "nat_gateway_id" {
  type        = string
  description = "Dependency-only: NAT gateway id from VPC module"
  default     = null
}

variable "private_route_table_id" {
  type        = string
  description = "Dependency-only: Private route table id from VPC module"
  default     = null
}
