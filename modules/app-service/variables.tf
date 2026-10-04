variable "plan_name" {
  type        = string
  description = "Name of the App Service plan"
}

variable "app_name" {
  type        = string
  description = "Globally unique name of the web app. Becomes <app_name>.azurewebsites.net."

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]{0,58}[a-zA-Z0-9]$", var.app_name))
    error_message = "Use 2 to 60 letters, numbers, or hyphens, and do not start or end with a hyphen."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Resource group for the plan and the web app"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "sku_name" {
  type        = string
  description = "App Service plan SKU, for example F1, B1, B2, S1, P1v3"
  default     = "B1"
}

variable "app_settings" {
  type        = map(string)
  description = "Application settings passed to the web app"
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all resources"
  default     = {}
}
