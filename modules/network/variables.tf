variable "resource_group_name" {
  type        = string
  description = "Name of the resource group to create for the network"
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
  description = "Address space of the virtual network in CIDR format"

  validation {
    condition     = alltrue([for cidr in var.address_space : can(cidrhost(cidr, 0))])
    error_message = "Every address space entry must be a valid CIDR range."
  }
}

variable "subnets" {
  type        = map(string)
  description = "Map of subnet name to CIDR range"

  validation {
    condition     = alltrue([for cidr in values(var.subnets) : can(cidrhost(cidr, 0))])
    error_message = "Every subnet value must be a valid CIDR range."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources"
  default     = {}
}
