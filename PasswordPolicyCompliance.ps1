# Import the Active Directory module
Import-Module ActiveDirectory

# Get the domain's password policy
$passwordPolicy = Get-ADDefaultDomainPasswordPolicy

# Get all user accounts
$users = Get-ADUser -Filter * -Properties SamAccountName, PasswordLastSet, PasswordNeverExpires, Enabled

# Initialize an array to store non-compliant users
$nonCompliantUsers = @()

foreach ($user in $users) {
    # Check if the password never expires
    if ($user.PasswordNeverExpires -eq $true) {
        $nonCompliantUsers += New-Object PSObject -Property @{
            UserName            = $user.SamAccountName
            Issue               = "Password Never Expires"
            PasswordLastSet     = $user.PasswordLastSet
        }
    }

    # Check if the password age exceeds maximum password age
    $passwordAge = (Get-Date) - $user.PasswordLastSet
    if ($passwordAge.TotalDays -gt $passwordPolicy.MaxPasswordAge.TotalDays) {
        $nonCompliantUsers += New-Object PSObject -Property @{
            UserName            = $user.SamAccountName
            Issue               = "Password Age Exceeds Max Password Age"
            PasswordLastSet     = $user.PasswordLastSet
        }
    }
}

# Export non-compliant users to a CSV file
$nonCompliantUsers | Export-Csv -Path "C:\PasswordPolicyNonComplianceReport.csv" -NoTypeInformation

# Output the result
Write-Host "Password policy compliance check complete. Report generated at C:\PasswordPolicyNonComplianceReport.csv"
