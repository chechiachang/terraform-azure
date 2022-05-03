locals {
  path = "${var.transit_backend_path}/decrypt/${var.transit_backend_key_name}"
}

module "transit_policy" {
  source = "../../policy/default"

  name        = "${var.transit_backend_key_name}_decrypt"
  path        = local.path
  description = "Allow transit decrypt with path: ${local.path}"
  permissions = ["update"]
  policy      = var.policy
}
