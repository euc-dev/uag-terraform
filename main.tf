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
  }
}

provider "vsphere" {
  user                 = var.vSphere_user
  password             = var.vSphere_password
  vsphere_server       = var.vSphere_server
  allow_unverified_ssl = var.allow_unverified_ssl
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

output "ipaddress_uag_apj_dc1a" {
  value = module.uag_vsphere_apj_dc1a.uag_ipaddress
} // for ip address

output "ipaddress_uag_apj_dc1b" {
  value = module.uag_vsphere_apj_dc1b.uag_ipaddress
}