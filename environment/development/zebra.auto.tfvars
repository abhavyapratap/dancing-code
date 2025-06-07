rg_info = {
  "rg-bhavya" = "centralindia"
}

server_info = {
  "indianserver" = {
    location                     = "centralindia"
    resource_group_name          = "rg-bhavya"
    administrator_login          = ""
    administrator_login_password = ""
    version                      = "12.0"
  }
}

database_info = {
  "bhavyadatabase" = {
    server_id    = "indianserver"
    collation    = "SQL_Latin1_General_CP1_CI_AS"
    license_type = "LicenseIncluded"
    max_size_gb  = 2
    sku_name     = "S0"
    enclave_type = "VBS"
  }
}

vnet_info = {
  "vnet" = {
    location            = "centralindia"
    resource_group_name = "rg-bhavya"
    address_space       = ["10.0.0.0/16"]
  }
}

subnet_info = {
  "Frontend-Subnet" = {
    resource_group_name  = "rg-bhavya"
    address_prefixes     = ["10.0.0.0/24"]
    virtual_network_name = "vnet"
  }

  "Backend-Subnet" = {
    resource_group_name  = "rg-bhavya"
    address_prefixes     = ["10.0.1.0/24"]
    virtual_network_name = "vnet"
  }
}

nic_info = {
  "frontend-nic" = {
    location              = "centralindia"
    resource_group_name   = "rg-bhavya"
    ip_configuration_name = "configuration1"
    subnet_id             = "Frontend-Subnet"
    public_ip             = "Frontend-Public-IP"
  }

  "backend-nic" = {
    location              = "centralindia"
    resource_group_name   = "rg-bhavya"
    ip_configuration_name = "configuration2"
    subnet_id             = "Backend-Subnet"
    public_ip             = "Backend-Public-IP"
  }
}

vm_info = {
  "Frontend-VM" = {
    resource_group_name   = "rg-bhavya"
    location              = "centralindia"
    size                  = "Standard_B2s"
    computer_name         = "ghost"
    admin_username        = "frontend"
    admin_password        = ""
    network_interface_ids = "frontend-nic"
    os_disk_name          = "frontend-os-disk"
    publisher             = "Canonical"
    offer                 = "0001-com-ubuntu-server-jammy"
    sku                   = "22_04-lts"
    version               = "latest"
  }

  "Backend-VM" = {
    resource_group_name   = "rg-bhavya"
    location              = "centralindia"
    size                  = "Standard_B2s"
    computer_name         = "ghostkabapp"
    admin_username        = "backend"
    admin_password        = ""
    network_interface_ids = "backend-nic"
    os_disk_name          = "backend-os-disk"
    publisher             = "Canonical"
    offer                 = "0001-com-ubuntu-server-focal"
    sku                   = "20_04-lts"
    version               = "latest"
  }
}

publicip_info = {
  "Frontend-Public-IP" = {
    location            = "centralindia"
    resource_group_name = "rg-bhavya"
  }

  "Backend-Public-IP" = {
    location            = "centralindia"
    resource_group_name = "rg-bhavya"
  }
}

nsg_info = {
  "frontend-network-security-group" = {
    location                = "centralindia"
    resource_group_name     = "rg-bhavya"
    security_rule_name      = "test123"
    destination_port_ranges = ["22", "80"]
  }

  "backend-network-security-group" = {
    location                = "centralindia"
    resource_group_name     = "rg-bhavya"
    security_rule_name      = "test12"
    destination_port_ranges = ["22", "8000"]
  }
}

nsg_nic_association = {
  "frontend-nsg-nic-association" = {
    network_interface_id      = "frontend-nic"
    network_security_group_id = "frontend-network-security-group"
  }

  "backend-nsg-nic-association" = {
    network_interface_id      = "backend-nic"
    network_security_group_id = "backend-network-security-group"
  }
}
