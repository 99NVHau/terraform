
## Create 2 virtual machine with 2 ip public
resource "azurerm_resource_group" "example" {
  name     = var.azurerm_resource_group_prefix.name
  location = var.azurerm_resource_group_prefix.location
}

resource "azurerm_virtual_network" "example" {
  name                = var.azurerm_virtual_network_prefix.name
  address_space       = ["10.0.0.0/16"]
  location            = var.azurerm_resource_group_prefix.location
  resource_group_name = var.azurerm_resource_group_prefix.name
}

resource "azurerm_subnet" "example" {
  name                 = var.azurerm_subnet_prefix.name
  resource_group_name  = var.azurerm_resource_group_prefix.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}
resource "azurerm_network_interface" "example" {
  name                = "example-nic"
  location            = var.azurerm_resource_group_prefix.location
  resource_group_name = var.azurerm_resource_group_prefix.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id   =   azurerm_public_ip.myvm1publicip.id
  }
}
resource "azurerm_network_interface" "example2" {
  name                = "example-nic2"
  location            = var.azurerm_resource_group_prefix.location
  resource_group_name = var.azurerm_resource_group_prefix.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id   =   azurerm_public_ip.myvm1publicip2.id
  }
}
resource   "azurerm_public_ip" "myvm1publicip2"   { 
   name   =   "pip2" 
   location   =   var.azurerm_resource_group_prefix.location 
   resource_group_name   =   var.azurerm_resource_group_prefix.name 
   allocation_method   =   "Dynamic" 
   sku   =   "Basic" 
 } 
resource   "azurerm_public_ip" "myvm1publicip"   { 
   name   =   "pip1" 
   location   =   var.azurerm_resource_group_prefix.location 
   resource_group_name   =   var.azurerm_resource_group_prefix.name 
   allocation_method   =   "Dynamic" 
   sku   =   "Basic" 
 } 

resource "azurerm_linux_virtual_machine" "example" {
  name                = "example-machine"
  resource_group_name = var.azurerm_resource_group_prefix.name
  location            = var.azurerm_resource_group_prefix.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [ azurerm_network_interface.example.id ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

}
  resource "azurerm_linux_virtual_machine" "example2" {
  name                = "example-machine2"
  resource_group_name = var.azurerm_resource_group_prefix.name
  location            = var.azurerm_resource_group_prefix.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [ azurerm_network_interface.example2.id ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}