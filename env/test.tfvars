environment = "test"
location    = "westeurope"
tags = {
  environment = "test"
  owner       = "training"
}

# Use a different CIDR block to avoid overlap with dev and prod
vnet_address_space = "10.1.0.0/16"

subnets = {
  web = {
    name           = "web-subnet"
    address_prefix = "10.1.1.0/24"
  }
  app = {
    name           = "app-subnet"
    address_prefix = "10.1.2.0/24"
  }
  db  = {
    name           = "db-subnet"
    address_prefix = "10.1.3.0/24"
  }
}

vm_admin_username           = "learning"
vm_admin_password           = "Redhat@12345"
service_principal_object_id = "f6812afd-e0f8-4aec-bbcd-fb5a7201db50"

