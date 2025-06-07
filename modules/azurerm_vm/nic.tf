resource "azurerm_network_interface" "nic" {
  depends_on = [ azurerm_subnet.subnet ]
  for_each            = var.nic_info
  name                = each.key
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = each.value.ip_configuration_name
    subnet_id                     = azurerm_subnet.subnet[each.value.subnet_id].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.publicip[each.value.public_ip].id
  }
}

variable "nic_info" {}
