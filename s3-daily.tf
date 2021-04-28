resource "aws_s3_bucket" "weather-reports-daily" {
  bucket = "{var.bucket_name_prefix}-{var.daily.suffix}"
  acl    = var.daily.acl_type

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "GET"]
    allowed_origins = [var.origin_website]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.weather-service.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  lifecycle_rule {
    id      = var.daily.suffix
    enabled = true

    prefix = "{var.daily.suffix}/"

    tags = {
      rule = var.daily.suffix
    }
    transition {
      days          = var.daily.transition_1_days
      storage_class = var.daily.transition_1_sc
    }

    transition {
      days          = var.daily.transition_2_days
      storage_class = var.daily.transition_2_sc
    }

    expiration {
      days = var.daily.expiration
    }
  }
}