module "rg" {
  source  = "../../modules/azurerm_resource_group"
  rg_info = var.rg_info
}

module "server" {
  depends_on    = [module.rg]
  source        = "../../modules/azurerm_Server&Database"
  server_info   = var.server_info
  database_info = var.database_info
}

module "VM" {
  depends_on          = [module.server]
  source              = "../../modules/azurerm_vm"
  vnet_info           = var.vnet_info
  subnet_info         = var.subnet_info
  nic_info            = var.nic_info
  vm_info             = var.vm_info
  publicip_info       = var.publicip_info
  nsg_info            = var.nsg_info
  nsg_nic_association = var.nsg_nic_association
}
