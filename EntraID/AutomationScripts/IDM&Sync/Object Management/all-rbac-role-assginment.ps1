<#  
    .SYNOPSIS  
    This script helps to retrieve all the RBAC role assignments from MG, Sub and RG.
  
    .DESCRIPTION  
    This script uses Az powershell module to retrieve all the RBAC role assignments from MG, Sub and RG.
    This script requires user signin.
  
    .NOTES  
    Author: Haozhan Huang  
    Date: 2022-08-22
#>  

Connect-AzAccount
# getting role assignments user all subs
$sub_list = Get-AzSubscription | Select-Object Name, Id

# handling swtiching context between subs
# getting role assignments on sub level
# getting role assignments on resource group level
foreach($sub in $sub_list){
    Write-Host Changing context to subscription $sub.Name -ForegroundColor "Yellow" -BackgroundColor "DarkRed"
    Set-AzContext -Subscription $sub.Id | Out-Null
    Write-Host Fetching role assignment on subscription $sub.Name
    Get-AzRoleAssignment -Scope "/subscriptions/$($sub.id)" -WarningAction SilentlyContinue | Select-Object DisplayName, SignInName, ObjectId, Scope, RoleDefinitionName | Export-CSV -Path ".\Sub_$($sub.Name)_role_assignment.csv" -NoTypeInformation -Encoding UTF8

    $rg_list = Get-AzResourceGroup | Select-Object ResourceGroupName, ResourceId 
    foreach($rg in $rg_list){
        Write-Host Fetching role assignment on resource group $rg.ResourceGroupName
        Get-AzRoleAssignment -Scope $rg.ResourceId -WarningAction SilentlyContinue | Select-Object DisplayName, SignInName, ObjectId, Scope, RoleDefinitionName | Export-CSV -Path ".\RG_$($rg.ResourceGroupName)_role_assignment.csv" -NoTypeInformation -Encoding UTF8
    }
}
Write-Host Finished fetching Subscription and Resource Group role assignments. -BackgroundColor "Green" -ForegroundColor "Magenta"

# getting role assignemtns on all management groups
$mg_list = Get-AzManagementGroup | Select-Object Name, DisplayName, Id
foreach($mg in $mg_list){
    Write-Host Fetching role assignment on Management Group $mg.DisplayName
    Get-AzRoleAssignment -Scope $mg.Id -WarningAction SilentlyContinue | Select-Object DisplayName, SignInName, ObjectId, Scope, RoleDefinitionName | Export-CSV -Path ".\MG_$($mg.DisplayName)_role_assignment.csv" -NoTypeInformation -Encoding UTF8
}
Write-Host Finished fetching Management Group role assignments. -BackgroundColor "Green" -ForegroundColor "Magenta"
