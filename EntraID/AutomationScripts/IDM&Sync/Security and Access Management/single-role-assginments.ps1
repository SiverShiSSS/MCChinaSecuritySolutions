<#  
    .SYNOPSIS  
    This script helps get role assignments for a SINGLE role.
  
    .DESCRIPTION  
    Please create an app registration, create a secret and assign proper MS Graph application permission to the app.
    Permission required: RoleManagement.Read.Directory
    Note down the client ID and secret to populate below.
    
    This script helps get role assignments for a SINGLE role. Need to populate role name below.
  
    .NOTES  
    Author: Haozhan Huang
    Date: 2023-03-03
#>

$roleName = "<Role Name String>"
$client_id = "<Application ID>" 
$client_secret = "<Application Secret>" 
$login_url = "https://login.chinacloudapi.cn/"
$tenant_id = "<Your Tenant ID>" 
$resource = "https://microsoftgraph.chinacloudapi.cn"
$body = @{grant_type="client_credentials";resource=$resource;client_id=$client_id;client_secret=$client_secret}
$oauth = Invoke-RestMethod -Method Post -Uri $login_url/$tenant_id/oauth2/token?api-version=1.0 -Body $body
$token = $oauth.access_token


$cur_time = (Get-Date).ToString("yyyy-MM-dd_hh-mm-ss")
$roleDefEndp = "https://microsoftgraph.chinacloudapi.cn/v1.0/roleManagement/directory/roleDefinitions?`$filter=displayName eq '$roleName'&`$select=id"

$temp = New-Object -TypeName psobject
$temp | Add-Member -MemberType noteproperty -Name 'Role Definition Id' -Value $null
$temp | Add-Member -MemberType noteproperty -Name 'Principal Type' -Value $null 
$temp | Add-Member -MemberType noteproperty -Name 'Id' -Value $null 
$temp | Add-Member -MemberType noteproperty -Name 'Display Name' -Value $null
$temp | Add-Member -MemberType noteproperty -Name 'User Principal Name' -Value $null 

if($token){
    $headers = @{
        Authorization = "Bearer $token"
        ContentType = "application/json"
    }
    $roleDefId = (Invoke-RestMethod -Method Get -Uri $roleDefEndp -Headers $headers -ContentType Application/json).value.id
    $apiEndpoint = "https://microsoftgraph.chinacloudapi.cn/v1.0/roleManagement/directory/roleAssignments?`$filter=roleDefinitionId eq '$roleDefId'&`$expand=principal"
    $response = Invoke-RestMethod -Method Get -Uri $apiEndpoint -Headers $headers -ContentType Application/json
    $temp."Role Definition Id" = $response.value.roleDefinitionId
    foreach($assignment in $response.value){
        $temp."Role Definition Id" = $assignment.roleDefinitionId
        switch ( $assignment.principal."@odata.type" )
        {
            "#microsoft.graph.user" {
                # write-host user $assignment.principal.displayName
                $temp."Principal Type" = "User"
                $temp.Id = $assignment.principal.id
                $temp."Display Name" = $assignment.principal.displayName
                $temp."User Principal Name" = $assignment.principal.userPrincipalName
            }
            "#microsoft.graph.group" {
                # write-host group $assignment.principal.displayName
                $temp."Principal Type" = "Group"
                $temp.Id = $assignment.principal.id
                $temp."Display Name" = $assignment.principal.displayName
                $temp."User Principal Name" = "N/A"
            }
            "#microsoft.graph.servicePrincipal" {
                # write-host servicePrincipal $assignment.principal.displayName
                $temp."Principal Type" = "Service Principal"
                $temp.Id = $assignment.principal.id
                $temp."Display Name" = $assignment.principal.displayName
                $temp."User Principal Name" = "N/A"
            }
        }
        $temp | Export-CSV -path ".\$roleName $cur_time.csv" -NoTypeInformation -Encoding UTF8 -Append
    }
}
else{
    Write-Host No Access token
}
Write-Host Finished
