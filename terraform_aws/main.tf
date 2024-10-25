terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    config = {
      source  = "alabuel/config"
      version = "0.2.8"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  shared_config_files      = ["/Users/asoham/.aws/config"]
  shared_credentials_files = ["/Users/asoham/.aws/credentials"]
  profile                  = "226279088210"
  region = "us-east-2"
}


module "uag_aws_apac_dca" {
  source    = "./uag_aws_module"
  uag_name  = "uag_apac_dca"
  uag_count = 2
  iniFile   = "uag.ini"
  inputs    = var.sensitive_input
}