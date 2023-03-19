resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
module "azurerm_sql_server_module" {
  source = "../SQLServer"
}
resource "azurerm_sql_database" "example" {
  name                = "myexamplesqldatabase"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  server_name         = module.azurerm_sql_server_module.server_name

  tags = {
    environment = "production"
  }
}