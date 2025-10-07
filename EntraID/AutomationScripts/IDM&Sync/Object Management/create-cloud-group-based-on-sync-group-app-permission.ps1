<#  
    .SYNOPSIS  
    This script helps to create pure cloud groups based off synced groups.
  
    .DESCRIPTION  
    This script helps to create pure cloud groups based off synced groups.
    This script will recreate cloud groups for ALL sync groups.
    Please create an app registration, create a secret and assign proper MS Graph application permission to the app.
    Note down the client ID and secret to populate below.
  
    .NOTES  
    Author: Can Wu  
    Date: 2023-12-15
#>  

# client credential flow to retrieve access token
$clientID = "" # app reg's client ID
$tenantName = "" # tenant ID
$ClientSecret = "" # app reg's secret

$ReqTokenBody = @{
    Grant_Type = "client_credentials"
    Scope = "https://microsoftgraph.chinacloudapi.cn/.default"
    client_Id = $clientID
    Client_Secret = $clientSecret
}
$TokenResponse = Invoke-RestMethod -Uri "https://login.chinacloudapi.cn/$tenantName/oauth2/v2.0/token" -Method POST -Body $ReqTokenBody

# use retrieved token to connect to MgGraph
Connect-MgGraph -AccessToken $Tokenresponse.access_token

# fetching all the synced groups
$groupslist=get-mggroup -filter "OnPremisesSyncEnabled eq true" | Select-Object DisplayName,Id,MailNickname

# iterate groups
foreach($group in $groupslist){
    $newgroup=New-MgGroup -DisplayName $group.DisplayName -SecurityEnabled -MailEnabled:$False -MailNickName $group.MailNickname
    $members=get-mggroupmember -GroupId $group.Id
    #iterate members and add into newly created cloud group
    foreach($member in $members){
        New-MgGroupMember -GroupId $newgroup.Id -DirectoryObjectId $member.Id
    }
}
