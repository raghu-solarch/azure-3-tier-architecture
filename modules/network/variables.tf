variable "vnet_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "address_space" {
  description = "CIDR for the VNet"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "subnets" {
  description = "Map of subnets with name and address_prefix"
  type = map(object({
    name           = string
    address_prefix = string
  }))
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

