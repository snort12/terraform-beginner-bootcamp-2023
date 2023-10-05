output "bucket_name_masuria" {
  description = "Bucket name for our static website hosting"
  value       = module.home_masuria_hosting.bucket_name
}

output "s3_website_endpoint_masuria" {
  description = "S3 Static Website hosting endpoint"
  value       = module.home_masuria_hosting.website_endpoint
}

output "cloudfront_url_masuria" {
  description = "Cloud Front url"
  value       = module.home_masuria_hosting.cloudfront_url
}

output "bucket_name_heroes" {
  description = "Bucket name for our static website hosting"
  value       = module.home_heroes_hosting.bucket_name
}

output "s3_website_endpoint_heroes" {
  description = "S3 Static Website hosting endpoint"
  value       = module.home_heroes_hosting.website_endpoint
}

output "cloudfront_url_heroes" {
  description = "Cloud Front url"
  value       = module.home_heroes_hosting.cloudfront_url
}