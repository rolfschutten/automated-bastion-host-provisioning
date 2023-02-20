resource "azurerm_function_app_function" "bastion-snooze-create" {
  name            = "Create-Azure-Bastion"
  function_app_id = azurerm_windows_function_app.bastion-snooze.id
  language        = "PowerShell"

  file {
    name          = "run.ps1"
    content       = <<EOT
param($Timer)
$vNet = Get-AzVirtualNetwork -Name $env:BASTION_VNET_NAME -ResourceGroupName $env:BASTION_VNET_RG
$pip = Get-AzPublicIpAddress -Name $env:BASTION_PIP_NAME -ResourceGroupName $env:BASTION_PIP_RG
Set-AzContext -Subscription '${data.azurerm_subscription.current.display_name}'
New-AzBastion -Name $env:BASTION_NAME -ResourceGroupName $env:BASTION_RG -VirtualNetwork $vNet -PublicIpAddress $pip -AsJob
EOT
  }

  config_json = jsonencode({
    "bindings" = [
      {
        "direction" = "in"
        "name" = "Timer"
        "type" = "timerTrigger"
        "schedule" : "${var.CreateSchedule}"
      }
    ]
  })
}