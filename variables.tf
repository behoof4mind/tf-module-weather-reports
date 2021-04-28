variable "region" {
  default = "us-east-2"
}

variable "bucket_name_prefix" {
  description = "Your S3 bucket name prefix"
  default     = "crazy-berlin-weather"
}

variable "s3_acl_type" {
  description = "Your S3 ACL"
  default     = "private"
}

variable "origin_website" {
  description = "Your domain name"
  default     = "https://weather-service.com"
}

variable "hourly" {
  type = map(any)

  default = {
    suffix            = "daily"
    acl_type          = "private"
    expiration        = 90
    transition_1_sc   = "STANDARD_IA"
    transition_1_days = 30
    transition_2_sc   = "GLACIER"
    transition_2_days = 30
  }
}

variable "daily" {
  type = map(any)

  default = {
    suffix            = "daily"
    acl_type          = "private"
    expiration        = 180
    transition_1_sc   = "STANDARD_IA"
    transition_1_days = 30
    transition_2_sc   = "GLACIER"
    transition_2_days = 30
  }
}

variable "weekly" {
  type = map(any)

  default = {
    suffix            = "daily"
    acl_type          = "private"
    expiration        = 360
    transition_1_sc   = "STANDARD_IA"
    transition_1_days = 30
    transition_2_sc   = "GLACIER"
    transition_2_days = 30
  }
}