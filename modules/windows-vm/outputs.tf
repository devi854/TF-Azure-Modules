output "vm_id" {
  description = "Resource ID of the virtual machine"
  value       = azurerm_windows_virtual_machine.this.id
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_windows_virtual_machine.this.name
}

output "private_ip_address" {
  description = "Private IP address of the VM"
  value       = azurerm_network_interface.this.private_ip_address
}

output "public_ip_address" {
  description = "Public IP address of the VM, or null when none is attached"
  value       = one(azurerm_public_ip.this[*].ip_address)
}

output "principal_id" {
  description = "Principal ID of the VM's system-assigned managed identity"
  value       = azurerm_windows_virtual_machine.this.identity[0].principal_id
}

output "admin_username" {
  description = "Local administrator user name"
  value       = azurerm_windows_virtual_machine.this.admin_username
}

output "admin_password" {
  description = "Local administrator password"
  value       = local.admin_password
  sensitive   = true
}
