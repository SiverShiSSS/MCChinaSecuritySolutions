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

# 連接參數
$tenantId = "your-tenant-id"              # 替換為你的租戶ID
$clientId = "your-client-id"              # 替換為你的服務主體應用ID
$clientSecret = "your-client-secret"      # 替換為你的客戶端密鑰

try {
    # 創建憑據並獲取訪問令牌
    $body = @{
        grant_type    = "client_credentials"
        client_id     = $clientId
        client_secret = $clientSecret
        scope         = "https://microsoftgraph.chinacloudapi.cn/.default"
    }
    $tokenResponse = Invoke-RestMethod -Uri "https://login.chinacloudapi.cn/$tenantId/oauth2/v2.0/token" -Method POST -Body $body -ErrorAction Stop
    $accessToken = $tokenResponse.access_token

    # 設置請求頭
    $headers = @{
        "Authorization" = "Bearer $accessToken"
        "Content-Type"  = "application/json"
    }

    # 獲取所有應用程式（App Registrations）
    $applications = @()
    $uri = "https://microsoftgraph.chinacloudapi.cn/v1.0/applications"
    do {
        $result = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get -ErrorAction Stop
        $applications += $result.value
        $uri = $result.'@odata.nextLink'
    } while ($uri)

    # 獲取所有服務主體（Enterprise Applications）
    $servicePrincipals = @()
    $uri = "https://microsoftgraph.chinacloudapi.cn/v1.0/servicePrincipals"
    do {
        $result = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get -ErrorAction Stop
        $servicePrincipals += $result.value
        $uri = $result.'@odata.nextLink'
    } while ($uri)

    # 獲取所有已授予的委托權限
    $permissionGrants = @()
    $uri = "https://microsoftgraph.chinacloudapi.cn/v1.0/oauth2PermissionGrants"
    do {
        $result = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get -ErrorAction Stop
        $permissionGrants += $result.value
        $uri = $result.'@odata.nextLink'
    } while ($uri)

    # 篩選多租戶應用程式
    $multiTenantApps = $applications | Where-Object { 
        $_.signInAudience -in @("AzureADMultipleOrgs", "AzureADandPersonalMicrosoftAccount")
    } | ForEach-Object {
        $appId = $_.appId
        # 查找對應的服務主體
        $sp = $servicePrincipals | Where-Object { $_.appId -eq $appId } | Select-Object -First 1
        # 獲取該應用的委托權限
        $appPermissionGrants = ($permissionGrants | Where-Object { $_.clientId -eq $sp.id } | ForEach-Object { $_.scope }) -join ", "
        # 獲取該應用的應用程式權限
        $appRoleAssignments = if ($sp) {
            $roles = Invoke-RestMethod -Uri "https://microsoftgraph.chinacloudapi.cn/v1.0/servicePrincipals/$($sp.id)/appRoleAssignments" -Headers $headers -Method Get -ErrorAction SilentlyContinue
            ($roles.value | ForEach-Object { $_.appRoleId }) -join ", "
        } else { "N/A" }
        
        [PSCustomObject]@{
            顯示名稱       = $_.displayName
            應用ID         = $_.appId
            登錄對象       = $_.signInAudience
            帳戶類型       = switch ($_.signInAudience) {
                "AzureADMultipleOrgs" { "多租戶 (任何 Microsoft Entra)" }
                "AzureADandPersonalMicrosoftAccount" { "多租戶 + 個人 Microsoft 帳戶" }
            }
            創建時間       = if ($_.createdDateTime) {[datetime]$_.createdDateTime} else {"N/A"}
            委托權限       = if ($appPermissionGrants) { $appPermissionGrants } else { "None" }
            應用程式權限   = if ($appRoleAssignments -ne "N/A") { $appRoleAssignments } else { "None" }
        }
    }

    # 篩選多租戶服務主體
    $multiTenantServicePrincipals = $servicePrincipals | Where-Object { 
        $_.signInAudience -in @("AzureADMultipleOrgs", "AzureADandPersonalMicrosoftAccount")
    } | ForEach-Object {
        $spId = $_.id
        # 獲取該服務主體的委托權限
        $spPermissionGrants = ($permissionGrants | Where-Object { $_.clientId -eq $spId } | ForEach-Object { $_.scope }) -join ", "
        # 獲取該服務主體的應用程式權限
        $spRoleAssignments = Invoke-RestMethod -Uri "https://microsoftgraph.chinacloudapi.cn/v1.0/servicePrincipals/$spId/appRoleAssignments" -Headers $headers -Method Get -ErrorAction SilentlyContinue
        $spRoleAssignments = ($spRoleAssignments.value | ForEach-Object { $_.appRoleId }) -join ", "
        
        [PSCustomObject]@{
            顯示名稱       = $_.displayName
            應用ID         = $_.appId
            服務主體ID     = $_.id
            登錄對象       = $_.signInAudience
            帳戶類型       = switch ($_.signInAudience) {
                "AzureADMultipleOrgs" { "多租戶 (任何 Microsoft Entra)" }
                "AzureADandPersonalMicrosoftAccount" { "多租戶 + 個人 Microsoft 帳戶" }
            }
            創建時間       = if ($_.createdDateTime) {[datetime]$_.createdDateTime} else {"N/A"}
            委托權限       = if ($spPermissionGrants) { $spPermissionGrants } else { "None" }
            應用程式權限   = if ($spRoleAssignments) { $spRoleAssignments } else { "None" }
        }
    }

    # 顯示結果
    Write-Host "多租戶應用程式（App Registrations）：" -ForegroundColor Green
    $multiTenantApps | Format-Table -Property 顯示名稱, 應用ID, 登錄對象, 帳戶類型, 創建時間, 委托權限, 應用程式權限 -AutoSize

    Write-Host "多租戶企業應用程式（Enterprise Applications）：" -ForegroundColor Green
    $multiTenantServicePrincipals | Format-Table -Property 顯示名稱, 應用ID, 服務主體ID, 登錄對象, 帳戶類型, 創建時間, 委托權限, 應用程式權限 -AutoSize

    # 匯出到CSV，包含時間戳
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $multiTenantApps | Export-Csv -Path "MultiTenantAppRegistrations_$timestamp.csv" -NoTypeInformation -Encoding UTF8
    $multiTenantServicePrincipals | Export-Csv -Path "MultiTenantEnterpriseApps_$timestamp.csv" -NoTypeInformation -Encoding UTF8

    Write-Host "已導出結果到 MultiTenantAppRegistrations_$timestamp.csv 和 MultiTenantEnterpriseApps_$timestamp.csv" -ForegroundColor Green

} catch {
    Write-Error "發生錯誤: $($_.Exception.Message)"
    exit 1
}