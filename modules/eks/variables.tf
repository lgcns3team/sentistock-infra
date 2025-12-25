variable "name" { type = string }
variable "region" { type = string }

variable "vpc_id" { type = string }

# EKS control plane / nodegroup 둘 다 들어갈 private app subnet 2개 추천
variable "private_subnet_ids" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}
