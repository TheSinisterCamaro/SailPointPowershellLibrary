# Import the Active Directory module
Import-Module ActiveDirectory

# Get all users with invalid email addresses (e.g., missing '@' symbol)
$usersWithInvalidEmail = Get-ADUser -Filter * -Properties EmailAddress | Where-Object {
    $_.EmailAddress -and ($_.EmailAddress -notmatch '@')
}

foreach ($user in $usersWithInvalidEmail) {
    # Clear the invalid email address
    Set-ADUser -Identity $user.SamAccountName -EmailAddress $null

    # Output the result
    Write-Host "Cleared invalid email for user: $($user.SamAccountName)"
}

# Output completion message
Write-Host "Data cleanup complete."
