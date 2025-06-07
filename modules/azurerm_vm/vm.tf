resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vm_info
  name                            = each.key
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  computer_name                   = each.value.computer_name
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false
  network_interface_ids = [azurerm_network_interface.nic[each.value.network_interface_ids].id]

  os_disk {
    name                 = each.value.os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}

variable "vm_info" {}