# For Azure Active Directory Integration

# Install Azure AD module if not already installed
# Install-Module -Name AzureAD

# Import the Azure AD module
Import-Module AzureAD

# Connect to Azure AD
Connect-AzureAD -Credential (Get-Credential)

# Define the path to the CSV file containing user information
$csvPath = "C:\AzureUsers.csv"

# Import user data from CSV
$users = Import-Csv -Path $csvPath

foreach ($user in $users) {
    # Prepare user data
    $userParams = @{
        AccountEnabled    = $true
        DisplayName       = "$($user.FirstName) $($user.LastName)"
        MailNickname      = $user.MailNickname
        UserPrincipalName = "$($user.MailNickname)@yourdomain.onmicrosoft.com"
        PasswordProfile   = @{
            ForceChangePasswordNextLogin = $true
            Password                     = $user.Password
        }
    }

    # Create the user in Azure AD
    New-AzureADUser @userParams

    # Output the result
    Write-Host "Created Azure AD user: $($user.MailNickname)"
}

# Output completion message
Write-Host "Cloud service integration script completed."
