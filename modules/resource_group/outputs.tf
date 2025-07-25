output "id" {
  value       = azurerm_resource_group.this.id
  description = "Resource group ID"
}

output "name" {
  value = azurerm_resource_group.this.name
}

output "location" {
  value = azurerm_resource_group.this.location
}

