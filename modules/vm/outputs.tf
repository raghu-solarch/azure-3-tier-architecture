output "public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.this.ip_address
}

output "id" {
  description = "ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.this.id
}

