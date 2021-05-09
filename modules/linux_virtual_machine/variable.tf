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

variable "virtual_machine_name" {
  type = string
}

variable "network" {
  type        = string
  description = "Name of network"
}

variable "subnet" {
  type        = string
  description = "Name of subnet"
}

variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"
}

variable "use_public_ip" {
  type    = bool
  default = false
}

variable "public_ip_address_allocation" {
  type    = string
  default = "Dynamic" # "Static
}

variable "size" {
  type = string
  #default = "Standard_DS1_v2" # $2.3713/hr
  default = "Standard_B1ls" # $0.1984/hr
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

variable "username" {
  type    = string
  default = "chechia"
}

variable "ssh_key_file_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

# disk

variable "data_disks" {
  type    = list(object({
    name = string
    size = number
    storage_account_type = string
  }))
  default = []
}

variable "tmp_disks" {
  type    = object({
    name                 = string
    number               = number
    size                 = number
    storage_account_type = string
  })
  default = {
    name                 = "tmp"
    number               = 0
    size                 = 4
    storage_account_type = "Premium_LRS"
  }
}


