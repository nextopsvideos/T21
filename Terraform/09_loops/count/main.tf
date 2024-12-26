resource "azurerm_resource_group" "myrg" {  
    name        = var.rg_name
    location    = var.rg_location  
}

resource "azurerm_virtual_network" "myvnet" {
    name                = var.vnet_name
    resource_group_name = azurerm_resource_group.myrg.name
    location            = azurerm_resource_group.myrg.location
    address_space       = var.address_space
}

resource "azurerm_subnet" "subnet" {
  count                 = length(var.subnet_name) # 4
  name                  = var.subnet_name[count.index] # var.subnet_name[0] = subnet1, var.subnet_name[1] = subnet2, var.subnet_name[2] = subnet3, var.subnet_name[3] = subnet4
  resource_group_name   = azurerm_resource_group.myrg.name
  virtual_network_name  = azurerm_virtual_network.myvnet.name
  address_prefixes      = ["10.0.${count.index}.0/24"]
}

resource "azurerm_network_interface" "nic" {
    count               = 5
    name                = "nextops-nic-${count.index}"
    location            = azurerm_resource_group.myrg.location
    resource_group_name = azurerm_resource_group.myrg.name 

    ip_configuration {
      name      = "ipconfig1"
      subnet_id = azurerm_subnet.subnet[count.index].id
      private_ip_address_allocation = "Dynamic"
    }  
}

resource "azurerm_linux_virtual_machine" "vm" {
    count                   =  5
    name                    =  "nextopsvm-${count.index}"
    location                =  azurerm_resource_group.myrg.location
    resource_group_name     =  azurerm_resource_group.myrg.name
    size                    =  "Standard_B1s"
    admin_username          =  "azureadmin"
    network_interface_ids   = [azurerm_network_interface.nic[count.index].id,] 

    admin_ssh_key {
      username = "azureadmin"
      #ssh-keygen -t rsa -f C:\Terraform\SSHKeys\26122024\id_rsa
      public_key = file("C:/Terraform/SSHKeys/26122024/id_rsa.pub")
    }

    os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }
  
}