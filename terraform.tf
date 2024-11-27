terraform {
  cloud {

    organization = "ZeroCloud"

    workspaces {
      name = "Deploying-RESTful-APIs-using-Terraform"
    }
  }

  # required_providers {
  #   aws = {
  #     source  = "hashicorp/aws"
  #     version = "~> 5.42.0"
  #   }
  # }

  #   required_version = "~> 1.2"
}
