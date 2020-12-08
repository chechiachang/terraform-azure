# Global

variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  description = "The name of the Azure resource group consul will be deployed into. This RG should already exist"
}

variable "location" {
  description = "The Azure region the consul cluster will be deployed in"
  default     = "East US"
}

variable "environment" {
  type = string
}

# Storage

variable "storage_account_name" {
  description = "The name of an Azure Storage Account. This SA should already exist"
}

variable "storage_container_name" {
  description = "The name of an Azure Storage container. This should already exist"
}

# network

variable "network" {
  type        = string
  description = "Name of network"
}

variable "subnet" {
  type        = string
  description = "Name of subnet"
}

# vault

variable "name" {
  description = "What to name the Vault cluster and all of its associated resources"
  default     = "vault-example"
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
