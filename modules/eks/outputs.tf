output "cluster_name" { value = aws_eks_cluster.this.name }
output "cluster_endpoint" { value = aws_eks_cluster.this.endpoint }
output "cluster_ca" { value = aws_eks_cluster.this.certificate_authority[0].data }

output "node_role_arn" { value = aws_iam_role.eks_node_role.arn }
output "alb_controller_role_arn" { value = aws_iam_role.alb_controller_role.arn }
output "oidc_provider_arn" { value = aws_iam_openid_connect_provider.this.arn }
