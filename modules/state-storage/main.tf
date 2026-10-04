resource "azurerm_storage_account" "this" {
  #checkov:skip=CKV_AZURE_33:Queue service is not used on this account
  #checkov:skip=CKV_AZURE_59:Public access needed for hosted pipeline runners
  #checkov:skip=CKV2_AZURE_33:Private endpoint not possible with hosted pipeline runners
  #checkov:skip=CKV2_AZURE_1:Microsoft-managed keys are the module default

  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_kind                    = "StorageV2"
  account_replication_type        = var.replication_type
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = false
  default_to_oauth_authentication = true
  allow_nested_items_to_be_public = false
  tags                            = var.tags

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = var.soft_delete_days
    }

    container_delete_retention_policy {
      days = var.soft_delete_days
    }
  }
}

resource "azurerm_storage_container" "this" {
  #checkov:skip=CKV2_AZURE_21:Blob read logging is left to the caller

  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}
