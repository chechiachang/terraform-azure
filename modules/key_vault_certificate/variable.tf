variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

# Key vault

variable "certificate_name" {
  type = string
}

variable "sku_name" {
  type    = string
  default = "standard"
}

variable "soft_delete_retention_days" {
  type    = number
  default = 7
}

# Certificate

variable "subject_alternative_dns_names" {
  type = set(string)
}

variable "subject" {
  type = string
}

variable "validity_in_months" {
  type = number
}
