# Global

variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

# Redis

variable "name" {
  type    = string
  default = ""
}

variable "sku_name" {
  type    = string
  default = "Standard"
}

variable "family" {
  type    = string
  default = "C"
}

variable "capacity" {
  type    = number
  default = 0
}

variable "enable_non_ssl_port" {
  type = string
  default = "false"
}

variable "ssl_minimal_tls_version" {
  type = string
  default = "1.2"
}
