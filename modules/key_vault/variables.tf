variable "name" {
  description = "Key vault name"
  type        = string
}

variable "location" {
  description = "Region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID for the vault"
  type        = string
}

variable "vm_admin_password" {
  description = "Password for the VM admin account"
  type        = string
  sensitive   = true
}

variable "sp_object_id" {
  description = "Object ID of the service principal used by Terraform"
  type        = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

