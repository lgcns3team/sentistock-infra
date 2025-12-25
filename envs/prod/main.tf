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
    Env       = "prod"
    ManagedBy = "Terraform"
  }
}

module "eks" {
  source = "../../modules/eks"

  name   = "sentistock"
  region = "ap-northeast-2"

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_app_subnet_ids

  tags = {
    Project   = "sentistock"
    Env       = "prod"
    ManagedBy = "Terraform"
  }
}
