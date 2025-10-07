<#  
    .SYNOPSIS  
    This script helps get license assignment for SINGLE license.
  
    .DESCRIPTION  
    Please create an app registration, create a secret and assign proper MS Graph application permission to the app.
    Permission required: User.Read.All
    Note down the client ID and secret to populate below.
    
    This script helps get license assignment for SINGLE license.
    Please change the skuid commented below.
  
    .NOTES  
    Author: Yanheng Liu
    Date: 2024-04-02
#>


$client_id = "<Application ID>" 
$client_secret = "<Application Secret>" 
$login_url = "https://login.chinacloudapi.cn/"
$tenant_id = "<Your Tenant ID>" 
$resource = "https://microsoftgraph.chinacloudapi.cn"
$body = @{grant_type="client_credentials";resource=$resource;client_id=$client_id;client_secret=$client_secret}
$oauth = Invoke-RestMethod -Method Post -Uri $login_url/$tenant_id/oauth2/token?api-version=1.0 -Body $body
$token = $oauth.access_token


$user_list = @()
if($token -ne $null){
    $header_params = @{
        'Authorization'="Bearer $token" 
        'ConsistencyLevel'="Eventual"
    }

    # change skuid accordingly
    $url = "$resource/v1.0/users?`$filter=assignedLicenses/any(s:s/skuid eq f30db892-07e9-47e9-837c-80727f46fd3d)&`$count=true&`$select=id,userPrincipalName"
    $license_resp = Invoke-RestMethod -Uri $url -Method Get -Headers $header_params -ContentType "application/json"
    $result_count = $license_resp."@odata.count"
    do{
        if($license_resp.value -ne $null){
            $user_list += $license_resp.value
            if($license_resp.'@odata.nextLink' -ne $null){
                $url = $license_resp.'@odata.nextLink'
                $license_resp = Invoke-RestMethod -Uri $url -Method Get -Headers $header_params -ContentType "application/json"
            }
            else{
                $url = $null
            }
        }
    }while($url -ne $null)
}
else{
    Write-Host "Error: No Access Token"
}
$user_list | Export-Csv -path ".\license_assignment.csv" -NoTypeInformation -Encoding UTF8
Write-Host Total usage of license: $result_count
Write-Host Assignment report exported
