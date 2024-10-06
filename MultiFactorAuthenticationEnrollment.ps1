# Install and import the Azure AD module if not already installed
# Install-Module -Name AzureAD
Import-Module AzureAD

# Connect to Azure AD
Connect-AzureAD -Credential (Get-Credential)

# Get all users who are not enrolled in MFA
$users = Get-AzureADUser -All $true | Where-Object {
    # Assume a function that checks MFA status
    -not (Get-MFAStatus -UserPrincipalName $_.UserPrincipalName)
}

foreach ($user in $users) {
    # Enforce MFA registration
    Set-AzureADUser -ObjectId $user.ObjectId -StrongAuthenticationRequirements @{
        "Enabled" = $true
        "State"   = "Enforced"
    }

    # Notify the user to complete MFA setup
    $to = $user.Mail
    $subject = "Multi-factor Authentication Enrollment"
    $body = "Dear $($user.DisplayName),

Please complete your multi-factor authentication setup by following the instructions provided.

Thank you."

    Send-MailMessage -To $to -Subject $subject -Body $body -SmtpServer "smtp.yourdomain.com"

    # Output the result
    Write-Host "MFA enrollment initiated for user: $($user.UserPrincipalName)"
}

# Output completion message
Write-Host "Multi-factor authentication enrollment completed."
