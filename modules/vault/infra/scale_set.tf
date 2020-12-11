module "scale-set" {
  source = "git::ssh://git@github.com/chechiachang/terraform-azure.git/modules//scale_set?ref=v0.1.2"

  name = "algo-vpn"
  subnet = "base-external"
  sku = "Standard_B1ls"
  instances = 1
}
