<#  
    .SYNOPSIS  
    This script helps get ALL tenant's role assignments.
  
    .DESCRIPTION  
    Please create an app registration, create a secret and assign proper MS Graph application permission to the app.
    Permission required: RoleManagement.Read.Directory
    Note down the client ID and secret to populate below.
    
    This script helps get ALL tenant's role assignments.
  
    .NOTES  
    Author: Haozhan Huang  
    Date: 2023-03-03
#>  

$client_id = "<Application ID>" 
$client_secret = "<Application Secret>" 
$login_url = "https://login.chinacloudapi.cn/"
$tenant_id = "<Your Tenant ID>" 
$resource = "https://microsoftgraph.chinacloudapi.cn"
$body = @{grant_type="client_credentials";resource=$resource;client_id=$client_id;client_secret=$client_secret}
$oauth = Invoke-RestMethod -Method Post -Uri $login_url/$tenant_id/oauth2/token?api-version=1.0 -Body $body
$token = $oauth.access_token

$cur_time = (Get-Date).ToString("yyyy-MM-dd_hh-mm-ss")

$temp = New-Object -TypeName psobject
$temp | Add-Member -MemberType noteproperty -Name 'Role Definition Id' -Value $null
$temp | Add-Member -MemberType noteproperty -Name 'Role Name' -Value $null
$temp | Add-Member -MemberType noteproperty -Name 'Principal Type' -Value $null 
$temp | Add-Member -MemberType noteproperty -Name 'Principal Id' -Value $null 
$temp | Add-Member -MemberType noteproperty -Name 'Display Name' -Value $null
$temp | Add-Member -MemberType noteproperty -Name 'User Principal Name' -Value $null 

if($token){
    $headers = @{
        Authorization = "Bearer $token"
        ContentType = "application/json"
    }
    $uri = "https://microsoftgraph.chinacloudapi.cn/beta/roleManagement/directory/roleDefinitions?`$select=id,displayName"
    $role_list = (Invoke-RestMethod -Method Get -Uri $uri -Headers $headers -ContentType Application/json).value | sort {$_.displayName}
    foreach($role in $role_list){
        Write-Host "Fetching role assignment for role $($role.displayName)"
        $assign_endp = "https://microsoftgraph.chinacloudapi.cn/v1.0/roleManagement/directory/roleAssignments?`$filter=roleDefinitionId eq '$($role.id)'&`$expand=principal"
        $assign_resp = Invoke-RestMethod -Method Get -Uri $assign_endp -Headers $headers -ContentType Application/json
        $temp."Role Definition Id" = $role.id
        $temp."Role Name" = $role.displayName
        foreach($assignment in $assign_resp.value){   
            switch ( $assignment.principal."@odata.type" )
            {
                "#microsoft.graph.user" {
                    $temp."Principal Type" = "User"
                    $temp."Principal Id" = $assignment.principal.id
                    $temp."Display Name" = $assignment.principal.displayName
                    $temp."User Principal Name" = $assignment.principal.userPrincipalName
                }
                "#microsoft.graph.group" {
                    $temp."Principal Type" = "Group"
                    $temp."Principal Id" = $assignment.principal.id
                    $temp."Display Name" = $assignment.principal.displayName
                    $temp."User Principal Name" = "N/A"
                }
                "#microsoft.graph.servicePrincipal" {
                    $temp."Principal Type" = "Service Principal"
                    $temp."Principal Id" = $assignment.principal.id
                    $temp."Display Name" = $assignment.principal.displayName
                    $temp."User Principal Name" = "N/A"
                }
            }
            $temp | Export-CSV -path ".\roles $cur_time.csv" -NoTypeInformation -Encoding UTF8 -Append
        }
    }
}
else{
    Write-Host No Access token
}
Write-Host Finished
