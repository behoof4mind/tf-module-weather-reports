
provider "aws" {
  region = var.region
}

resource "aws_vpc" "weather-reports" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Service = var.bucket_name_prefix
  }
}
