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

#The purpose of this script is to update one attribute (example department) information for multiple users in Microsoft Graph based on data from a CSV file.

 # Sample CSV
UserPrincipalName,Department
john.doe@example.com,Sales
jane.smith@example.com,Marketing
alice.jones@example.com,Engineering
bob.brown@example.com,Finance

# Install module  
Install-Module Microsoft.Graph
  
# Connect to Microsoft Graph  
Connect-MgGraph -Scopes "User.ReadWrite.All"  
  
# Read the CSV file Need modify to a real path
$users = Import-Csv -Path "C:\xxx"  
  
# Loop through each user and update the department information  
foreach ($user in $users) {  
    try {  
        # Get UserPrincipalName and Department  
        $userPrincipalName = $user.UserPrincipalName  
        $department = $user.Department  
  
        # Update the user's Department property  
        Update-MgUser -UserId $userPrincipalName -Department $department  
        Write-Host "Successfully updated department for $userPrincipalName to $department"  
    }  
    catch {  
        Write-Host "Failed to update department for $userPrincipalName $_"  
    }  
}  

