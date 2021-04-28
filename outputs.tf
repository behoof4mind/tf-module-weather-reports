output "hourly_endpoint" {
  description = "Endpoint for hourly S3 bucket"
  value       = aws_s3_bucket.weather-reports-hourly.bucket_domain_name
}

output "daily_endpoint" {
  description = "Endpoint for daily S3 bucket"
  value       = aws_s3_bucket.weather-reports-daily.bucket_domain_name
}

output "weekly_endpoint" {
  description = "Endpoint for weekly S3 bucket"
  value       = aws_s3_bucket.weather-reports-weekly.bucket_domain_name
}
