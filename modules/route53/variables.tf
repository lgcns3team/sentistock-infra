variable "root_domain" { type = string }
variable "frontend_domain" { type = string }

variable "cf_domain_name" { type = string }
variable "cf_zone_id" { type = string }

variable "tags" { type = map(string) }
