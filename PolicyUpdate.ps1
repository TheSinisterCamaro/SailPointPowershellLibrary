# Import the Active Directory module
Import-Module ActiveDirectory

# Define new password policy settings
$newPasswordPolicy = @{
    MinPasswordLength            = 12
    PasswordHistoryCount         = 5
    MaxPasswordAge               = (New-TimeSpan -Days 90)
    MinPasswordAge               = (New-TimeSpan -Days 1)
    ComplexityEnabled            = $true
    ReversibleEncryptionEnabled  = $false
}

# Apply the new password policy
Set-ADDefaultDomainPasswordPolicy @newPasswordPolicy

# Output the result
Write-Host "Default domain password policy updated successfully."
