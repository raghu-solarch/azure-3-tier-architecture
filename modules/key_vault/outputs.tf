output "id" {
  description = "Key Vault ID"
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "Key Vault name"
  value       = azurerm_key_vault.this.name
}

output "secret_id" {
  description = "ID of the created secret"
  value       = azurerm_key_vault_secret.vm_password.id
}

output "key_vault_secret_value" {
  value     = azurerm_key_vault_secret.vm_password.value
  sensitive = true
}

