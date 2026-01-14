################################
# Providers
################################
provider "aws" {
  region = "ap-northeast-2"
}

################################
# VPC
################################
module "vpc" {
  source = "../../modules/vpc"

  name     = "sentistock"
  vpc_cidr = "10.0.0.0/16"
  azs      = ["ap-northeast-2a", "ap-northeast-2c"]

  public_subnet_cidrs      = ["10.0.0.0/24", "10.0.1.0/24"]
  private_app_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
  private_db_subnet_cidrs  = ["10.0.20.0/24", "10.0.21.0/24"]

  eks_cluster_name = "sentistock-eks"

  tags = {
    Project   = "sentistock"
    Env       = "prod"
    ManagedBy = "Terraform"
  }
}

################################
# EKS
################################
module "eks" {
  source = "../../modules/eks"

  name   = "sentistock"
  region = "ap-northeast-2"

  vpc_id                 = module.vpc.vpc_id
  private_app_subnet_ids = module.vpc.private_app_subnet_ids
  public_subnet_ids      = module.vpc.public_subnet_ids

  nat_gateway_id         = module.vpc.nat_gateway_id
  private_route_table_id = module.vpc.private_route_table_id

  tags = {
    Project   = "sentistock"
    Env       = "prod"
    ManagedBy = "Terraform"
  }
}

################################
# RDS
################################
module "rds" {
  source = "../../modules/rds"

  name = "sentistock"
  tags = {
    Project   = "sentistock"
    Env       = "prod"
    ManagedBy = "Terraform"
  }

  vpc_id        = module.vpc.vpc_id
  db_subnet_ids = module.vpc.private_db_subnet_ids

  allowed_sg_ids = [module.eks.node_security_group_id]

  engine            = var.db_engine
  engine_version    = var.db_engine_version
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  parameter_group_family = "mariadb10.11"
  db_name  = var.db_name
  username = var.db_username
  password = var.db_password
}

################################
# EKS Auth
################################
data "aws_eks_cluster" "this" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "this" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.this.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.this.token
}

################################
# ALB Controller
################################
resource "kubernetes_service_account_v1" "alb_controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = module.eks.alb_controller_role_arn
    }
  }

  depends_on = [module.eks]
}

provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.this.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.this.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

resource "helm_release" "aws_load_balancer_controller" {
  name       = "aws-load-balancer-controller"
  namespace  = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  disable_openapi_validation = true
  wait    = true
  timeout = 900

  set = [
    { name = "clusterName", value = module.eks.cluster_name },
    { name = "region", value = "ap-northeast-2" },
    { name = "serviceAccount.create", value = "false" },
    { name = "serviceAccount.name", value = "aws-load-balancer-controller" },
    { name = "vpcId", value = module.vpc.vpc_id },
    { name = "awsRegion", value = "ap-northeast-2" }
  ]

  depends_on = [
    module.eks,
    kubernetes_service_account_v1.alb_controller
  ]
}

################################
# Route53 Hosted Zone (ZONE ONLY)
################################
module "route53" {
  source = "../../modules/route53"

  root_domain     = var.root_domain
  frontend_domain = var.frontend_domain

  cf_domain_name = module.frontend_static.cloudfront_domain_name
  cf_zone_id     = module.frontend_static.cloudfront_hosted_zone_id

  tags = var.tags
}


################################
# Frontend Static (S3 + CloudFront + ACM)
################################
module "frontend_static" {
  source = "../../modules/frontend_static"

  providers = {
    aws      = aws
    aws.use1 = aws.use1
  }

  name            = var.name
  tags            = var.tags
  frontend_domain = var.frontend_domain
  hosted_zone_id  = module.route53.zone_id
  root_domain     = var.root_domain
}


