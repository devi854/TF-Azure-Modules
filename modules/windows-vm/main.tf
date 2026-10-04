resource "random_password" "admin" {
  count = var.generate_admin_password ? 1 : 0

  length           = 20
  min_lower        = 2
  min_upper        = 2
  min_numeric      = 2
  min_special      = 2
  override_special = "!#%*-_=+"
}

locals {
  admin_password = var.generate_admin_password ? one(random_password.admin[*].result) : var.admin_password
}

resource "azurerm_public_ip" "this" {
  count = var.create_public_ip ? 1 : 0

  name                = "pip-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_network_interface" "this" {
  #checkov:skip=CKV_AZURE_119:Public IP is optional and off by default
  #checkov:skip=CKV2_AZURE_39:Public IP is optional and off by default

  name                = "nic-${var.name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = one(azurerm_public_ip.this[*].id)
  }
}

resource "azurerm_windows_virtual_machine" "this" {
  #checkov:skip=CKV_AZURE_50:Extensions are needed for configuration automation
  #checkov:skip=CKV_AZURE_151:Encryption at host needs a subscription feature registration

  name                  = var.name
  computer_name         = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = var.size
  admin_username        = var.admin_username
  admin_password        = local.admin_password
  network_interface_ids = [azurerm_network_interface.this.id]
  tags                  = var.tags

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
  }

  source_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }

  identity {
    type = "SystemAssigned"
  }

  boot_diagnostics {}

  lifecycle {
    precondition {
      condition     = var.generate_admin_password || var.admin_password != null
      error_message = "Set admin_password when generate_admin_password is false."
    }
  }
}
