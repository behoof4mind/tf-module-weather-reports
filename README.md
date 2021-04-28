# Terraform module for crazy-berlin-weather service
This module can be used to prepare AWS S3 solution for **crazy-berlin-weather** service. Was developed as test exercise for [**weather-reports-service**](https://github.com/behoof4mind/weather-reports-service) project

## How to use locally
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

Create main.tf file
```terraform
module "webserver_cluster" {
  source              = "github.com/behoof4mind/tf-module-weather-reports?ref=0.0.1"
  region              = "us-east-2"
  bucket_name_prefix  = "crazy-berlin-weather"
  s3_acl_type         = "private"
  origin_website      = "https://weather-service.com",
  
  hourly {
    suffix            = "daily"
    acl_type          = "private"
    expiration        = 90
    transition_1_sc   = "STANDARD_IA"
    transition_1_days = 30
    transition_2_sc   = "GLACIER"
    transition_2_days = 30
  }

  daily {
    suffix            = "daily"
    acl_type          = "private"
    expiration        = 180
    transition_1_sc   = "STANDARD_IA"
    transition_1_days = 30
    transition_2_sc   = "GLACIER"
    transition_2_days = 30
  }

  weekly {
    suffix            = "daily"
    acl_type          = "private"
    expiration        = 360
    transition_1_sc   = "STANDARD_IA"
    transition_1_days = 30
    transition_2_sc   = "GLACIER"
    transition_2_days = 30
  }
}
```
_- these variables in example are default, if you don't want to override them - only source line should be specified;_<br>
_- dont forget to use latest varion of module in ref=0.0.1 notation_
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