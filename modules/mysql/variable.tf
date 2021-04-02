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

variable "environment" {
  type = string
}

# Postgresql

variable "name" {
  type    = string
  default = ""
}

variable "sku_name" {
  type    = string
  default = "B_Gen5_1"
}

variable "databases" {
  type    = map(object({
    name = string
  }))
  default = {}
}

variable "storage_mb" {
  type = number
  default = 5120
}

variable "auto_grow_enabled" {
  type = bool
  default = false
}

variable "ssl_enforcement_enabled" {
  type = bool
  default = true
}

variable "ssl_minimal_tls_version_enforced" {
  type = string
  default = "TLS1_2"
}

variable "administrator_login" {
  type = string
}

# Network

variable "virtual_network_rules" {
  type    = map(object({
    name = string
    network = string
    subnet = string
  }))
  default = {}
}
