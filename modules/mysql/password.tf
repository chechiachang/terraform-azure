resource "random_string" "password-admin" {
  length  = 32
  special = false
}

output "password-admin" {
  value     = random_string.password-admin.result
  sensitive = true
}

