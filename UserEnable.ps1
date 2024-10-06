# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the text file containing usernames to enable
$userListPath = "C:\UsersToEnable.txt"

# Get the list of users
$usersToEnable = Get-Content -Path $userListPath

foreach ($user in $usersToEnable) {
    # Enable the user account
    Enable-ADAccount -Identity $user

    # Output the result
    Write-Host "Enabled user: $user"
}
