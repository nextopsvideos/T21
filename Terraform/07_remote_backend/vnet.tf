resource "azurerm_virtual_network" "myvnet" {
  name                = "NextOpsVNETT21"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  address_space       = ["10.0.0.0/16"]  

  tags = {
      "env" = "dev"
      "createby" = "Charan"
      "creationDate" = "12/24/2024"
  }
}

resource "azurerm_subnet" "subnet1" {
  name                  = "Subnet1"
  resource_group_name   = azurerm_resource_group.myrg.name
  virtual_network_name  = azurerm_virtual_network.myvnet.name
  address_prefixes      = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                  = "Subnet2"
  resource_group_name   = azurerm_resource_group.myrg.name
  virtual_network_name  = azurerm_virtual_network.myvnet.name
  address_prefixes      = ["10.0.1.0/24"]
}


