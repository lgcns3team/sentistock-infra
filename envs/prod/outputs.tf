output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
}

output "frontend_bucket_name" {
  value = module.frontend_static.bucket_name
}

output "cloudfront_domain_name" {
  value = module.frontend_static.cloudfront_domain_name
}
