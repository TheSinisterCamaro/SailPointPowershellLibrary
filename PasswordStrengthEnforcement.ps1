# Import the Active Directory module
Import-Module ActiveDirectory

# Import a list of common weak passwords
$weakPasswords = Get-Content -Path "C:\WeakPasswords.txt"

# Get all users
$users = Get-ADUser -Filter * -Properties SamAccountName

foreach ($user in $users) {
    # Enforce password change
    Set-ADUser -Identity $user.SamAccountName -ChangePasswordAtLogon $true

    # Notify the user
    $to = $user.EmailAddress
    $subject = "Password Change Required"
    $body = "Dear $($user.Name),

For security reasons, you are required to change your password at the next logon.

Thank you."

    Send-MailMessage -To $to -Subject $subject -Body $body -SmtpServer "smtp.yourdomain.com"

    # Output the result
    Write-Host "Password change enforced for user: $($user.SamAccountName)"
}

# Output completion message
Write-Host "Password strength enforcement completed."
