module "scale-set" {
  #source = "git::ssh://git@github.com/chechiachang/terraform-azure.git/modules//scale_set?ref=v0.1.2"
  source = "/Users/che-chia/workspace/terraform-azure//modules/linux_virtual_machine_scale_set"

  resource_group_name = var.resource_group_name
  location = var.location
  environment = var.environment
  allowed_ssh_cidr_blocks = var.allowed_ssh_cidr_blocks

  name = var.name
  subnet = var.subnet
  sku = "Standard_B1ls"
  instances = 1
}
