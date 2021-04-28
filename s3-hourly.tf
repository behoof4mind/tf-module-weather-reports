resource "aws_s3_bucket" "weather-reports-hourly" {
  bucket = "${var.bucket_name_prefix}-${var.hourly.suffix}"
  acl    = var.hourly.acl_type

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
    id = var.hourly.suffix
    enabled = true

    prefix = "${var.hourly.suffix}/"

    tags = {
      rule = var.hourly.suffix
    }
    transition {
      days          = var.hourly.transition_1_days
      storage_class = var.hourly.transition_1_sc
    }

    transition {
      days          = var.hourly.transition_2_days
      storage_class = var.hourly.transition_2_sc
    }

    expiration {
      days = var.hourly.expiration
    }
  }
}

resource "aws_s3_access_point" "weather-reports-hourly" {
  bucket = aws_s3_bucket.weather-reports-hourly.id
  name   = "${var.bucket_name_prefix}-${var.hourly.suffix}"
  vpc_configuration {
    vpc_id = aws_vpc.weather-reports.id
  }
}