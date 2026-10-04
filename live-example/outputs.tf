output "resource_group_name" {
  description = "Resource group that holds the environment"
  value       = module.network.resource_group_name
}

output "subnet_ids" {
  description = "Map of subnet name to subnet ID"
  value       = module.network.subnet_ids
}

output "vm_private_ip" {
  description = "Private IP address of the Windows VM"
  value       = module.windows_vm.private_ip_address
}

output "vm_admin_username" {
  description = "Administrator user name of the Windows VM"
  value       = module.windows_vm.admin_username
}

output "vm_admin_password" {
  description = "Administrator password of the Windows VM"
  value       = module.windows_vm.admin_password
  sensitive   = true
}

output "app_url" {
  description = "URL of the web app"
  value       = "https://${module.app_service.default_hostname}"
}
