variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}

variable "vnet_address_space" {
  description = "CIDR block for the virtual network"
  type        = string
}

variable "subnets" {
  description = "Map of subnet definitions"
  type = map(object({
    name           = string
    address_prefix = string
  }))
}

variable "vm_admin_username" {
  description = "Administrator username for the VMs"
  type        = string
}

variable "vm_admin_password" {
  description = "Administrator password for the VMs"
  type        = string
  sensitive   = true
}

variable "service_principal_object_id" {
  description = "Object ID of the service principal (read/write) used by Terraform"
  type        = string
}

