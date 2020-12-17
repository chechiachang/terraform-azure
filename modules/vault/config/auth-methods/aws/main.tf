resource "vault_auth_backend" "aws" {
  type = "aws"
  path = var.path
}

resource "vault_aws_auth_backend_client" "aws" {
  backend    = vault_auth_backend.aws.path
}
