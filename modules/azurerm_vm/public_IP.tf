resource "azurerm_public_ip" "publicip" {
  for_each            = var.publicip_info
  name                = each.key
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"
}

variable "publicip_info" {}
