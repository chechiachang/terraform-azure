# Global

variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  description = "The name of the Azure resource group consul will be deployed into. This RG should already exist"
}

variable "location" {
  description = "The Azure region will be deployed in"
  default     = "southeastasia"
}

variable "environment" {
  type = string
}

# network

#variable "network" {
#  type        = string
#  description = "Name of network"
#}

variable "network" {
  type        = string
  description = "Name of network"
}

variable "subnet" {
  type        = string
  description = "Name of subnet"
}

variable "allowed_ssh_cidr_blocks" {
  type = list
}

variable "api_port" {
  description = "The port to use for Vault API calls"
  default     = 8200
}

# vault

variable "name" {
  description = "What to name the Vault cluster and all of its associated resources"
}

variable "instance_size" {
  description = "The instance size for the servers"
  default     = "Standard_A0"
}

variable "num_vault_servers" {
  description = "The number of Vault server nodes to deploy. We strongly recommend using 3 or 5."
  default     = 3
}

variable "priority" {
  type        = string
  default     = "Regular"
  description = "Regular / Spot"
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

# SSH

variable "username" {
  type    = string
  default = "chechia"
}

variable "ssh_key_file_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
