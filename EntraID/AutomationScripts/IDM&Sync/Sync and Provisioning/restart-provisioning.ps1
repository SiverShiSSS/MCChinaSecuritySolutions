<#  
    .SYNOPSIS  
    This script helps to restart provisioning service.
  
    .DESCRIPTION  
    This script helps to restart provisioning service.
    Reason this script exists: section <Member of group not provisioned>
    Doc ref: https://learn.microsoft.com/en-us/entra/identity/app-provisioning/known-issues?pivots=app-provisioning#member-of-group-not-provisioned
    This script can be put into a task scheduler to help restart provisioing service periodically.

    Prerequisite:
    - Prepare an app registration
    - Generate a secret for the app registration
    - Grant MS Graph APPLICATION permission Directory.ReadWrite.All (Synchronization.ReadWrite.All) to the app

    .NOTES  
    Author: Haozhan Huang  
    Date: 2022-08-01
#>  


$client_id = "<Application ID>" # please populate your application ID
$client_secret = "<Application Secret>" # please populate your application secret
$tenant_id = "<Your Tenant ID>" # please populate your tenant id
$login_url = "https://login.chinacloudapi.cn/"
$resource = "https://microsoftgraph.chinacloudapi.cn"
$body = @{grant_type="client_credentials";resource=$resource;client_id=$client_id;client_secret=$client_secret}
$oauth = Invoke-RestMethod -Method Post -Uri $login_url/$tenant_id/oauth2/token?api-version=1.0 -Body $body
$token = $oauth.access_token


# side note on body
# available criteria include: None, Escrows, Watermark, QuarantineStates, ForceDeletes, Full
# reference can be found in synchronizationJobRestartCriteria resource type
$body = @{
    criteria = @{
        resetScope = 'Full'
    }
} | ConvertTo-Json 


$sp_id = "<service principal object id of the application>"
$job_id = "<run profile id>"
$job_url = "$resource/beta/servicePrincipals/$sp_id/synchronization/jobs/$job_id/restart"
if($token -ne $null){
    $header_params = @{'Authorization'="Bearer $token"}
    Invoke-RestMethod -Uri $job_url -Method Post -Headers $header_params -ContentType "application/json"
    write-host Restart Completed...
}
else{
    Write-Host "Error: No Access Token"
}