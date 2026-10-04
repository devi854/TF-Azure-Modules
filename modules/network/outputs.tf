output "resource_group_name" {
  description = "Name of the network resource group"
  value       = azurerm_resource_group.this.name
}

output "resource_group_id" {
  description = "Resource ID of the network resource group"
  value       = azurerm_resource_group.this.id
}

output "location" {
  description = "Azure region of the network resources"
  value       = azurerm_resource_group.this.location
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.this.name
}

output "vnet_id" {
  description = "Resource ID of the virtual network"
  value       = azurerm_virtual_network.this.id
}

output "subnet_ids" {
  description = "Map of subnet name to subnet ID"
  value       = { for name, subnet in azurerm_subnet.this : name => subnet.id }
}

output "nsg_ids" {
  description = "Map of subnet name to network security group ID"
  value       = { for name, nsg in azurerm_network_security_group.this : name => nsg.id }
}
