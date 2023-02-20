resource "azurerm_virtual_network" "bastion-snooze" {
  name                = "vnet-${var.ServiceName}-${var.EnvironmentPrefix}-001"
  address_space       = ["172.${var.VNetPrefixSecondOctet}.${var.VNetPrefixThirdOctet}.0/22"]
  location            = azurerm_resource_group.bastion-snooze.location
  resource_group_name = azurerm_resource_group.bastion-snooze.name
}