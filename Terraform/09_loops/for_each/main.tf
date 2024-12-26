resource "azurerm_resource_group" "myrg" {
    for_each = var.resourcedetails
    
    name     = each.value.rg_name 
    location = each.value.rg_location
}

resource "azurerm_virtual_network" "myvnet" {
    for_each = var.resourcedetails

    name                = each.value.vnet_name
    resource_group_name = azurerm_resource_group.myrg[each.key].name
    location            = azurerm_resource_group.myrg[each.key].location
    address_space       = each.value.address_space

    depends_on = [ azurerm_resource_group.myrg ]  
}