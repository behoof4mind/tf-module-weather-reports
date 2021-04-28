# Terraform module for crazy-berlin-weather service
This module can be used to prepare AWS S3 solution for **crazy-berlin-weather** service. Was developed as test exercise.

## How to use
#### Add environment variables
Bash example:
```shell
AWS_DEFAULT_REGION="<YOUR APP REGION>"
AWS_ACCESS_KEY_ID="<YOUR AWS_ACCESS_KEY_ID>"
AWS_SECRET_ACCESS_KEY="<YOUR AWS_SECRET_ACCESS_KEY>"
```
Fish example:
```shell
set -Ux AWS_DEFAULT_REGION <YOUR APP REGION>
set -Ux AWS_ACCESS_KEY_ID <YOUR AWS_ACCESS_KEY_ID>
set -Ux AWS_SECRET_ACCESS_KEY <YOUR AWS_SECRET_ACCESS_KEY>
```

Create main.tf file with:
```terraform
module "weather_reports" {
  source              = "github.com/behoof4mind/tf-module-weather-reports?ref=0.0.2"
  bucket_name_prefix  = "crazy-berlin-weather"
  s3_acl_type         = "private"
  origin_website      = "https://weather-service.com"

  hourly = {
    suffix            = "hourly"
    acl_type          = "private"
    expiration        = 90
    transition_1_sc   = "STANDARD_IA"
    transition_1_days = 30
    transition_2_sc   = "GLACIER"
    transition_2_days = 60
  }

  daily = {
    suffix            = "daily"
    acl_type          = "private"
    expiration        = 180
    transition_1_sc   = "STANDARD_IA"
    transition_1_days = 30
    transition_2_sc   = "GLACIER"
    transition_2_days = 60
  }

  weekly = {
    suffix            = "weekly"
    acl_type          = "private"
    expiration        = 360
    transition_1_sc   = "STANDARD_IA"
    transition_1_days = 30
    transition_2_sc   = "GLACIER"
    transition_2_days = 60
  }
}

output "weekly_endpoint" {
  description = "Endpoint for weekly S3 bucket"
  value       = module.weather_reports.weekly_endpoint
}

output "daily_endpoint" {
  description = "Endpoint for daily S3 bucket"
  value       = module.weather_reports.daily_endpoint
}

output "hourly_endpoint" {
  description = "Endpoint for hourly S3 bucket"
  value       = module.weather_reports.hourly_endpoint
}
```
_- these variables in example are default, if you don't want to override them - only source line should be specified;_<br>
_- dont forget to use latest varion of module in ref=0.0.2 notation_
Make init
```shell
terraform init
```

Apply changes
```shell
terraform apply
```

## Contributing

Thanks for considering contributing! There’s information about how to [get started with tf-module-weather-reports module](CONTRIBUTE.md)

## License

[The MIT License (MIT)](LICENSE.md)

Copyright © 2021 [Denis Lavrushko](https://dlavrushko.de)