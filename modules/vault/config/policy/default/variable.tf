variable "name" {
  type = string
}

variable "path" {
  type = string
}

variable "description" {
  type = string
}

variable "permissions" {
  type = list(string)
}

variable "policy" {
  type        = string
  default     = ""
  description = "Policy will overwrite path and permissions if not empty"
}
