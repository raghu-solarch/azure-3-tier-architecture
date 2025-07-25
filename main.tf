provider "azurerm" {
  features {}
  # specify subscription if you want, otherwise will use env variables from GitHub Actions
}

# Resource Group
module "rg" {
  source   = "./modules/resource_group"
  name     = "${var.environment}-rg"
  location = var.location
  tags     = var.tags
}

# Key Vault
data "azurerm_client_config" "current" {}

module "kv" {
  source              = "./modules/key_vault"
  name                = "kv-${var.environment}"
  location            = var.location
  resource_group_name = module.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  vm_admin_password   = var.vm_admin_password
  sp_object_id        = var.service_principal_object_id
  tags                = var.tags
}

# Network
module "network" {
  source              = "./modules/network"
  vnet_name           = "vnet-${var.environment}"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = module.rg.name
  subnets             = var.subnets
  tags                = var.tags
}

# Define security rules per tier
locals {
  web_rules = [
    {
      name                  = "allow-http"
      priority              = 100
      direction             = "Inbound"
      access                = "Allow"
      protocol              = "Tcp"
      source_address_prefix = "Internet"
      destination_ports     = ["80", "443", "22"]
    }
  ]
  app_rules = [
    {
      name                  = "allow-from-web"
      priority              = 100
      direction             = "Inbound"
      access                = "Allow"
      protocol              = "Tcp"
      source_address_prefix = module.network.subnet_ids["web"]
      destination_ports     = ["8080", "22"]
    }
  ]
  db_rules = [
    {
      name                  = "allow-from-app"
      priority              = 100
      direction             = "Inbound"
      access                = "Allow"
      protocol              = "Tcp"
      source_address_prefix = module.network.subnet_ids["app"]
      destination_ports     = ["5432", "22"]
    }
  ]
}

# NSGs
module "web_nsg" {
  source              = "./modules/nsg"
  name                = "nsg-web-${var.environment}"
  location            = var.location
  resource_group_name = module.rg.name
  rules               = local.web_rules
  tags                = var.tags
}

module "app_nsg" {
  source              = "./modules/nsg"
  name                = "nsg-app-${var.environment}"
  location            = var.location
  resource_group_name = module.rg.name
  rules               = local.app_rules
  tags                = var.tags
}

module "db_nsg" {
  source              = "./modules/nsg"
  name                = "nsg-db-${var.environment}"
  location            = var.location
  resource_group_name = module.rg.name
  rules               = local.db_rules
  tags                = var.tags
}

# Retrieve the password secret from Key Vault
data "azurerm_key_vault" "current" {
  name                = module.kv.name
  resource_group_name = module.rg.name
}

data "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-admin-password"
  key_vault_id = data.azurerm_key_vault.current.id
}

# VMs
module "web_vm" {
  source              = "./modules/vm"
  name                = "web-${var.environment}"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.network.subnet_ids["web"]
  nsg_id              = module.web_nsg.id
  admin_username      = var.vm_admin_username
  admin_password      = data.azurerm_key_vault_secret.vm_password.value
  vm_size             = "Standard_B1s"
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }
  source_image = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  tags = var.tags
}

module "app_vm" {
  source              = "./modules/vm"
  name                = "app-${var.environment}"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.network.subnet_ids["app"]
  nsg_id              = module.app_nsg.id
  admin_username      = var.vm_admin_username
  admin_password      = data.azurerm_key_vault_secret.vm_password.value
  vm_size             = "Standard_B1s"
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }
  source_image = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  tags = var.tags
}

module "db_vm" {
  source              = "./modules/vm"
  name                = "db-${var.environment}"
  location            = var.location
  resource_group_name = module.rg.name
  subnet_id           = module.network.subnet_ids["db"]
  nsg_id              = module.db_nsg.id
  admin_username      = var.vm_admin_username
  admin_password      = data.azurerm_key_vault_secret.vm_password.value
  vm_size             = "Standard_B1s"
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }
  source_image = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  tags = var.tags
}

