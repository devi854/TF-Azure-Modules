# Replace <modules-repo> with the name of your modules repository.
# Every module is pinned to a release tag. Change ref to take a new version.

module "network" {
  source = "git::https://github.com/devi854/<modules-repo>.git//modules/network?ref=v1.0.0"

  resource_group_name = var.resource_group_name
  location            = var.location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = var.tags
}

module "windows_vm" {
  source = "git::https://github.com/devi854/<modules-repo>.git//modules/windows-vm?ref=v1.0.0"

  name                = var.vm_name
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  subnet_id           = module.network.subnet_ids[var.vm_subnet_name]
  size                = var.vm_size
  tags                = var.tags
}

module "app_service" {
  source = "git::https://github.com/devi854/<modules-repo>.git//modules/app-service?ref=v1.0.0"

  plan_name           = var.app_service_plan_name
  app_name            = var.app_name
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  sku_name            = var.app_service_sku
  tags                = var.tags
}
