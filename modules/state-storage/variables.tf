variable "resource_group_name" {
  type        = string
  description = "Existing resource group that will hold the state storage account"
}

variable "location" {
  type        = string
  description = "Azure region for the storage account"
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique storage account name"

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Use 3 to 24 lowercase letters and numbers, with no hyphens."
  }
}

variable "container_name" {
  type        = string
  description = "Blob container that holds the state files"
  default     = "tfstate"
}

variable "replication_type" {
  type        = string
  description = "Storage replication type"
  default     = "GRS"

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "RAGRS", "GZRS"], var.replication_type)
    error_message = "Use LRS, ZRS, GRS, RAGRS, or GZRS."
  }
}

variable "soft_delete_days" {
  type        = number
  description = "Days to keep deleted blobs and containers"
  default     = 30

  validation {
    condition     = var.soft_delete_days >= 7 && var.soft_delete_days <= 365
    error_message = "Use a value between 7 and 365."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the storage account"
  default     = {}
}
