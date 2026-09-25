variable "name" {
  type = string
}

variable "container_app_environment_name" {
  type = string
}

variable "container_app_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "image" {
  type    = string
  default = "prom/blackbox-exporter:v0.25.0"
}

variable "cpu" {
  type    = number
  default = 0.25
}

variable "memory" {
  type    = string
  default = "0.5Gi"
}

variable "openai_api_key" {
  type      = string
  sensitive = true
}

variable "openai_targets" {
  type = list(string)

  validation {
    condition     = length(var.openai_targets) > 0
    error_message = "openai_targets must contain at least one deployment URL."
  }

  validation {
    condition     = alltrue([for target in var.openai_targets : can(regex("\\?.*api-version=", target))])
    error_message = "Each openai target URL must include a pinned api-version query parameter."
  }
}

variable "openai_embedding_targets" {
  type    = list(string)
  default = []

  validation {
    condition     = alltrue([for target in var.openai_embedding_targets : can(regex("\\?.*api-version=", target))])
    error_message = "Each OpenAI embedding target URL must include a pinned api-version query parameter."
  }
}

variable "grafana_allowed_cidrs" {
  type = list(string)

  validation {
    condition     = length(var.grafana_allowed_cidrs) > 0
    error_message = "grafana_allowed_cidrs must include Grafana Cloud source CIDR ranges."
  }
}

variable "environment" {
  type    = string
  default = null
}

variable "project" {
  type    = string
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "enable_managed_identity" {
  type    = bool
  default = false
}
