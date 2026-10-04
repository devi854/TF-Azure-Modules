output "storage_account_id" {
  description = "Resource ID of the state storage account"
  value       = azurerm_storage_account.this.id
}

output "storage_account_name" {
  description = "Name of the state storage account"
  value       = azurerm_storage_account.this.name
}

output "container_name" {
  description = "Container that holds the state files"
  value       = azurerm_storage_container.this.name
}
