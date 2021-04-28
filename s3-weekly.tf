resource "aws_s3_bucket" "weather-reports-weekly" {
  bucket = "${var.bucket_name_prefix}-${var.weekly.suffix}"
  acl    = var.weekly.acl_type

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
    id = var.weekly.suffix
    enabled = true

    prefix = "${var.weekly.suffix}/"

    tags = {
      rule = var.weekly.suffix
    }
    transition {
      days          = var.weekly.transition_1_days
      storage_class = var.weekly.transition_1_sc
    }

    transition {
      days          = var.weekly.transition_2_days
      storage_class = var.weekly.transition_2_sc
    }

    expiration {
      days = var.weekly.expiration
    }
  }
}

resource "aws_s3_access_point" "weather-reports-weekly" {
  bucket = aws_s3_bucket.weather-reports-weekly.id
  name   = "${var.bucket_name_prefix}-${var.weekly.suffix}"
  vpc_configuration {
    vpc_id = aws_vpc.weather-reports.id
  }
}