variable "resource_group_name" {
  type = string
}

variable "name" {
  type = string
}

variable "amount" {
  type    = number
  default = 1000
}

variable "time_grain" {
  type    = string
  default = "Monthly"
}

variable "start_date" {
  type = string
}

variable "end_date" {
  type    = string
  default = ""
}

variable "notifications" {
  type = map(object({
    enabled        = bool
    threshold      = number
    operator       = string
    threshold_type = string
    contact_emails = list(string)
    contact_groups = list(string)
    contact_roles  = list(string)
  }))
  default = {}
}
