data "azurerm_app_service" "example" {
  name                = "example-resources"
  resource_group_name = "West Europe"
}

output "app_service_id" {
  value = data.azurerm_app_service.example.id
}