<#  
    .SYNOPSIS  
    This script helps to pull all tenant users' last signin info.
  
    .DESCRIPTION  
    This script uses MgGraph powershell module to pull last signin info for all users in a tenant.
    This script requires user signin.
  
    .NOTES  
    Author: Haozhan Huang  
    Date: 2022 
#>  

$scp = @("AuditLog.Read.All", "User.Read.All")
Connect-MgGraph -Environment china -Scopes $scp
$path = "C:\temp" #path to store exported CSV
$date = Get-Date -Format "yyyy-MM-dd HHmmss"
#EXTRA CAUTION: below string need to be quoted
$url = "https://microsoftgraph.chinacloudapi.cn/beta/users?`$select=displayName,userPrincipalName,id,signInActivity"

$output = @()
do{
    $sign_in = Invoke-MgGraphRequest -Uri $url -Method Get
    if($sign_in -ne $null){
        foreach($record in $sign_in.value){
            $temp = New-Object PSObject -Property @{
                id=$record.id
                displayName=$record.displayName
                userPrincipalName=$record.userPrincipalName
                lastSignInDateTime=$record.signInActivity.lastSignInDateTime
            }
            $output += $temp
        }
        $url = $sign_in.'@odata.nextLink' #MS Graph paging handling
    }
}while($url -ne $null) #MS Graph paging handling
$output | Export-CSV -NoTypeInformation -Path "$path\last_sign_in_report $date.csv" -Append -Encoding UTF8
Write-Host Finished!
