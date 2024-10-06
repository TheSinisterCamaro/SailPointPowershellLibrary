# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the text file containing usernames
$userListPath = "C:\UsersToChangePassword.txt"

# Get the list of users
$users = Get-Content -Path $userListPath

foreach ($user in $users) {
    # Force password change at next logon
    Set-ADUser -Identity $user -ChangePasswordAtLogon $true

    # Output the result
    Write-Host "Set password change at next logon for user: $user"
}
