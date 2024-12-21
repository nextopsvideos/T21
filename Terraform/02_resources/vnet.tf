resource "azurerm_virtual_network" "myvnet" {
  name                = "NextOpsVNETT21"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name
  address_space       = ["10.0.0.0/16"]  

  tags = {
      "env" = "dev"
      "createby" = "Charan"
      "creationDate" = "12/19/2024"
  }
}

resource "azurerm_subnet" "subnet1" {
  name                  = "Subnet1"
  resource_group_name   = azurerm_resource_group.myrg.name
  virtual_network_name  = azurerm_virtual_network.myvnet.name
  address_prefixes      = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                  = "Subnet2"
  resource_group_name   = azurerm_resource_group.myrg.name
  virtual_network_name  = azurerm_virtual_network.myvnet.name
  address_prefixes      = ["10.0.1.0/24"]
}


resource "azurerm_network_security_group" "mynsg1" {
  name                = "nextopsnsgt21"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "subnet1assoc" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.mynsg1.id  
}

resource "azurerm_public_ip" "mypip1" {
  name = "NextOpsVMT21PIP1"
  location = azurerm_resource_group.myrg.location
  allocation_method = "Static"
  resource_group_name = azurerm_resource_group.myrg.name
}

resource "azurerm_network_interface" "mynic1" {
  name                = "NextOpsVMT21Nic1"
  location            = azurerm_resource_group.myrg.location
  resource_group_name = azurerm_resource_group.myrg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.mypip1.id
  }
}

