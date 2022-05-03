# Global

variable "resource_group_name" {
  type = string
}

# Mysql

variable "mysql_server_name" {
  type = string
}

variable "firewall_rules" {
  type = map(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
  }))
  default = {}
}
