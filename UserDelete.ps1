# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the text file containing usernames to delete
$userListPath = "C:\UsersToDelete.txt"

# Get the list of users
$usersToDelete = Get-Content -Path $userListPath

foreach ($user in $usersToDelete) {
    # Disable the user account
    Disable-ADAccount -Identity $user

    # Optionally, remove the user account
    # Remove-ADUser -Identity $user -Confirm:$false

    # Output the result
    Write-Host "Disabled user: $user"
}
