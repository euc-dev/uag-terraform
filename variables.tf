variable "vSphere_user" {
  description = "vSphere user"
  type        = string
}

variable "vSphere_password" {
  description = "vSphere password"
  type        = string
}

variable "vSphere_server" {
  description = "vSphere server"
  type        = string
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

