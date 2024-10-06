# Import the Active Directory module
Import-Module ActiveDirectory

# Path to the CSV file containing user accounts and new passwords
$csvPath = "C:\PasswordResets.csv"

# Import data from CSV
$passwordResets = Import-Csv -Path $csvPath

foreach ($reset in $passwordResets) {
    # Reset the user's password
    Set-ADAccountPassword -Identity $reset.SamAccountName -Reset -NewPassword (ConvertTo-SecureString $reset.NewPassword -AsPlainText -Force)

    # Optionally, force the user to change password at next logon
    Set-ADUser -Identity $reset.SamAccountName -ChangePasswordAtLogon $true

    # Output the result
    Write-Host "Reset password for user: $($reset.SamAccountName)"
}
