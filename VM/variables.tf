variable "azurerm_resource_group_prefix" { 
  type = object({
    name = string
    location = string
  })
    default = {
      name       = "example-resources"
      location       = "West Europe"
    }
    }

variable "azurerm_virtual_network_prefix" {
  type = object({
    name = string
  })
  default = {
  name                = "example-network"
  }
}

variable "azurerm_subnet_prefix"{
    type = object({
    name = string
  })
  default ={
  name                 = "internal"
  }
}
