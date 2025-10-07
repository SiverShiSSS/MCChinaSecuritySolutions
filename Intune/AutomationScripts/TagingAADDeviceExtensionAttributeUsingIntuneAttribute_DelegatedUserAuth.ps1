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

# Connect to Microsoft Graph (21V Mooncake)
Connect-MgGraph -Environment china -Scopes "Directory.AccessAsUser.All", "Device.ReadWrite.All", "DeviceManagementManagedDevices.Read.All", "Directory.ReadWrite.All"

##############################################################################
# 1) Function: Get the primary user of an Intune-managed device
##############################################################################
function Get-IntuneDevicePrimaryUser {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$IntuneDeviceId  # Intune device's 'id' field
    )

    $uri = "https://microsoftgraph.chinacloudapi.cn/beta/deviceManagement/managedDevices/$IntuneDeviceId/users"

    try {
        $response = Invoke-MgGraphRequest -Method GET -Uri $uri
        return $response.value | Select-Object -First 1
    }
    catch {
        Write-Host "Failed to get primary user for device ID: $IntuneDeviceId. Error: $_" -ForegroundColor Red
        return $null
    }
}

##############################################################################
# 2) Main Script
##############################################################################
$AttributeName = "extensionAttribute1"
# Input the extension attribute name you want to update

$DeviceOSType = "iOS"
# Input the Device OS type you want to update

Write-Host "Fetching Intune devices where Operating System is '$DeviceOSType'..."

# Example: Using a $filter to only get devices of the specified OS type.
$uri = "https://microsoftgraph.chinacloudapi.cn/beta/deviceManagement/managedDevices?`$filter=operatingSystem eq '$($DeviceOSType)'"
$totalDevices = 0

while ($uri) {
    # A) Retrieve Intune devices using pagination
    $response = Invoke-MgGraphRequest -Method GET -Uri $uri

    if ($response.value) {
        foreach ($device in $response.value) {
            $totalDevices++

            try {
                # (1) Get the primary user of the current Intune device
                $primaryUser = Get-IntuneDevicePrimaryUser -IntuneDeviceId $device.id
                if ($primaryUser) {
                    $upn = $primaryUser.userPrincipalName
                }
                else {
                    Write-Host "No primary user found for device '$($device.deviceName)'" -ForegroundColor Yellow
                    continue
                }

                # (2) Retrieve azureActiveDirectoryDeviceId from the Intune device
                $aadDevId = $device.azureActiveDirectoryDeviceId
                if ([string]::IsNullOrWhiteSpace($aadDevId)) {
                    Write-Host "No azureActiveDirectoryDeviceId for device '$($device.deviceName)'. Skipping..."
                    continue
                }

                # (3) Use filter to find the device in AAD (Entra)
                Write-Host "`nLooking up AAD device: deviceId eq '$aadDevId'..."
                $aadDeviceList = Get-MgDevice -Filter "deviceId eq '$($aadDevId)'"

                if (-not $aadDeviceList -or $aadDeviceList.Count -eq 0) {
                    Write-Host "No AAD device found for deviceId '$aadDevId'. Skipping..."
                    continue
                }
                if ($aadDeviceList.Count -gt 1) {
                    Write-Host "Multiple AAD devices found for deviceId '$aadDevId'. Using the first match." -ForegroundColor Yellow
                }

                # (4) Take the first record (usually there is only one)
                $aadDevice = $aadDeviceList | Select-Object -First 1
                $objectID = $aadDevice.Id
                if ([string]::IsNullOrEmpty($objectID)) {
                    Write-Host "WARNING: The returned device has an empty .Id property. Skipping..."
                    continue
                }

                Write-Host "objectID = $objectID"

                # (4.1) Retrieve the current device details from v1.0 endpoint
                $deviceUri = "https://microsoftgraph.chinacloudapi.cn/v1.0/devices/$objectID"
                try {
                    $currentDevice = Invoke-MgGraphRequest -Method GET -Uri $deviceUri
                }
                catch {
                    Write-Host "Failed to retrieve current details for device $objectID. Error: $_" -ForegroundColor Red
                    continue
                }

                # (4.2) Check if extensionAttribute1 is already set to the primary user's UPN
                $currentValue = $null
                if ($currentDevice.extensionAttributes) {
                    $currentValue = $currentDevice.extensionAttributes.$AttributeName
                }

                if ($currentValue -eq $upn) {
                    Write-Host "Skipping update for AAD Device ID = $objectID because $AttributeName is already set to '$upn'" -ForegroundColor Yellow
                    continue
                }

                # (5) Update the extension attribute via PATCH since the value is different
                Write-Host "Updating $AttributeName for AAD Device ID = $objectID..."
                $patchUri = "https://microsoftgraph.chinacloudapi.cn/v1.0/devices/$objectID"
                $body = @{
                    extensionAttributes = @{
                        "$AttributeName" = "$upn"
                    }
                } | ConvertTo-Json -Depth 2

                try {
                    Invoke-MgGraphRequest -Method PATCH -Uri $patchUri -Body $body
                    Write-Host "Successfully updated $AttributeName for AAD object ID: $objectID" -ForegroundColor Green
                }
                catch {
                    Write-Host "Failed to update $AttributeName for AAD object ID: $objectID. Error: $_" -ForegroundColor Red
                }
            }
            catch {
                Write-Host "Error processing device '$($device.deviceName)': $_" -ForegroundColor Red
            }
        }
    }
    else {
        Write-Host "No devices found in this page of results." -ForegroundColor Yellow
    }

    # B) Check pagination
    if ($response.'@odata.nextLink') {
        $uri = $response.'@odata.nextLink'
    }
    else {
        $uri = $null
    }
}

Write-Host "Processed $totalDevices Intune devices in total."
