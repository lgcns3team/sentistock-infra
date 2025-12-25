provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source = "../../modules/vpc"

  name      = "sentistock"
  vpc_cidr  = "10.0.0.0/16"
  azs       = ["ap-northeast-2a", "ap-northeast-2c"]

  public_subnet_cidrs      = ["10.0.0.0/24",  "10.0.1.0/24"]
  private_app_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  private_db_subnet_cidrs  = ["10.0.20.0/24", "10.0.21.0/24"]

  tags = {
    Project   = "sentistock"
    ManagedBy = "Terraform"
    Env       = "prod"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
}
