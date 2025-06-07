resource "azurerm_subnet" "subnet" {
  depends_on           = [azurerm_virtual_network.vnet]
  for_each             = var.subnet_info
  name                 = each.key
  resource_group_name  = each.value.resource_group_name
  address_prefixes     = each.value.address_prefixes
  virtual_network_name = each.value.virtual_network_name
}

variable "subnet_info" {}
