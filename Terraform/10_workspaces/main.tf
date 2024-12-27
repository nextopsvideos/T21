resource "azurerm_resource_group" "rg" {
    name = var.rg_name 
    location = var.rg_location

    tags = {
      env = terraform.workspace
    }
}

resource "azurerm_virtual_network" "vnet" {
    name = var.vnet_name 
    resource_group_name = azurerm_resource_group.rg.name 
    location = azurerm_resource_group.rg.location
    address_space = var.address_space

    tags = {
      env = terraform.workspace
    }
}

resource "azurerm_subnet" "subnet" {
    name = var.subnet_name 
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name = azurerm_resource_group.rg.name
    address_prefixes = var.address_prefix  
}