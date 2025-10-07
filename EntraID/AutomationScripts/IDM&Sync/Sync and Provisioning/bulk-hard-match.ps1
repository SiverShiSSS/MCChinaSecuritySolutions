<#  
    .SYNOPSIS  
    This script automates the hard-matching of on-premises AD users with Azure AD users by setting the ImmutableID.
  
    .DESCRIPTION  
    This script retrieves users from a list of UPNs, calculates their ImmutableID from AD ObjectGUID,
    and updates their Azure AD accounts accordingly to enable hard-matching between on-premises AD and Azure AD.
    The script requires Microsoft Graph PowerShell SDK and Active Directory module.
    All operations are logged to a timestamped log file.
  
    .NOTES  
    Author: Ray
    Date: 2024-12-29
    
    .REQUIREMENTS
    - Microsoft Graph PowerShell SDK (Microsoft.Graph.Users)
    - Active Directory PowerShell Module
    - Global Admin or User Administrator role in Azure AD
    - Domain Admin or appropriate read permissions in on-premises AD
    
    .INPUTS
    - Text file named "upn_list.txt" containing one UPN per line
    
    .OUTPUTS
    - CSV log file with timestamp in the filename
    - Console output with color-coded status messages
#>  

# Import required modules
Import-Module Microsoft.Graph.Users
Import-Module ActiveDirectory

# Function to convert ObjectGuid to ImmutableId
function Convert-ObjectGuidToImmutableId {
    param (
        [Parameter(Mandatory=$true)]
        [System.Guid]$ObjectGuid
    )
    return [System.Convert]::ToBase64String($ObjectGuid.ToByteArray())
}

# Connect to Microsoft Graph with required permissions (21V Mooncake)
Connect-MgGraph -Environment china -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All"

# Create single log file
$logFile = "HardMatch_Log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

# Function to write to log file
function Write-LogMessage {
    param(
        [string]$Message,
        [string]$Type  # Added Type parameter for categorizing messages
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - [$Type] $Message" | Out-File -FilePath $logFile -Append
}

# Read UPNs from a text file (one UPN per line)
$upnList = Get-Content -Path ".\upn_list.txt"

# Process each UPN
foreach ($upn in $upnList) {
    try {
        Write-LogMessage -Message "Processing UPN: $upn" -Type "INFO"
        
        # Get AD user and their ObjectGuid
        $adUser = Get-ADUser -Filter "UserPrincipalName -eq '$upn'" -Properties objectGuid -ErrorAction Stop
        if (-not $adUser) {
            throw "User not found in Active Directory"
        }
        
        $objectGuid = $adUser.objectGuid
        $immutableId = Convert-ObjectGuidToImmutableId -ObjectGuid $objectGuid
        
        # Get Azure AD user
        $userId = (Get-MgUser -Filter "UserPrincipalName eq '$upn'" -ErrorAction Stop).Id
        if (-not $userId) {
            throw "User not found in Azure AD"
        }
        
        # Prepare parameters for update
        $params = @{
            onPremisesImmutableId = $immutableId
        }
        
        # Update the user in Azure AD
        Update-MgUser -UserId $userId -BodyParameter $params -ErrorAction Stop
        
        # Log success
        $successMessage = "Successfully updated ImmutableID for $upn (ImmutableID: $immutableId)"
        Write-LogMessage -Message $successMessage -Type "SUCCESS"
        Write-Host $successMessage -ForegroundColor Green
    }
    catch {
        # Log error
        $errorMessage = "Error processing $upn - $($_.Exception.Message)"
        Write-LogMessage -Message $errorMessage -Type "ERROR"
        Write-Host $errorMessage -ForegroundColor Red
        continue
    }
}

# Disconnect from Microsoft Graph
Disconnect-MgGraph
Write-Host "`nProcessing complete. Check the log file: $logFile" -ForegroundColor Yellow