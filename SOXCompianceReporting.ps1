# Import the Active Directory module
Import-Module ActiveDirectory

# Get all privileged accounts (e.g., members of Domain Admins)
$privilegedGroup = "Domain Admins"
$privilegedUsers = Get-ADGroupMember -Identity $privilegedGroup -Recursive | Where-Object { $_.ObjectClass -eq 'user' }

# Initialize an array to store privileged user data
$privilegedUserData = @()

foreach ($user in $privilegedUsers) {
    $adUser = Get-ADUser -Identity $user.SamAccountName -Properties *
    $privilegedUserData += New-Object PSObject -Property @{
        UserName        = $adUser.SamAccountName
        DisplayName     = $adUser.Name
        Enabled         = $adUser.Enabled
        LastLogonDate   = $adUser.LastLogonDate
        WhenCreated     = $adUser.WhenCreated
        PasswordLastSet = $adUser.PasswordLastSet
    }
}

# Export the data to a CSV file
$reportPath = "C:\SOXComplianceReport.csv"
$privilegedUserData | Export-Csv -Path $reportPath -NoTypeInformation

# Output the result
Write-Host "SOX compliance report generated at $reportPath"
