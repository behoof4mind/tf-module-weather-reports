
provider "aws" {
  region = var.region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.66.0"

  name                 = "${var.bucket_name_prefix}-vpc"

  tags = {
    Service     = var.bucket_name_prefix
  }
}