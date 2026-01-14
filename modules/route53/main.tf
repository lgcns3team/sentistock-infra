resource "aws_route53_zone" "this" {
  name = var.root_domain
  tags = var.tags
}
