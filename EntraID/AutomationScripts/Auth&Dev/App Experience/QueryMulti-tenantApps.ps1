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

# 創建憑據並獲取訪問令牌
$body = @{
    grant_type    = "client_credentials"
    client_id     = $clientId
    client_secret = $clientSecret
    scope         = "https://microsoftgraph.chinacloudapi.cn/.default"
}
$tokenResponse = Invoke-RestMethod -Uri "https://login.chinacloudapi.cn/$tenantId/oauth2/v2.0/token" -Method POST -Body $body $accessToken = $tokenResponse.access_token

# 設置請求頭
$headers = @{
    "Authorization" = "Bearer $accessToken"
    "Content-Type"  = "application/json"
}

# 獲取所有應用程式
$applications = @()
$uri = "https://microsoftgraph.chinacloudapi.cn/v1.0/applications"
do {
    $result = Invoke-RestMethod -Uri $uri -Headers $headers -Method Get
    $applications += $result.value
    $uri = $result.'@odata.nextLink'
} while ($uri)

# 篩選多租戶應用
$multiTenantApps = $applications | Where-Object { 
    $_.signInAudience -eq "AzureADMultipleOrgs" -or 
    $_.signInAudience -eq "AzureADandPersonalMicrosoftAccount" 
} | Select-Object -Property @{
    Name = "顯示名稱"                   # 原 DisplayName
    Expression = {$_.displayName}
}, @{
    Name = "應用ID"                     # 原 AppId
    Expression = {$_.appId}
}, @{
    Name = "登錄對象"                   # 原 SignInAudience
    Expression = {$_.signInAudience}
}, @{
    Name = "帳戶類型"                   # 原 AccountType
    Expression = {
        switch ($_.signInAudience) {
            "AzureADMultipleOrgs"             { "多租戶 (任何 Microsoft Entra)" }
            "AzureADandPersonalMicrosoftAccount" { "多租戶 + 個人 Microsoft 帳戶" }
        }
    }
}, @{
    Name = "創建時間"                   # 原 CreatedDateTime
    Expression = {$_.createdDateTime}
}

# 顯示結果
$multiTenantApps | Format-Table -Property 顯示名稱, 應用ID, 登錄對象, 帳戶類型, 創建時間 -AutoSize

# 可選：匯出到CSV
$multiTenantApps | Export-Csv -Path "MultiTenantApps.csv" -NoTypeInformation -Encoding UTF8
