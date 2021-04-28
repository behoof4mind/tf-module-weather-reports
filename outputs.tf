output "hourly_endpoint" {
  description = "Endpoint for hourly S3 bucket"
  value       = aws_s3_access_point.weather-reports-hourly.domain_name
}

output "daily_endpoint" {
  description = "Endpoint for daily S3 bucket"
  value       = aws_s3_access_point.weather-reports-daily.domain_name
}

output "weekly_endpoint" {
  description = "Endpoint for weekly S3 bucket"
  value       = aws_s3_access_point.weather-reports-weekly.domain_name
}
