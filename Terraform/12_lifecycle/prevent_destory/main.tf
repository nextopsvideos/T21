resource "azurerm_resource_group" "rgname" {
  name     = "nextopsrg08"
  location = "EastUS"
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_virtual_network" "nextopsvnet04" {
  name                  = "NextOpsVNET09"
  resource_group_name   = azurerm_resource_group.rgname.name
  location              = azurerm_resource_group.rgname.location
  address_space         = ["10.4.0.0/16"]  
  lifecycle {
    prevent_destroy = false
  }

  depends_on = [ azurerm_resource_group.rgname,  ]
}

# resource "null_resource" "nr1" {
#     provisioner "local-exec" {
#       command = "echo ${azurerm_virtual_network.nextopsvnet04.id} >> vnet_id.txt"
#     }
# }