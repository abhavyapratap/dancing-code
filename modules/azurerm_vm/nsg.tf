resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsg_info
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  security_rule {
    name                       = each.value.security_rule_name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = each.value.destination_port_ranges
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_nic_association" {
  for_each                  = var.nsg_nic_association
  network_interface_id      = azurerm_network_interface.nic[each.value.network_interface_id].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value.network_security_group_id].id
}

variable "nsg_info" {}
variable "nsg_nic_association" {}
