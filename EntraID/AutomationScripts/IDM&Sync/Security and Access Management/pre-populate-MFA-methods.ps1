<#  
    .SYNOPSIS  
    This script helps to pre-populte user's MFA methods so user doesn't need to register.
  
    .DESCRIPTION  
    Please create an app registration, create a secret and assign proper MS Graph application permission to the app.
    Permission required: UserAuthenticationMethod.ReadWrite.All
    Note down the client ID and secret to populate below.
    
    This only applies to adding phone and email as Authentication methods
    If combined registration is enabled, the end user will not get asked to register SSPR upon login.
    You will need to populate a csv file. With format like below. (fields, beside UPN, can be empty)
    | userPrincipalName | email |  phone  | alt_phone | office_phone |
    |  un1@domain.com   |  xxx  | +xx xx  |  +xx xx   |    +xx xx    |
  
    .NOTES  
    Author: Haozhan Huang  
    Date: 2022-06-08
#>  

$client_id = "<Application ID>" 
$client_secret = "<Application Secret>" 
$login_url = "https://login.chinacloudapi.cn/"
$tenant_id = "<Your Tenant ID>" 
$resource = "https://microsoftgraph.chinacloudapi.cn"
$body = @{grant_type="client_credentials";resource=$resource;client_id=$client_id;client_secret=$client_secret}
$oauth = Invoke-RestMethod -Method Post -Uri $login_url/$tenant_id/oauth2/token?api-version=1.0 -Body $body
$token = $oauth.access_token

# Change the path to your CSV file
$mfa_list = import-csv -path ".\mfa.csv" -Encoding utf8

if($token){
    $header_params = @{'Authorization'="Bearer $token"}
    foreach($record in $mfa_list){
        $phone_url = "$resource/beta/users/$($record.userPrincipalName)/authentication/phoneMethods"
        $mail_url = "$resource/beta/users/$($record.userPrincipalName)/authentication/emailMethods"
        Write-Host "Adding Authentication Method for user: $($record.userPrincipalName)"
        if($record.phone){
            $phone_body = @{
                phoneNumber = $record.phone
                phoneType = "mobile"
            } | ConvertTo-Json
            Invoke-RestMethod -Method Post -Uri $phone_url -Headers $header_params -Body $phone_body
        }
        if($record.alt_phone){
            $alt_phone_body = @{
                phoneNumber = $record.alt_phone
                phoneType = "alternateMobile"
            } | ConvertTo-Json
            Invoke-RestMethod -Method Post -Uri $phone_url -Headers $header_params -Body $alt_phone_body
        }
        
        if($record.office_phone){
            $office_body = @{
                phoneNumber = $record.office_phone
                phoneType = "office"
            } | ConvertTo-Json
            Invoke-RestMethod -Method Post -Uri $phone_url -Headers $header_params -Body $office_body
        }
        
        if($record.email){
            $mail_body = @{
                emailAddress = $record.email
            } | ConvertTo-Json
            Invoke-RestMethod -Method Post -Uri $mail_url -Headers $header_params -Body $mail_body
        }
    }
}
else{
    Write-Host No Access token
}
Write-Host Finished