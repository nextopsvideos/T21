# data "type_of_the_data_source" "code_block_name" {
#     attribute1 = "value1"
#     attribute2 = "value2"
# }

data "azurerm_resource_group" "existingrg" {
    name = "NextOps"
}

data "azurerm_virtual_network" "existingvnet" {
    name                = "NextOpsVNET21"
    resource_group_name = data.azurerm_resource_group.existingrg.name
}

data "azurerm_subnet" "existingsubnet"{
    name                = "Subnet01"
    resource_group_name = data.azurerm_resource_group.existingrg.name
    virtual_network_name = data.azurerm_virtual_network.existingvnet.name
}

resource "azurerm_subnet" "subnet2" {
    name                = "Subnet02"
    resource_group_name  = data.azurerm_resource_group.existingrg.name
    virtual_network_name = data.azurerm_virtual_network.existingvnet.name
    address_prefixes     = ["10.0.1.0/24"]  
}

resource "azurerm_network_interface" "nic1" {
    name                    = "NextOpsnic21"
    resource_group_name     = data.azurerm_resource_group.existingrg.name 
    location                = data.azurerm_resource_group.existingrg.location

    ip_configuration {
      name                          = "ipconfig1"
      #subnet_id                    = azurerm_subnet.subnet2.id  ---> if you want to use new subnet for this nic card
      subnet_id                     = data.azurerm_subnet.existingsubnet.id  #---> if you want use existing subnet for this nic card
      private_ip_address_allocation = "Dynamic"
    }      
}