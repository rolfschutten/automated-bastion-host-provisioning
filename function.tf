resource "azurerm_storage_account" "bastion-snooze" {
  name                     = "sa${var.ServiceName}${var.EnvironmentPrefix}001"
  resource_group_name      = azurerm_resource_group.bastion-snooze.name
  location                 = azurerm_resource_group.bastion-snooze.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "bastion-snooze" {
  name                = "asp-${var.ServiceName}-${var.EnvironmentPrefix}-001"
  resource_group_name = azurerm_resource_group.bastion-snooze.name
  location            = azurerm_resource_group.bastion-snooze.location
  os_type             = "Windows"
  sku_name            = "Y1"
}

resource "azurerm_windows_function_app" "bastion-snooze" {
  name                = "fun-${var.ServiceName}-${var.EnvironmentPrefix}-001"
  resource_group_name = azurerm_resource_group.bastion-snooze.name
  location            = azurerm_resource_group.bastion-snooze.location

  storage_account_name       = azurerm_storage_account.bastion-snooze.name
  storage_account_access_key = azurerm_storage_account.bastion-snooze.primary_access_key
  service_plan_id            = azurerm_service_plan.bastion-snooze.id

  site_config {
    application_stack {
      powershell_core_version = 7
    }
  }
  app_settings ={
    BASTION_VNET_NAME="vnet-${var.ServiceName}-${var.EnvironmentPrefix}-001"
    BASTION_VNET_RG="rg-${var.ServiceName}-${var.EnvironmentPrefix}-001"
    BASTION_PIP_NAME="pip-${var.ServiceName}-${var.EnvironmentPrefix}-001"
    BASTION_PIP_RG="rg-${var.ServiceName}-${var.EnvironmentPrefix}-001"
    BASTION_NAME="bh-${var.ServiceName}-${var.EnvironmentPrefix}-001"
    BASTION_RG="rg-${var.ServiceName}-${var.EnvironmentPrefix}-001"
    WEBSITE_TIME_ZONE="${var.Timezone}"     
  }
  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_role_assignment" "bastion-snooze" {
  principal_id                     = azurerm_windows_function_app.bastion-snooze.identity[0].principal_id
  role_definition_name             = "Contributor"
  scope                            = azurerm_resource_group.bastion-snooze.id
  depends_on                       = [azurerm_windows_function_app.bastion-snooze]
}