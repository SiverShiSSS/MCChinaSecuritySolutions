<#  
    .SYNOPSIS  
    This script helps to create pure cloud groups based off synced group.
  
    .DESCRIPTION  
    This script helps to create pure cloud group based off synced groups.
    This script will recreate cloud groups for ALL sync groups.
    This script uses user's permission.
  
    .NOTES  
    Author: Can Wu  
    Date: 2023-12-15
#>  

# use retrieved token to connect to MgGraph
Connect-MgGraph -Scopes "Group.ReadWrite.All"

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
