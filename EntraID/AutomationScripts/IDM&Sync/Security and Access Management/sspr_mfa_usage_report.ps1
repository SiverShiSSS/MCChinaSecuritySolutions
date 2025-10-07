<#  
    .SYNOPSIS  
    This script helps getting usage report for SSPR as well as other MFA methods.
  
    .DESCRIPTION  
    Please create an app registration, create a secret and assign proper MS Graph application permission to the app.
    Permission required: UserAuthenticationMethod.Read.All, AuditLog.Read.All
    Note down the client ID and secret to populate below.
    
    This script helps getting usage report for SSPR as well as other MFA methods.
  
    .NOTES  
    Author: Haozhan Huang  
    Date: 2022-11-14
#>  

$client_id = "<Application ID>" 
$client_secret = "<Application Secret>" 
$login_url = "https://login.chinacloudapi.cn/"
$tenant_id = "<Your Tenant ID>" 
$resource = "https://microsoftgraph.chinacloudapi.cn"
$body = @{grant_type="client_credentials";resource=$resource;client_id=$client_id;client_secret=$client_secret}
$oauth = Invoke-RestMethod -Method Post -Uri $login_url/$tenant_id/oauth2/token?api-version=1.0 -Body $body
$token = $oauth.access_token

$url = "$resource/beta/reports/authenticationMethods/userRegistrationDetails"
$cur_time = Get-Date -Format "yyyy-MM-ddTHH-mm-ss"
if($token -ne $null){
    $header_params = @{'Authorization'="Bearer $token"}
    Do{
        $report = Invoke-RestMethod -Uri $url -Method Get -Headers $header_params -ContentType "application/json"
        $report.Value | foreach{ $_.methodsRegistered =  $_.methodsRegistered -join ','} 
        $report.Value | Export-Csv -NoTypeInformation -Path ".\Auth_Method_Report_$cur_time.csv" -Append -Encoding UTF8
        $url = $report.'@odata.nextLink'
    }while($url -ne $null)
}
else{
    Write-Host "Error: No Access Token"
}
