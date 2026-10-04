locals {
  # Free and Shared plans do not support Always On.
  always_on = !contains(["F1", "D1"], var.sku_name)
}

resource "azurerm_service_plan" "this" {
  #checkov:skip=CKV_AZURE_212:Instance count is left to the caller's SKU choice
  #checkov:skip=CKV_AZURE_225:Zone redundancy needs a Premium SKU
  #checkov:skip=CKV_AZURE_211:SKU is a caller input, Basic is allowed for non-production

  name                = var.plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.sku_name
  tags                = var.tags
}

resource "azurerm_linux_web_app" "this" {
  #checkov:skip=CKV_AZURE_214:Always On is enabled automatically for every SKU that supports it
  #checkov:skip=CKV_AZURE_13:App-level authentication is configured by the application team
  #checkov:skip=CKV_AZURE_17:Client certificates are not required by default
  #checkov:skip=CKV_AZURE_88:No persistent storage mount is needed by default
  #checkov:skip=CKV_AZURE_213:Health check path depends on the application
  #checkov:skip=CKV_AZURE_222:Public access is the module default for a web app
  #checkov:skip=CKV_AZURE_63:HTTP logging is left to the caller
  #checkov:skip=CKV_AZURE_65:Detailed error logging is left to the caller
  #checkov:skip=CKV_AZURE_66:Failed request tracing is left to the caller

  name                = var.app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true
  app_settings        = var.app_settings
  tags                = var.tags

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on           = local.always_on
    minimum_tls_version = "1.2"
    ftps_state          = "Disabled"
    http2_enabled       = true
  }
}
