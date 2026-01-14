variable "name" { type = string }
variable "tags" { type = map(string) }

# (선택) 버킷명 커스터마이즈 하고 싶으면
variable "bucket_name" {
  type    = string
  default = null
}

variable "frontend_domain" { type = string }
variable "root_domain" { type = string }      
variable "hosted_zone_id" { type = string }   