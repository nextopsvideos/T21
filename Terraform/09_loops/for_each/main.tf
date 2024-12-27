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

resource "azurerm_subnet" "mysubnet" {
    for_each            = var.resourcedetails

    name                = each.value.subnet_name
    address_prefixes    = each.value.address_prefix
    virtual_network_name =  azurerm_virtual_network.myvnet[each.key].name
    resource_group_name =  azurerm_resource_group.myrg[each.key].name 

    depends_on = [ azurerm_resource_group.myrg, azurerm_virtual_network.myvnet ]  
}

resource "azurerm_network_interface" "mynic" {
  for_each = var.resourcedetails

  name                = "my-nic"
  location            = azurerm_resource_group.myrg[each.key].location
  resource_group_name = azurerm_resource_group.myrg[each.key].name
  ip_configuration {
    name                          = "my-ip-config"
    subnet_id                     = azurerm_subnet.mysubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }

  depends_on = [azurerm_subnet.mysubnet]
}

resource "azurerm_virtual_machine" "vm" {
  for_each = var.resourcedetails

  name                  = each.value.vm_name
  location              = azurerm_resource_group.myrg[each.key].location
  resource_group_name   = azurerm_resource_group.myrg[each.key].name
  network_interface_ids = [azurerm_network_interface.mynic[each.key].id]
  vm_size               = each.value.size

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${each.value.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = each.value.vm_name
    admin_username = "adminuser"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  depends_on = [azurerm_network_interface.mynic,
    azurerm_subnet.mysubnet,
    azurerm_virtual_network.myvnet,
    azurerm_resource_group.myrg]
}