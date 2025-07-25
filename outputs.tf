output "web_public_ip" {
  description = "Public IP of the web tier"
  value       = module.web_vm.public_ip
}

output "app_public_ip" {
  description = "Public IP of the app tier"
  value       = module.app_vm.public_ip
}

output "db_public_ip" {
  description = "Public IP of the database tier"
  value       = module.db_vm.public_ip
}

