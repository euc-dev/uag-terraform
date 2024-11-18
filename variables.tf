variable "vSphere_user" {
  description = "vSphere user"
  type        = string
  default     = "administrator@vsphere.local"
}

variable "vSphere_password" {
  description = "vSphere password"
  type        = string
  default     = "B!9#leph@nt"
}

variable "vSphere_server" {
  description = "vSphere server"
  type        = string
  default     = "10.108.120.14"
}

variable "allow_unverified_ssl" {
  description = "allow unverififed ssl"
  type        = string
  default     = true
}

variable "sensitive_input" {
  description = "Ini file consisting of all sensitive inputs"
  type = string
}

