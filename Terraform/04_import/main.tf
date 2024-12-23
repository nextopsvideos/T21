resource "azurerm_resource_group" "existingrg" {
    name = "NextOpsRGT21"
    location = "westus"  
    tags = {
      "env" = "dev"
      "createdby" = "charan"
      "createddate" = "23/12/2024"
    }
}

resource "azurerm_virtual_network" "exisitingvnet" {
    name = "NextOpsVNET22"
    resource_group_name = azurerm_resource_group.existingrg.name
    location = azurerm_resource_group.existingrg.location
    address_space = [ "10.10.0.0/16" ]
    tags = {
      "env" = "dev"
      "createdby" = "charan"
      "createddate" = "23/12/2024"
    }
}

resource "azurerm_subnet" "exisitingsubnet1" {
    name    = "Subnet01"
    resource_group_name = azurerm_resource_group.existingrg.name
    virtual_network_name = azurerm_virtual_network.exisitingvnet.name 
    address_prefixes = [ "10.10.0.0/24" ]
}