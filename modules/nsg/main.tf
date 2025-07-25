resource "azurerm_network_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "rules" {
  for_each = { for rule in var.rules : rule.name => rule }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = "*"
  destination_port_ranges     = each.value.destination_ports
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.this.name
  resource_group_name         = var.resource_group_name
}

