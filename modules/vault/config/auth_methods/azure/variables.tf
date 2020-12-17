variable "path" {
  type = string
  description = "Path for auth backend"
  default = "azure"
}

# azure auth

variable "tenant_id" {
  type = string
}

variable "client_id" {
  type = string
}

variable "client_secret" {
  type = string
}
