# Global

variable "resource_group_name" {
  type = string
}

# Redis

variable "redis_cache_name" {
  type = string
}

variable "firewall_rules" {
  type = map(object({
    name     = string
    start_ip = string
    end_ip   = string
  }))
  default = {}
}
