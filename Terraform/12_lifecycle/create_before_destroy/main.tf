resource "azurerm_resource_group" "myrg1" {
    name        = var.rgname
    location    = var.location

    lifecycle {
      create_before_destroy = true
    }  
}

resource "azurerm_virtual_network" "myvnet1" {
    name  = "NextOpsVNET25"
    resource_group_name = azurerm_resource_group.myrg1.name
    location = azurerm_resource_group.myrg1.location
    address_space = ["${var.vnet_cidr_prefix}"]
    depends_on = [ azurerm_resource_group.myrg1 ]

    lifecycle {
      create_before_destroy = true
    }
}
