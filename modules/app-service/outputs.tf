output "service_plan_id" {
  description = "Resource ID of the App Service plan"
  value       = azurerm_service_plan.this.id
}

output "app_id" {
  description = "Resource ID of the web app"
  value       = azurerm_linux_web_app.this.id
}

output "app_name" {
  description = "Name of the web app"
  value       = azurerm_linux_web_app.this.name
}

output "default_hostname" {
  description = "Default host name of the web app"
  value       = azurerm_linux_web_app.this.default_hostname
}

output "principal_id" {
  description = "Principal ID of the web app's system-assigned managed identity"
  value       = azurerm_linux_web_app.this.identity[0].principal_id
}
