# MIT License

# Copyright (c) Microsoft Corporation

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# This script imports the Microsoft Graph Identity Governance module, connects to Microsoft Graph with specific scopes, retrieves the role definition "Directory Readers" as example, lists role assignments for that role, and then categorizes and outputs the principal IDs of users, groups, and applications associated with those role assignments.


# Connect to Microsoft Graph  
Connect-MgGraph -Scopes "Directory.Read.All", "Directory.AccessAsUser.All", "RoleManagement.Read.All", "Group.Read.All", "Directory.Read.All", "RoleEligibilitySchedule.ReadWrite.Directory", "RoleManagement.Read.All", "RoleManagement.Read.Directory", "RoleManagement.ReadWrite.Directory", "PrivilegedEligibilitySchedule.ReadWrite.AzureADGroup"

# User UPN (User Principal Name)  
$upn = "xxxx@Mxxxxx.onmicrosoft.com"  
  
# Get the user object  
$user = Get-MgUser -Filter "userPrincipalName eq '$upn'"  
$userId = $user.Id  
  
# Check if the user exists  
if (-not $userId) {  
    Write-Output "User not found. Please check the UPN and try again."  
    exit  
}  
  
# Get all groups  
$groups = Get-MgGroup -All  
  
if (-not $groups) {  
    Write-Output "No groups found."  
    exit  
}  
  
# Initialize progress bar  
$groupCount = $groups.Count  
$counter = 0  
  
# Set global error handling  
$ErrorActionPreference = "SilentlyContinue"  
  
# Iterate over each group and get the PIM assignments for the group  
foreach ($group in $groups) {  
    $counter++  
    Write-Progress -Activity "Processing Groups" -Status "Processing $counter out of $groupCount groups" -PercentComplete (($counter / $groupCount) * 100)  
  
    $groupId = $group.Id  
  
    # Get all Group Eligibility Schedule Instances for the group  
    $pimGroupAssigns = Get-MgIdentityGovernancePrivilegedAccessGroupEligibilityScheduleInstance -Filter "groupId eq '$groupId'"  
  
    # If any instances found, process them  
    if ($pimGroupAssigns) {  
        # Iterate over each PIM assignment and check if it contains the specified user  
        foreach ($assign in $pimGroupAssigns) {  
            if ($assign.PrincipalId -eq $userId) {  
                $accessId = $assign.AccessId  
  
                # Display information  
                Write-Output "User: $upn"  
                Write-Output "Group: $($group.DisplayName)"  
                Write-Output "Group ID: $groupId"  
                Write-Output "Access: $accessId"  
            }  
        }  
    }  
}  
  
Write-Output "Scan complete."   
