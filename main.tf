terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = ">= 2.0.2"
    }
    config = {
      source = "alabuel/config"
      version = "0.2.8"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the vSphere Provider
provider "vsphere" {
  user                 = var.vSphere_user
  password             = var.vSphere_password
  vsphere_server       = var.vSphere_server
  allow_unverified_ssl = var.allow_unverified_ssl
}

# Configure the AWS Provider
provider "aws" {
  shared_config_files      = ["/Users/asoham/.aws/config"]
  shared_credentials_files = ["/Users/asoham/.aws/credentials"]
  profile                  = "226279088210"
  region = "us-east-2"
}

module "uag_vsphere_apj_dc1a" {
  source    = "./uag_vsphere_module"
  uag_name  = "uag_apj_dc1a"   //prefix name
  uag_count = 1
  iniFile   = "uag.ini"
  inputs    = var.sensitive_input
}

module "uag_vsphere_apj_dc1b" {
  source    = "./uag_vsphere_module"
  uag_name  = "uag_apj_dc1b"
  uag_count = 0
  iniFile   = "uag.ini"
  inputs    = var.sensitive_input
}

module "uag_aws_apac_dca" {
  source    = "./uag_aws_module"
  uag_name  = "uag_apac_dca"
  uag_count = 2
  iniFile   = "uag_aws.ini"
  inputs    = var.sensitive_input
}

output "ipaddress_uag_apj_dc1a" {
  value = module.uag_vsphere_apj_dc1a.uag_ipaddress
} // for ip address

output "ipaddress_uag_apj_dc1b" {
  value = module.uag_vsphere_apj_dc1b.uag_ipaddress
}