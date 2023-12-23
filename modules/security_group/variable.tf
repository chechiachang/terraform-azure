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
  type    = string
  default = ""
}

variable "rules" {
  type = map(any)
}
