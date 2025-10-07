# MIT License

Copyright (c) Microsoft Corporation

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

# This script imports the Microsoft Graph Identity Governance module, connects to Microsoft Graph with specific scopes, retrieves the role definition "Directory Readers" as example, lists role assignments for that role, and then categorizes and outputs the principal IDs of users, groups, and applications associated with those role assignments.

# Install module  
Install-Module Microsoft.Graph

# Import identity governace module
Import-Module Microsoft.Graph.Identity.Governance

# Connect to Microsoft Graph"
Connect-MgGraph -Scopes "EntitlementManagement.Read.All", "EntitlementManagement.ReadWrite.All","Application.Read.All", "GroupMember.Read.All", "Group.Read.All", "Directory.Read.All","User.ReadBasic.All"

##############################################################################

# Retrieve the role definition with the specified display name, the example is "directory reader"
$roleDefinition = Get-MgRoleManagementDirectoryRoleDefinition -Filter "displayName eq 'Directory Readers'"

# defined the role id
$roleDefinitionId = $roleDefinition.id

#Retrieve the list of role assignments for the specified role definition ID  
$ListroleAssignment = Get-MgRoleManagementDirectoryRoleAssignment -Filter "roleDefinitionId eq '$roleDefinitionId'" 
 
# Initialize arrays to store user, group, and application principal IDs  
$userPrincipalIds = @()  
$groupPrincipalIds = @()  
$appPrincipalIds = @()  

# Loop through each role assignment  
foreach ($assignment in $ListroleAssignment) {  
    # Get the principal ID  
    $principalId = $assignment.PrincipalId  
    # Check if the principal ID is a user  
    try {  
        $user = Get-MgUser -UserId $principalId -ErrorAction Stop  
        # If successful, add to the array of user principal IDs  
        $userPrincipalIds += $principalId  
        continue  
    }  
    catch {  
        # If there is an error, it may mean the principal ID is not a user, continue to check if it's a group  
    }  
    # Check if the principal ID is a group  
    try {  
        $group = Get-MgGroup -GroupId $principalId -ErrorAction Stop  
        # If successful, add to the array of group principal IDs  
        $groupPrincipalIds += $principalId  
        continue  
    }  
    catch {  
        # If there is an error, it may mean the principal ID is not a group, continue to check if it's an application  
    }  
    # Check if the principal ID is an application  
    try {  
        $app = Get-MgServicePrincipal -ServicePrincipalId $principalId -ErrorAction Stop  
        # If successful, add to the array of application principal IDs  
        $appPrincipalIds += $principalId  
    }  
    catch {  
        # If there is an error, it means the principal ID is neither a user, group, nor an application, continue to the next item  
        continue  
    }  
    
}  
# Output the user, group, and application principal IDs  
Write-Output "User Principal IDs:"  
$userPrincipalIds  
Write-Output "Group Principal IDs:"  
$groupPrincipalIds  
Write-Output "Application Principal IDs:"  
$appPrincipalIds  