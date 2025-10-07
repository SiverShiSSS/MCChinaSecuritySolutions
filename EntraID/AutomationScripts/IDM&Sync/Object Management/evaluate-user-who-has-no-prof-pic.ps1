<#  
    .SYNOPSIS  
    This script helps retrieve all users that do NOT have profile picture.
  
    .DESCRIPTION  
    Please create an app registration, create a secret and assign proper MS Graph application permission to the app.
    Permission required: User.Read.All
    Note down the client ID and secret to populate below.
    
    This script helps retrieve all users that do NOT have profile picture.
  
    .NOTES  
    Author: Haozhan Huang
    Date: 2023-02-23
#>

$client_id = "<Application ID>" 
$client_secret = "<Application Secret>" 
$login_url = "https://login.chinacloudapi.cn/"
$tenant_id = "<Your Tenant ID>" 
$resource = "https://microsoftgraph.chinacloudapi.cn"
$body = @{grant_type="client_credentials";resource=$resource;client_id=$client_id;client_secret=$client_secret}
$oauth = Invoke-RestMethod -Method Post -Uri $login_url/$tenant_id/oauth2/token?api-version=1.0 -Body $body
$token = $oauth.access_token

$output = @()
$url = "$resource/beta/users?`$select=id,displayName,UserPrincipalName"
$header_params = @{'Authorization'="Bearer $token"}
do{
    $user_list = Invoke-RestMethod -Uri $url -Method Get -Headers $header_params -ContentType "application/json"
    foreach($user in $user_list.value){
        $pic_url = "$resource/beta/users/$($user.id)/photo/`$value"
        $pic = try { 
            (Invoke-WebRequest -Method Get -Headers $header_params -ContentType "application/json" -Uri $pic_url -ErrorAction SilentlyContinue).BaseResponse
        } catch [System.Net.WebException] { 
            Write-Verbose "An exception was caught: $($_.Exception.Message)"
            $_.Exception.Response 
        } 
        if($pic.StatusCode -eq "NotFound"){
            $output += $user
        }
        else{
            Write-Host User $user.displayName has profile picture
        }
    }
    $url = $user_list.'@odata.nextLink'
}while($url -ne $null)
$output | Export-CSV -NoTypeInformation -Path ".\UserWithoutProfilePicture.csv" -Append -Encoding UTF8
