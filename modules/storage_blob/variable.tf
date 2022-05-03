variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "environment" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "name" {
  type = string
}

# Blob

variable "type" {
  type        = string
  description = "Block / Append / Page"
  default     = "Block"
}

variable "blob_source" {
  type    = string
  default = ""
}

# Private endpoint

variable "subnet_id" {
  type = string
}

variable "private_dns_zone_name" {
  type    = string
  default = ""
}

variable "private_dns_zone_id" {
  type    = string
  default = ""
}
