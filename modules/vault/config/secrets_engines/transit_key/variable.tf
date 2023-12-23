variable "transit_backend_path" {
  type        = string
  default     = "transit"
  description = "Path of an existing transit backend"
}

variable "transit_backend_key_name" {
  type = string
}

variable "transit_backend_key_type" {
  type    = string
  default = "aes256-gcm96"
}

variable "policy" {
  type        = string
  default     = ""
  description = "Policy will overwrite path and permissions if not empty"
}
