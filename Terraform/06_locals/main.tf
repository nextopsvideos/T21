resource "azurerm_resource_group" "myrg" {
    name        = var.rg_name
    location    = var.rg_location 
}

locals {
    prefix              = "nextops"
    short_rg_name       = azurerm_resource_group.myrg.name
    short_rg_location   = azurerm_resource_group.myrg.location
    short_vnet_name     = azurerm_virtual_network.myvnet.name
}

resource "azurerm_virtual_network" "myvnet" {
    name                    = join("-",[local.prefix,var.vnet_name]) #nextops-vnet01
    resource_group_name     = local.short_rg_name
    location                = local.short_rg_location
    address_space           = var.vnet_address_space
}

resource "azurerm_subnet" "subnet1" {
    name                    = join("-",[local.prefix,var.subnet1_name]) #netxops-subnet01
    resource_group_name     = local.short_rg_name
    virtual_network_name    = local.short_vnet_name
    address_prefixes        = var.address_prefix  
}