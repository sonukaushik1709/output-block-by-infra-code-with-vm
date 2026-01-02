rgs = {
  rg1 = {
    name     = "outputblock"
    location = "Japan East"
  }
  rg2 = {
    name     = "outputblock1"
    location = "Japan East"
  }
}

stgs = {
  stg1 = {

    name                     = "outputblockstg"
    location                 = "Japan East"
    resource_group_name      = "outputblock"
    account_tier             = "Standard"
    account_replication_type = "GRS"

  }
}
containers = {
  container1 = {
    name                  = "outputblockcontainer"
    storage_account_id    = "stg1"
    container_access_type = "private"

  }
}

vnets = {
  vnet1 = {
    name                = "outputblock-vnets"
    resource_group_name = "outputblock"
    location            = "Japan East"
    address_space       = ["10.0.0.0/16"]

  }

}

subnets = {
  subnet1 = {
    name                 = "frontend-subnet"
    resource_group_name  = "outputblock"
    virtual_network_name = "outputblock-vnets"
    address_prefixes     = ["10.0.1.0/24"]


  }
  subnet2 = {
    name                 = "backend-subnet"
    resource_group_name  = "outputblock"
    virtual_network_name = "outputblock-vnets"
    address_prefixes     = ["10.0.2.0/24"]


  }
}

nsgs = {
  nsg1 = {
    name                = "frontend-subnet-nasg"
    location            = "Japan East"
    resource_group_name = "outputblock"
    tags = {
      environment = "dev"
    }
    security_rules = {
      rule1 = {
        name                       = "frontend-test123"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"

      }

    }



  }
  nsg2 = {
    name                = "backend-subnet-nasg"
    location            = "Japan East"
    resource_group_name = "outputblock"
    tags = {
      environment = "dev"
    }
    security_rules = {
      rule2 = {
        name                       = "backend-test123"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"

      }

    }



  }
}

associations = {
  association1 = {
    subnet_id                 = "subnet1"
    network_security_group_id = "nsg1"

  }
  association2 = {
    subnet_id                 = "subnet2"
    network_security_group_id = "nsg2"

  }
}

pips = {
  pip1 = {
    name                = "frontend-vm-pip"
    resource_group_name = "outputblock"
    location            = "Japan East"
    allocation_method   = "Static"

    tags = {
      environment = "dev"
    }

  }
  pip2 = {
    name                = "backend-vm-pip"
    resource_group_name = "outputblock"
    location            = "Japan East"
    allocation_method   = "Static"

    tags = {
      environment = "dev"
    }

  }
}

nics = {
  nic1 = {
    name                = "frontend-nic-vm"
    location            = "Japan East"
    resource_group_name = "outputblock"
    ip_configurations = {
      ip1 = {
        name                          = "internal"
        subnet_id                     = "subnet1"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "pip1"

      }
    }


  }
  nic2 = {
    name                = "backend-nic-vm"
    location            = "Japan East"
    resource_group_name = "outputblock"
    ip_configurations = {
      ip2 = {
        name                          = "internal"
        subnet_id                     = "subnet2"
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = "pip2"

      }
    }


  }
}

vms = {
  vm1 = {
    name                            = "fromten-vm"
    location                        = "Japan East"
    resource_group_name             = "outputblock"
    size                            = "Standard_D2s_v3"
    admin_username                  = "abc"
    admin_password                  = "ramshayam@1234"
    network_interface_ids           = "nic1"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"


  }
  vm2 = {
    name                            = "backend-vm"
    location                        = "Japan East"
    resource_group_name             = "outputblock"
    size                            = "Standard_D2s_v3"
    admin_username                  = "abc"
    admin_password                  = "ramshayam@1234"
    network_interface_ids           = "nic2"
    disable_password_authentication = false
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "Canonical"
    offer                           = "0001-com-ubuntu-server-jammy"
    sku                             = "22_04-lts"
    version                         = "latest"


  }
}