resource "azurerm_public_ip" "bastion-snooze" {
  name                = "pip-${var.ServiceName}-${var.EnvironmentPrefix}-001"
  location            = azurerm_resource_group.bastion-snooze.location
  resource_group_name = azurerm_resource_group.bastion-snooze.name
  allocation_method   = "Static"
  sku                 = "Standard"
}