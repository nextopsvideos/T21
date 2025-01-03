resource "azurerm_resource_group" "rg" {
    name = var.rg_name
    location = var.rg_location
  
}

# while running terraform apply, please input a value for env_prod. If provided input is == no (case sensitive) 
# this code will deploy dev related resources
resource "azurerm_virtual_network" "vnet" {
    name                 = var.env_prod == "no" ? "dev-vnet" : "prod-vnet" 
    resource_group_name  = azurerm_resource_group.rg.name  
    location             = azurerm_resource_group.rg.location
    address_space        = var.env_prod == "no" ? ["10.90.0.0/16"] : ["10.80.0.0/16"]  
}

resource "azurerm_subnet" "subnet" {
    name                    = var.env_prod == "no" ? "dev-subnet1" : "prod-subnet1"
    resource_group_name     = azurerm_resource_group.rg.name
    virtual_network_name    = azurerm_virtual_network.vnet.name   
    address_prefixes        = var.env_prod == "no" ? ["10.90.0.0/24"] : [ "10.80.0.0/24" ]  
}