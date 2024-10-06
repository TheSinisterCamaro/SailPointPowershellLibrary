# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the text file containing usernames to disable
$userListPath = "C:\UsersToDisable.txt"

# Get the list of users
$usersToDisable = Get-Content -Path $userListPath

foreach ($user in $usersToDisable) {
    # Disable the user account
    Disable-ADAccount -Identity $user

    # Output the result
    Write-Host "Disabled user: $user"
}
