resource "azurerm_function_app_function" "bastion-snooze-delete" {
  name            = "Delete-Azure-Bastion"
  function_app_id = azurerm_windows_function_app.bastion-snooze.id
  language        = "PowerShell"

  file {
    name          = "run.ps1"
    content       = <<EOT
param($Timer)
Set-AzContext -Subscription '${data.azurerm_subscription.current.display_name}'
Remove-AzBastion -Name $env:BASTION_NAME -ResourceGroupName $env:BASTION_RG -Force
EOT
  }

  config_json = jsonencode({
    "bindings" = [
      {
        "direction" = "in"
        "name" = "Timer"
        "type" = "timerTrigger"
        "schedule" : "${var.DeleteSchedule}"
      }
    ]
  })
}