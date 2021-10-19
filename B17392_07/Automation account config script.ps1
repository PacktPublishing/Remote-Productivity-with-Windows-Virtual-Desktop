$Params = @{
     "AADTenantId"           = "<Enter Azure AD Tenant>"   # Optional. If not specified, it will use the current Azure context
     "SubscriptionId"        = "<Enter Subscription ID>"              # Optional. If not specified, it will use the current Azure context
     "UseARMAPI"             = $true
     "ResourceGroupName"     = "avdautomation"                # Optional. Default: "WVDAutoScaleResourceGroup"
     "AutomationAccountName" = "avdautoscale"            # Optional. Default: "WVDAutoScaleAutomationAccount"
     "Location"              = "<Enter a Azure Region>"
    }

.\CreateOrUpdateAzAutoAccount.ps1 @Params