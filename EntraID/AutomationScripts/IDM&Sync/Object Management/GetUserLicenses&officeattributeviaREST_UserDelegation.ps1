# ============================================================================
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
# ============================================================================

# Connect to Microsoft Graph with required scopes, specifying beta profile
Connect-MgGraph -Environment china -Scopes "User.Read.All", "Directory.Read.All"
 
# Get all users with selected properties using Microsoft Graph PowerShell SDK (beta)
$licenseInfo = Get-MgUser -All -Property id,userPrincipalName,displayName,department,assignedLicenses |
   Select-Object UserPrincipalName,DisplayName,Department, @{
       Name = "Licenses"
       Expression = {$_.AssignedLicenses.SkuId}
   }, @{
       Name = "OfficeLocation"
       Expression = {
           # Use Graph REST API (beta) to get officeLocation for the user
           $userId = $_.id
           try {
               $response = Invoke-MgGraphRequest -Method GET -Uri "https://microsoftgraph.chinacloudapi.cn/beta/users/$userId`?`$select=officeLocation" -ErrorAction Stop
               return $response.officeLocation
           } catch {
               Write-Warning "Failed to retrieve officeLocation for user $userId`: $_"
               return $null
           }
       }
   }, @{
       Name = "EmployeeID"
       Expression = {
           # Use Graph REST API (beta) to get employeeId for the user
           $userId = $_.id
           try {
               $response = Invoke-MgGraphRequest -Method GET -Uri "https://microsoftgraph.chinacloudapi.cn/beta/users/$userId`?`$select=employeeId" -ErrorAction Stop
               return $response.employeeId
           } catch {
               Write-Warning "Failed to retrieve employeeId for user $userId`: $_"
               return $null
           }
       }
   }
 
# Get license information (SKUs) using beta endpoint
$licenses = Get-MgSubscribedSku
 
# Map SkuId to human-readable license names
$licenseMap = @{}
$licenses | ForEach-Object {
    $licenseMap[$_.SkuId] = $_.SkuPartNumber
}
$licenseInfo = $licenseInfo | Select-Object UserPrincipalName,DisplayName,Department, @{
    Name = "Licenses"
    Expression = {
        $skuIds = $_.Licenses
        ($skuIds | ForEach-Object { $licenseMap[$_] }) -join ", "
    }
}, OfficeLocation, EmployeeID
 
# Output the results
$licenseInfo
 
# Optional: Export to CSV
# $licenseInfo | Export-Csv -Path "UserLicenseInfo.csv" -NoTypeInformation
