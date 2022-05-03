variable "auth_approle_path" {
  type    = string
  default = "approle"
}

variable "approle_role_name" {
  type = string
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
