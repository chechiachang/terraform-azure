variable "k8s_namespace" {
  type = string
}

variable "service_name" {
  type = string
}

variable "enable_kv" {
  type    = bool
  default = false
}

variable "kv_secret_path" {
  type    = string
  default = ""
}

variable "kv_permissions" {
  type    = list(string)
  default = ["read", "list"]
}

variable "kv_policy" {
  type        = string
  default     = ""
  description = "Policy will overwrite kv_secret_path and kv_permissions if not empty"
}

variable "k8s_service_account" {
  type    = string
  default = ""
}

variable "k8s_auth_path" {
  type = string
}
