# Import the Active Directory module
Import-Module ActiveDirectory

# Define the notification period (e.g., passwords expiring in the next 7 days)
$notificationPeriod = 7

# Get users whose passwords will expire soon
$users = Get-ADUser -Filter * -Properties "msDS-UserPasswordExpiryTimeComputed", EmailAddress | Where-Object {
    $_."msDS-UserPasswordExpiryTimeComputed" -ne $null -and
    ([datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed") -le (Get-Date).AddDays($notificationPeriod))
}

foreach ($user in $users) {
    # Send reminder email
    $to = $user.EmailAddress
    $subject = "Password Expiry Reminder"
    $expiryDate = [datetime]::FromFileTime($user."msDS-UserPasswordExpiryTimeComputed")
    $body = "Dear $($user.Name),

Your password is set to expire on $expiryDate. Please change your password before it expires to avoid any disruption.

Thank you."

    $smtpServer = "smtp.yourdomain.com"
    Send-MailMessage -To $to -Subject $subject -Body $body -SmtpServer $smtpServer

    # Output the result
    Write-Host "Sent password expiry reminder to user: $($user.SamAccountName)"
}
