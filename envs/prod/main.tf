provider "aws" {
  region = "ap-northeast-2"
}

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

module "eks" {
  source = "../../modules/eks"

  name   = "sentistock"
  region = "ap-northeast-2"

  vpc_id                 = module.vpc.vpc_id
  private_app_subnet_ids = module.vpc.private_app_subnet_ids
  public_subnet_ids      = module.vpc.public_subnet_ids

  nat_gateway_id          = module.vpc.nat_gateway_id
  private_route_table_id  = module.vpc.private_route_table_id
  
  tags = {
    Project   = "sentistock"
    Env       = "prod"
    ManagedBy = "Terraform"
  }
}




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

  wait    = true
  timeout = 900
  set = [
    {
      name  = "clusterName"
      value = module.eks.cluster_name
    },
    {
      name  = "region"
      value = "ap-northeast-2"
    },
    {
      name  = "serviceAccount.create"
      value = "false"
    },
    {
      name  = "serviceAccount.name"
      value = "aws-load-balancer-controller"
    },
    {
      name  = "vpcId"
      value = module.vpc.vpc_id
    },
    {
      name  = "awsRegion"
      value = "ap-northeast-2"
    },
  ]

  depends_on = [
      module.eks,
      kubernetes_service_account_v1.alb_controller
  ]

}
