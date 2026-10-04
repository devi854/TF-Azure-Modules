variable "resource_group_name" {
  type        = string
  description = "Resource group created by the network module and shared by the VM and web app"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
}

variable "address_space" {
  type        = list(string)
  description = "Address space of the virtual network"
}

variable "subnets" {
  type        = map(string)
  description = "Map of subnet name to CIDR range"
}

variable "vm_name" {
  type        = string
  description = "Name of the Windows VM, 15 characters at most"
}

variable "vm_subnet_name" {
  type        = string
  description = "Key in var.subnets that the VM is placed in"
}

variable "vm_size" {
  type        = string
  description = "VM size"
  default     = "Standard_B2s"
}

variable "app_service_plan_name" {
  type        = string
  description = "Name of the App Service plan"
}

variable "app_name" {
  type        = string
  description = "Globally unique name of the web app"
}

variable "app_service_sku" {
  type        = string
  description = "App Service plan SKU"
  default     = "B1"
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources"
  default     = {}
}
