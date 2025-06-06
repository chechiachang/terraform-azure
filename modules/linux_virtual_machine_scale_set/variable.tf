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

variable "name" {
  type = string
}

variable "sku" {
  type = string
  #default = "Standard_DS1_v2" # $2.3713/hr
  default = "Standard_B1ls" # $0.1984/hr
}

variable "instances" {
  type    = number
  default = 1
}

variable "priority" {
  type        = string
  default     = "Regular"
  description = "Regular / Spot"
}

# network

variable "load_balancer_backend_address_pool_ids" {
  type    = list(string)
  default = []
}

variable "load_balancer_inbound_nat_rules_ids" {
  type    = list(string)
  default = []
}

variable "network" {
  type        = string
  description = "Name of network"
}

variable "subnet" {
  type        = string
  description = "Name of subnet"
}

variable "allowed_ssh_cidr_blocks" {
  type    = list(any)
  default = []
}

variable "api_port" {
  description = "The port to use for Vault API calls"
  default     = 8200
}

# Spot

variable "max_bid_price" {
  type        = number
  default     = null
  description = "Required only if priotity is Spot"
}

# Source image

variable "source_image_publisher" {
  type    = string
  default = "Canonical"
}

variable "source_image_offer" {
  type    = string
  default = "UbuntuServer"
}

variable "source_image_sku" {
  type    = string
  default = "18.04-LTS"
}

variable "source_image_version" {
  type    = string
  default = "latest"
}

# Disk

variable "os_disk_size_gb" {
  type    = number
  default = 50
}

variable "data_disks" {
  type = list(object({
    name                 = string
    size                 = number
    storage_account_type = string
  }))
  default = []
}

# Provision

variable "cloudconfig_file" {
  type    = string
  default = "../../templates/cloud_config/ds2v4.yaml"
}

# SSH

variable "security_gruop_name" {
  type        = string
  default     = ""
  description = "Name of the security group to use for SSH access. If not provided, a new security group will be created."
}

variable "network_security_group_id" {
  type        = string
  default     = ""
  description = "ID of the network security group to use for SSH access. If not provided, a new security group will be created."
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type    = string
  default = ""
}

variable "disable_password_authentication" {
  type    = bool
  default = true
}

variable "ssh_key_file_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

# chia

variable "storage_account_name" {
  type = string
}

variable "storage_container_name" {
  type = string
}

variable "storage_container_fqdn" {
  type    = string
  default = ""
}
