output "subnet_ids" {
  description = "IDs of the created subnets"
  value       = { for k, subnet in azurerm_subnet.subnets : k => subnet.id }
}

output "vnet_name" {
  description = "Name of the created VNet"
  value       = azurerm_virtual_network.this.name
}

