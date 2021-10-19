# Mastering Azure Virtual Desktop Log Off User example
import-module az.DesktopVirtualization
import-module AzureAD


# Get the connection "AzureRunAsConnection"
$connectionName = "AzureRunAsConnection"
$servicePrincipalConnection = Get-AutomationConnection -Name $connectionName

$logonAttempt = 0
$logonResult = $False

while(!($connectionResult) -And ($logonAttempt -le 10))
{
    $LogonAttempt++
    #Logging in to Azure...
    $connectionResult = Connect-AzAccount `
                           -ServicePrincipal `
                           -Tenant $servicePrincipalConnection.TenantId `
                           -ApplicationId $servicePrincipalConnection.ApplicationId `
                           -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint

    Start-Sleep -Seconds 30
}

# Start AVD Task...

$ResourceGroupName = "avd01-avd" # <<<< enter resource group
$ExistingHostPool = Get-AzResource -ResourceGroupName $ResourceGroupName | Where-Object ResourceType -eq Microsoft.DesktopVirtualization/hostpools
 
if (($ExistingHostPool).count -gt "0") {
# Process to Log off connected Users
foreach($Hostpool in $ExistingHostPool){
 
$AVDUserSessions = Get-AzWvdUserSession -HostPoolName $HostPool.Name -ResourceGroupName $ResourceGroupName
$NumberofAVDSessions = ($AVDUserSessions).count # Counts sessions
 
if ($NumberofAVDSessions -gt "0") {
    try {
        Write-Host "There are a total of $NumberofAVDSessions logged on, these user sessions now will be logged off" # Admin message
 
        foreach ($AVDUserSession in $AVDUserSessions){
            
            $InputString = $AVDUserSession.Name
            $AVDUserArray = $InputString.Split("/")
            $AVDUserArray[0]
            $AVDUserArray[1]
            $AVDUserArray[2]
    
            Remove-AzWvdUserSession -HostPoolName $HostPool.Name -ResourceGroupName $ResourceGroupName -SessionHostName $AVDUserArray[1] -Id $AVDUserArray[2]
        }clear # clears powershell output
    }
	
    catch {
     
    }
}
}
}

