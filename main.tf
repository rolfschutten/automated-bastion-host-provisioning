data "azurerm_subscription" "current" { }

resource "azurerm_resource_group" "bastion-snooze" {
  name     = "rg-${var.ServiceName}-${var.EnvironmentPrefix}-001"
  location = "${var.Location}"
}