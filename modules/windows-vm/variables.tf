variable "name" {
  type        = string
  description = "VM name, also used as the Windows computer name"

  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,15}$", var.name))
    error_message = "Use 1 to 15 letters, numbers, or hyphens. Windows computer names cannot be longer."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the VM and its network interface"
}

variable "location" {
  type        = string
  description = "Azure region. Must match the region of the subnet."
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet the VM is attached to"
}

variable "size" {
  type        = string
  description = "VM size"
  default     = "Standard_B2s"
}

variable "admin_username" {
  type        = string
  description = "Local administrator user name"
  default     = "azureadmin"
}

variable "generate_admin_password" {
  type        = bool
  description = "Generate a random administrator password. Set to false to supply admin_password."
  default     = true
}

variable "admin_password" {
  type        = string
  description = "Administrator password, used only when generate_admin_password is false"
  default     = null
  sensitive   = true
}

variable "os_disk_type" {
  type        = string
  description = "Storage type of the OS disk"
  default     = "StandardSSD_LRS"

  validation {
    condition     = contains(["Standard_LRS", "StandardSSD_LRS", "Premium_LRS"], var.os_disk_type)
    error_message = "Use Standard_LRS, StandardSSD_LRS, or Premium_LRS."
  }
}

variable "image" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "Marketplace image for the VM"
  default = {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }
}

variable "create_public_ip" {
  type        = bool
  description = "Attach a public IP address to the VM"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources"
  default     = {}
}
