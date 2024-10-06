# Import the Active Directory module
Import-Module ActiveDirectory

# Get all locked-out users
$lockedOutUsers = Search-ADAccount -LockedOut

foreach ($user in $lockedOutUsers) {
    # Unlock the user account
    Unlock-ADAccount -Identity $user.SamAccountName

    # Output the result
    Write-Host "Unlocked user: $($user.SamAccountName)"
}
