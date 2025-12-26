output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}

output "bucket_name" {
  value = aws_s3_bucket.site.bucket
}

output "cloudfront_hosted_zone_id" {
  value = aws_cloudfront_distribution.cdn.hosted_zone_id
}
