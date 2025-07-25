environment = "prod"
location    = "westeurope"
tags = {
  environment = "prod"
  owner       = "training"
}

# Another unique CIDR block
vnet_address_space = "10.2.0.0/16"

subnets = {
  web = {
    name           = "web-subnet"
    address_prefix = "10.2.1.0/24"
  }
  app = {
    name           = "app-subnet"
    address_prefix = "10.2.2.0/24"
  }
  db  = {
    name           = "db-subnet"
    address_prefix = "10.2.3.0/24"
  }
}

vm_admin_username           = "learning"
vm_admin_password           = "Redhat@12345"
service_principal_object_id = "f6812afd-e0f8-4aec-bbcd-fb5a7201db50"

