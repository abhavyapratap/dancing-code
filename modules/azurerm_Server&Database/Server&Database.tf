variable "server_info" {}
variable "database_info" {}

resource "azurerm_mssql_server" "server" {
  for_each                     = var.server_info
  name                         = each.key
  location                     = each.value.location
  resource_group_name          = each.value.resource_group_name
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
  version                      = each.value.version
}

resource "azurerm_mssql_database" "database" {
  depends_on = [ azurerm_mssql_server.server ]
  for_each     = var.database_info
  name         = each.key
  server_id    = azurerm_mssql_server.server[each.value.server_id].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type
}
