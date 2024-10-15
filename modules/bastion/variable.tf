variable "subscription_id" {
  type = string
}

variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "network" {
  type = string
}

variable "subnet" {
  type = string
}

variable "sku" {
  type = string
}

variable "shareable_link_enabled" {
  type    = bool
  default = false
}

variable "ip_allocation_method" {
  type    = string
  default = "Static"
}

variable "ip_sku" {
  type    = string
  default = "Standard"
}
