variable "path" {
  type        = string
  description = "Path for auth backend"
  default     = "azure"
}

variable "role" {
  type    = string
  default = "default"
}

variable "bound_subscription_ids" {
  type    = list(string)
  default = []
}

variable "bound_resource_groups" {
  type    = list(string)
  default = []
}

variable "token_ttl" {
  type        = number
  default     = 3600
  description = "in second"
}

variable "token_max_ttl" {
  type        = number
  default     = 36000
  description = "in second"
}

variable "token_policies" {
  type    = list(string)
  default = ["default", "dev", "prod"]
}
