resource "azurerm_subnet" "bastion-snooze-servers" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.bastion-snooze.name
  virtual_network_name = azurerm_virtual_network.bastion-snooze.name
  address_prefixes     = ["172.${var.VNetPrefixSecondOctet}.${(var.VNetPrefixThirdOctet+2)}.0/26"]
}