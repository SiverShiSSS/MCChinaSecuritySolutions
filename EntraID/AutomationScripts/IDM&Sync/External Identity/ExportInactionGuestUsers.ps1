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

#Parameters
$InactiveDays = 60 # Replace the days based on your requirement.
$CSVPath = "C:\Temp\InactiveGuestUsers.csv" # Replace with the desired CSV path for guest users
$InactiveGuestUsers = @()
$ThresholdDate = (Get-Date).AddDays(-$InactiveDays)

#Connect to Microsoft Graph with the required scopes
Connect-MgGraph -Scopes "AuditLog.Read.All", "User.Read.All"

#Properties to Retrieve
$Properties = @(
    'Id','DisplayName','Mail','UserPrincipalName','UserType', 'AccountEnabled', 'SignInActivity'   
)

#Get All users along with the properties
$AllUsers = Get-MgUser -All -Property $Properties

ForEach ($User in $AllUsers)
{
    # Check if the user is a guest user
    if ($User.UserType -eq 'Guest') {
        $LastLoginDate = $User.SignInActivity.LastSignInDateTime
        if($LastLoginDate -eq $null)
        {
            $LastSignInDate = "Never Signed-in!"
        }
        else
        {
            $LastSignInDate = $LastLoginDate
        }

        # Calculate the number of inactive days
        $InactiveDays = if ($LastLoginDate) {
            (Get-Date).Subtract($LastLoginDate).Days
        } else {
            "Never Signed-in!"
        }

        # Collect data for inactive guest users
        if(!$LastLoginDate -or ($LastLoginDate -and ((Get-Date $LastLoginDate) -lt $ThresholdDate)))
        {
            $InactiveGuestUsers += [PSCustomObject][ordered]@{
                LoginName       = $User.UserPrincipalName
                Email           = $User.Mail
                DisplayName     = $User.DisplayName
                UserType        = $User.UserType
                AccountEnabled  = $User.AccountEnabled
                LastSignInDate  = $LastSignInDate
                InactiveDays    = $InactiveDays
            }
        }
    }
}

$InactiveGuestUsers

#Export Data to CSV
$InactiveGuestUsers | Export-Csv -Path $CSVPath -NoTypeInformation

